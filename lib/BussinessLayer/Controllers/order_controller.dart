import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';
import 'package:matjary/main.dart';

class OrderController extends GetxController {
  OrdersRepo orderRepo = OrdersRepo();
  String? type = "";
  TextEditingController counterPartyController = TextEditingController();
  Account? counterPartyAccount;
  TextEditingController bankController = TextEditingController();
  Account? bankAccount;
  TextEditingController wareController = TextEditingController();
  Ware? wareAccount;
  TextEditingController marketerController = TextEditingController();
  Account? marketerAccount;
  Map<int, int> orderProductsQuantities = {};
  Map<int, num> orderProductsPrices = {};
  List<Product> selectedProducts = [];
  String buyingType = "";
  TextEditingController expensesController = TextEditingController();
  String discountType = "";
  TextEditingController discountOrderController =
      TextEditingController(text: '0.0');
  int? status;
  TextEditingController notesController = TextEditingController();
  var totalProductsPrice = 0.0.obs;
  var expenses = 0.0.obs;
  var discountPercent = 0.0.obs;
  var discountAmount = 0.0.obs;
  var totalOrderAmount = 0.0.obs;
  TextEditingController marketerDiscountController = TextEditingController();
  String marketerDiscountType = "";
  TextEditingController paidAmountController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();
  RxDouble remainingAmount = 0.0.obs;
  List<Map<String, dynamic>> orderProducts = [];
  var loading = false.obs;
  var orderSaving = false;
  HomeController homeController = Get.find<HomeController>();
  AccountsController accountsController = Get.find<AccountsController>();
  OrdersController ordersController = Get.find<OrdersController>();
  BoxClient boxClient = BoxClient();

  void getOrderProductsMap() {
    for (Product product in selectedProducts) {
      orderProducts.add({
        "product_id": product.id,
        "qty": orderProductsQuantities[product.id],
        "price": orderProductsPrices[product.id],
      });
    }
  }

  void setOrderType(orderType) {
    type = orderType;
  }

  void setCounterPartyAccount(Account? account) {
    counterPartyAccount = account;
    counterPartyController.value =
        TextEditingValue(text: account != null ? account.name : '');
  }

  void setBankAccount(Account? account) {
    bankAccount = account;
    bankController.value =
        TextEditingValue(text: account != null ? account.name : '');
  }

  void setWare(Ware? ware) {
    wareAccount = ware;
    wareController.value =
        TextEditingValue(text: ware != null ? ware.name : '');
  }

  void setMarketerAccount(Account? account) {
    marketerAccount = account;
    marketerController.value =
        TextEditingValue(text: account != null ? account.name : '');
  }

  void setSelectedProducts(products) {
    selectedProducts = products;
  }

  void setProductsQuantities(quantities) {
    orderProductsQuantities = quantities;
  }

  void setProductsPrices(prices) {
    orderProductsPrices = prices;
  }

  void setBuyingType(type) {
    buyingType = type;
  }

  void setexpenses(orderExpenses) {
    expenses.value = orderExpenses.toDouble();
    expensesController.value =
        TextEditingValue(text: orderExpenses.toStringAsFixed(2));
  }

  void setDiscountType(type) {
    discountType = type;
  }

  void setDiscountOrder(discount) {
    discountAmount.value = discount;
    discountOrderController.value =
        TextEditingValue(text: discount.toStringAsFixed(2));
  }

  void setStatus(orderStatus) {
    status = orderStatus;
  }

  void setNotes(notes) {
    notesController.value = TextEditingValue(text: notes);
  }

  void calculateTotalProductsPrice() {
    totalProductsPrice.value = 0.0;
    for (Product product in selectedProducts) {
      totalProductsPrice.value += orderProductsPrices[product.id]! *
          orderProductsQuantities[product.id]!;
    }
  }

  void convertExpensesToDouble(String orderExpenses) {
    expenses.value =
        orderExpenses.isNotEmpty ? double.parse(orderExpenses) : 0.0;
  }

  void calculateDiscountBasedOnType() {
    if (discountType == 'percent') {
      discountPercent.value = double.parse(discountOrderController.text);
      discountAmount.value = discountOrderController.text.isNotEmpty
          ? double.parse(discountOrderController.text) *
              totalProductsPrice.value /
              100
          : 0.0;
    } else {
      discountAmount.value = discountOrderController.text.isNotEmpty
          ? double.parse(discountOrderController.text)
          : 0.0;
    }
  }

