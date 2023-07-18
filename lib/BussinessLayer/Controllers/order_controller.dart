import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/BussinessLayer/helpers/pdf_helper.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/DataAccesslayer/Models/order_product.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/orders_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

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
  TextEditingController expensesController = TextEditingController(text: '0');
  String discountType = "";
  TextEditingController discountOrderController =
      TextEditingController(text: '0.0');
  int? status;
  TextEditingController notesController = TextEditingController();
  var totalProductsPrice = 0.0.obs;
  var expenses = 0.0.obs;
  var discountPercent = 0.0.obs;
  var discountNumber = 0.0.obs;
  var discountAmount = 0.0.obs;
  var totalOrderAmount = 0.0.obs;
  TextEditingController marketerDiscountController = TextEditingController();
  String marketerDiscountType = "";
  var marketerDiscountPercent = 0.0.obs;
  var marketerDiscountAmount = 0.0.obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();
  RxDouble remainingAmount = 0.0.obs;
  List<Map<String, dynamic>> orderProducts = [];
  var loading = false.obs;
  var orderSaving = false;
  HomeController homeController = Get.find<HomeController>();
  AccountsController accountsController = Get.find<AccountsController>();
  OrdersController ordersController = Get.find<OrdersController>();
  WaresController waresController = Get.find<WaresController>();
  BoxClient boxClient = BoxClient();
  PdfHelper pdfHelper = PdfHelper();

  int getOrderProductsQuantitiesCount(details) {
    int count = 0;
    for (OrderProduct product in details) {
      count += product.quantity;
    }
    return count;
  }

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
    expensesController.value = TextEditingValue(text: orderExpenses.toString());
  }

  void setDiscountType(type) {
    discountType = type;
  }

  void setDiscountOrder(discount) {
    if (discount != null) {
      discountType == 'percent'
          ? discountPercent.value = discount.toDouble()
          : discountNumber.value = discount.toDouble();
    }
    discountOrderController.value = TextEditingValue(
        text: discount == 0.0 ? '' : discount.toStringAsFixed(2));
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
      discountPercent.value = discountOrderController.text.isNotEmpty
          ? double.parse(discountOrderController.text)
          : 0.0;
      discountAmount.value =
          discountPercent.value * totalProductsPrice.value / 100;
    } else {
      discountNumber.value = discountOrderController.text.isNotEmpty
          ? double.parse(discountOrderController.text)
          : 0.0;
      discountAmount.value = discountNumber.value;
    }
  }

  void calculateTotalOrderAmount() {
    totalOrderAmount.value = 0.0;
    totalOrderAmount.value = totalProductsPrice.value - discountAmount.value;
    setRemainingAmount(totalProductsPrice.value);
  }

  void refreshOrderCalculations() {
    setPaidAmount(0);
    calculateRemainingAmount('0');
    calculateTotalProductsPrice();
    calculateDiscountBasedOnType();
    calculateTotalOrderAmount();
  }

  void setMarketerDiscountType(type) {
    marketerDiscountType = type;
  }

  void setMarketerDiscount(discount) {
    marketerDiscountController.value = TextEditingValue(
        text: discount == 0.0 ? '' : discount.toStringAsFixed(2));
  }

  void setMarketerDiscountBasedOnType(discount) {
    if (marketerDiscountType == 'percent') {
      marketerDiscountPercent.value = marketerDiscountController.text.isNotEmpty
          ? double.parse(marketerDiscountController.text)
          : 0.0;
    } else {
      marketerDiscountAmount.value = marketerDiscountController.text.isNotEmpty
          ? double.parse(marketerDiscountController.text)
          : 0.0;
    }
  }

  void setDate(String date) {
    if (date.isEmpty) {
      date =
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    }
    dateController.value = TextEditingValue(text: date);
  }

  void setTotalOrderAmount(total) {
    totalOrderAmount.value = total.toDouble();
  }

  void setPaidAmount(amount) {
    paidAmountController.value = TextEditingValue(text: amount.toString());
  }

  void setRemainingAmount(amount) {
    remainingAmountController.value =
        TextEditingValue(text: amount != 0.0 ? amount.toStringAsFixed(2) : '');
  }

  void calculateRemainingAmount(String paidAmount) {
    remainingAmount.value = paidAmount.isNotEmpty
        ? totalProductsPrice.value - double.parse(paidAmount)
        : totalProductsPrice.value;
    setRemainingAmount(remainingAmount.value);
  }

  num getPaidAmount() {
    return num.parse(paidAmountController.text);
  }

  int? getMarketerId() {
    return marketerAccount != null ? marketerAccount!.id : null;
  }

  String? getDiscountOrderType() {
    num dis = discountOrderController.text.isNotEmpty
        ? num.parse(discountOrderController.text)
        : 0.0;
    return dis != 0.0 ? discountType : null;
  }

  num? getDiscountOrder(discountOrderType) {
    return discountOrderType != null
        ? discountOrderType == 'percent'
            ? discountPercent.value
            : discountNumber.value
        : null;
  }

  String? getMarketerDiscountType() {
    return marketerAccount != null ? marketerDiscountType : null;
  }

  num? getMarketerDiscount(marketerDiscountType) {
    return marketerDiscountType != null
        ? marketerDiscountType == 'percent'
            ? marketerDiscountPercent.value
            : marketerDiscountAmount.value
        : null;
  }

  Future<void> createOrder() async {
    String? date = dateController.text;
    String? discountOrderType = getDiscountOrderType();
    num? discountOrder = getDiscountOrder(discountOrderType);
    int? marketerId = getMarketerId();
    String? discountMarketerType = getMarketerDiscountType();
    num? discountMarketer = getMarketerDiscount(discountMarketerType);
    num paidAmount = getPaidAmount();
    getOrderProductsMap();
    loading.value = true;
    var orderCreationStatus = await orderRepo.createOrder(
      counterPartyAccount!.id,
      totalOrderAmount.value,
      notesController.text,
      type,
      paidAmount,
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
      discountMarketer,
      date,
    );
    loading.value = false;
    if (orderCreationStatus == true) {
      orderSaving = true;
      await ordersController.getOrders();
      await accountsController.getAccounts();
      saveSelectedAccountsInStorage();
      SnackBars.showSuccess('تم انشاء الطلب');
    } else {
      SnackBars.showError('فشل انشاء الطلب');
    }
  }

  Future<void> updateOrder(int id) async {
    String? date = dateController.text;
    String? discountOrderType = getDiscountOrderType();
    num? discountOrder = getDiscountOrder(discountOrderType);
    int? marketerId = getMarketerId();
    String? discountMarketerType = getMarketerDiscountType();
    num? discountMarketer = getMarketerDiscount(marketerDiscountType);
    num? paidAmount = getPaidAmount();
    getOrderProductsMap();
    loading.value = true;
    var orderUpdationStatus = await orderRepo.updateOrder(
        id,
        counterPartyAccount!.id,
        totalOrderAmount.value,
        notesController.text,
        type,
        paidAmount,
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
        discountMarketer,
        date);
    loading.value = false;
    if (orderUpdationStatus == true) {
      orderSaving = true;
      await ordersController.getOrders();
      await accountsController.getAccounts();
      saveSelectedAccountsInStorage();
      SnackBars.showSuccess('تم التعديل بنجاح');
    } else {
      SnackBars.showError('فشل التعديل');
    }
  }

  Future<void> deleteOrder(id) async {
    loading.value = true;
    var order = await orderRepo.deleteOrder(id);
    loading.value = false;
    if (order != null) {
      await ordersController.getOrders();
      await accountsController.getAccounts();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }

  Future<void> saveOrderToPdf(widget) async {
    await PdfHelper.getPrintFont();
    bool successSaving = await pdfHelper.createPdf(widget);
    if (successSaving) {
      SnackBars.showSuccess('تم الحفظ بنجاح');
    } else {
      SnackBars.showError('فشل الحفظ');
    }
  }

  void saveSelectedAccountsInStorage() {
    boxClient.setCounterPartyAccount(counterPartyAccount!.id);
    boxClient.setBankAccount(bankAccount!.id);
    boxClient.setWareAccount(wareAccount!.id);
    if (marketerAccount != null) {
      boxClient.setMarketerAccount(marketerAccount!.id);
    }
  }

  Future<void> setDefaultAccounts() async {
    int? counterPartyId, bankId, wareId, marketerId;
    Account? counterParty, bank, marketer;
    Ware? ware;
    counterPartyId = await boxClient.getCounterPartyAccount();
    bankId = await boxClient.getBankAccount();
    wareId = await boxClient.getWareAccount();
    marketerId = await boxClient.getMarketerAccount();
    if (counterPartyId == null && bankId == null && wareId == null) {
      counterParty = accountsController.customersAccounts.isNotEmpty
          ? accountsController.customersAccounts[0]
          : null;
      bank = accountsController.bankAccounts.isNotEmpty
          ? accountsController.bankAccounts[0]
          : null;
      ware = waresController.wares.isNotEmpty ? waresController.wares[0] : null;
      marketer = accountsController.marketerAccounts.isNotEmpty
          ? accountsController.marketerAccounts[0]
          : null;
    } else {
      counterParty = accountsController.getAccountFromId(counterPartyId);
      bank = accountsController.getAccountFromId(bankId);
      ware = waresController.getWareFromId(wareId);
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
    setStatus(4);
    setexpenses(0);
    setDiscountType("number");
    setDiscountOrder(0.0);
    setMarketerDiscountType("number");
    setMarketerDiscount(0.0);
    setPaidAmount(0);
  }

  void resetOrder() {
    type = "";
    setCounterPartyAccount(null);
    setBankAccount(null);
    setWare(null);
    setMarketerAccount(null);
    orderProductsQuantities.clear();
    orderProductsPrices.clear();
    selectedProducts.clear();
    buyingType = "";
    setexpenses(0.0);
    discountType = "";
    setDiscountOrder(0.0);
    setStatus(4);
    setNotes('');
    totalProductsPrice = 0.0.obs;
    setTotalOrderAmount(0.0);
    setMarketerDiscount(0.0);
    marketerDiscountType = "";
    setPaidAmount(0.0);
    setRemainingAmount(0.0);
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
      setWare(waresController.getWareFromId(order.wareId));
      setMarketerAccount(accountsController.getAccountFromId(order.marketerId));
      calculateTotalProductsPrice();
      setBuyingType(order.sellType);
      setexpenses(order.expenses);
      setDiscountType(order.discountType);
      setDiscountOrder(order.discount);
      calculateDiscountBasedOnType();
      setStatus(order.status);
      setNotes(order.notes);
      setMarketerDiscountType(order.marketerFeeType);
      setMarketerDiscount(order.marketerFee);
      setMarketerDiscountBasedOnType(order.marketerFee);
      calculateTotalOrderAmount();
      setPaidAmount(order.paidUp);
      calculateRemainingAmount(order.paidUp.toString());
    }
  }

  @override
  void onInit() {
    // accountsController.getCustomersAccounts();
    // accountsController.getMarketerAccounts();
    super.onInit();
  }
}