  void calculateTotalOrderAmount() {
    totalOrderAmount.value = 0.0;
    totalOrderAmount.value = totalProductsPrice.value - discountAmount.value;
  }

  void refreshOrderCalculations() {
    calculateTotalProductsPrice();
    calculateDiscountBasedOnType();
    calculateTotalOrderAmount();
  }

  void setMarketerDiscount(discount) {
    marketerDiscountController.value =
        TextEditingValue(text: discount.toStringAsFixed(2));
  }

  void setMarketerDiscountType(type) {
    marketerDiscountType = type;
  }

  void setTotalOrderAmount(total) {
    totalOrderAmount.value = total.toDouble();
  }

  void setPaidAmount(amount) {
    paidAmountController.value = TextEditingValue(text: amount.toString());
  }

  void setRemainingAmount(amount) {
    remainingAmountController.value =
        TextEditingValue(text: amount.toStringAsFixed(2));
  }

  void calculateRemainingAmount(String paidAmount) {
    remainingAmount.value = paidAmount.isNotEmpty
        ? totalOrderAmount.value - double.parse(paidAmount)
        : totalOrderAmount.value;
    setRemainingAmount(remainingAmount.value);
  }

  Future<void> createOrder() async {
    num paidUp = num.parse(paidAmountController.text);
    int? marketerId = marketerAccount != null ? marketerAccount!.id : null;
    String? discountOrderType =
        num.parse(discountOrderController.text) != 0.0 ? discountType : null;
    num? discountOrder = num.parse(discountOrderController.text) != 0.0
        ? discountOrderType == 'percent'
            ? discountPercent.value
            : discountAmount.value
        : null;
    String? discountMarketerType =
        marketerAccount != null ? marketerDiscountType : null;
    num? discountMarketer = marketerAccount != null
        ? num.parse(marketerDiscountController.text)
        : null;
    getOrderProductsMap();
    loading.value = true;
    var orderCreationStatus = await orderRepo.createOrder(
        counterPartyAccount!.id,
        totalOrderAmount.value,
        notesController.text,
        type,
        paidUp,
        remainingAmount.value,
        wareAccount!.id,
        null,
        bankAccount!.id,
        buyingType,
        status,
        expenses.value,
        discountOrder,
        marketerId,
        discountOrderType,
        orderProducts,
        discountMarketerType,
        discountMarketer);
    loading.value = false;
    if (orderCreationStatus == true) {
      orderSaving = true;
      ordersController.getOrders();
      boxClient.setCounterPartyAccount(counterPartyAccount!.id);
      boxClient.setBankAccount(bankAccount!.id);
      boxClient.setWareAccount(wareAccount!.id);
      if (marketerAccount != null) {
        boxClient.setMarketerAccount(marketerAccount!.id);
      }
      SnackBars.showSuccess('تم انشاء الطلب');
    } else {
      SnackBars.showError('فشل انشاء الطلب');
    }
  }

  Future<void> updateOrder(int id) async {
    num paidUp = num.parse(paidAmountController.text);
    int? marketerId = marketerAccount != null ? marketerAccount!.id : null;
    String? discountOrderType =
        num.parse(discountOrderController.text) != 0.0 ? discountType : null;
    num? discountOrder = num.parse(discountOrderController.text) != 0.0
        ? discountOrderType == 'percent'
            ? discountPercent.value
            : discountAmount.value
        : null;
    String? discountMarketerType =
        marketerAccount != null ? marketerDiscountType : null;

    num? discountMarketer = marketerAccount != null
        ? num.parse(marketerDiscountController.text)
        : null;
    getOrderProductsMap();
    loading.value = true;
    var orderUpdationStatus = await orderRepo.updateOrder(
        id,
        counterPartyAccount!.id,
        totalOrderAmount.value,
        notesController.text,
        type,
        paidUp,
        remainingAmount.value,
        wareAccount!.id,
        null,
        bankAccount!.id,
        buyingType,
        status,
        expenses.value,
        discountOrder,
        marketerId,
        discountOrderType,
        orderProducts,
        discountMarketerType,
        discountMarketer);
    loading.value = false;
    if (orderUpdationStatus == true) {
      orderSaving = true;
      ordersController.getOrders();
      boxClient.setCounterPartyAccount(counterPartyAccount!.id);
      boxClient.setBankAccount(bankAccount!.id);
      boxClient.setWareAccount(wareAccount!.id);
      if (marketerAccount != null) {
        boxClient.setMarketerAccount(marketerAccount!.id);
      }
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  // Future<void> deleteOrder(id) async {
  //   loading.value = true;
  //   var order = await orderRepo.deleteOrder(id);
  //   loading.value = false;
  //   if (order != null) {
  //     homeController.getOrders();
  //     SnackBars.showSuccess('تم الحذف بنجاح');
  //   } else {
  //     SnackBars.showError('فشل الحذف');
  //   }
  // }

  Future<void> setDefaultAccounts() async {
    int? counterPartyId, bankId, wareId, marketerId;
    Account? counterParty, bank, marketer;
    Ware? ware;
    counterPartyId = await boxClient.getCounterPartyAccount();
    bankId = await boxClient.getBankAccount();
    wareId = await boxClient.getWareAccount();
    marketerId = await boxClient.getMarketerAccount();
    if (counterPartyId == null && bankId == null && wareId == null) {
      counterParty = accountsController.clientAndSupplierAccounts.isNotEmpty
          ? accountsController.clientAndSupplierAccounts[0]
          : null;
      bank = accountsController.bankAccounts.isNotEmpty
          ? accountsController.bankAccounts[0]
          : null;
      ware = homeController.wares.isNotEmpty ? homeController.wares[0] : null;
      marketer = accountsController.marketerAccounts.isNotEmpty
          ? accountsController.marketerAccounts[0]
          : null;
    } else {
      counterParty = accountsController.getAccountFromId(counterPartyId);
      bank = accountsController.getAccountFromId(bankId);
      ware = homeController.wares.firstWhereOrNull((w) => w.id == wareId);
      marketer = accountsController.getAccountFromId(marketerId);
    }
    setCounterPartyAccount(counterParty);
    setBankAccount(bank);
    setWare(ware);
    setMarketerAccount(marketer);
  }

  Future<void> setDefaultFields() async {
    await setDefaultAccounts();
    setOrderType("sell_to_customers");
    setBuyingType("direct");
    setStatus(0);
    setexpenses(0.0);
    setDiscountType("");
    setDiscountOrder(0.0);
    setMarketerDiscountType("");
    setMarketerDiscount(0.0);
  }

  void resetOrder() {
    type = "";
    counterPartyController.value = const TextEditingValue();
    counterPartyAccount = null;
    bankController.value = const TextEditingValue();
    bankAccount = null;
    wareController.value = const TextEditingValue();
    wareAccount = null;
    marketerController.value = const TextEditingValue();
    marketerAccount = null;
    orderProductsQuantities.clear();
    orderProductsPrices.clear();
    selectedProducts.clear();
    buyingType = "";
    expensesController.value = const TextEditingValue(text: '0.0');
    discountType = "";
    discountOrderController.value = const TextEditingValue();
    status = 0;
    notesController.value = const TextEditingValue();
    totalProductsPrice = 0.0.obs;
    expenses = 0.0.obs;
    discountAmount = 0.0.obs;
    totalOrderAmount = 0.0.obs;
    marketerDiscountController.value = const TextEditingValue();
    marketerDiscountType = "";
    paidAmountController.value = const TextEditingValue(text: '0.0');
    remainingAmountController.value = const TextEditingValue();
    remainingAmount = 0.0.obs;
    loading = false.obs;
    orderSaving = false;
  }

  void initializeOrderDetails(Order? order) async {
    await setDefaultFields();
    if (order != null) {
      setOrderType(order.type);
      setCounterPartyAccount(
          accountsController.getAccountFromId(order.customerId));
      setBankAccount(accountsController.getAccountFromId(order.bankId));
      setWare(
          homeController.wares.firstWhereOrNull((w) => w.id == order.wareId));
      setMarketerAccount(accountsController.getAccountFromId(order.marketerId));
      setBuyingType(order.sellType);
      setexpenses(order.expenses);
      setDiscountType(order.discountType);
      order.discountType.isNotEmpty
          ? setDiscountOrder(order.discount)
          : setDiscountOrder(0.0);
      calculateDiscountBasedOnType();
      setStatus(order.status);
      order.notes.isNotEmpty ? setNotes(order.notes) : setNotes('');
      setMarketerDiscountType(order.marketerFeeType);
      order.marketerFeeType.isNotEmpty
          ? setMarketerDiscount(order.marketerFee)
          : setMarketerDiscount(0.0);
      calculateTotalProductsPrice();
      setTotalOrderAmount(order.total);
      setPaidAmount(order.paidUp);
      setRemainingAmount(order.restOfTheBill);
    }
  }

  @override
  void onInit() {
    accountsController.getClientsAndSupplierAccounts();
    accountsController.getMarketerAccounts();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
