import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
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
  TextEditingController expensesController = TextEditingController(text: '0.0');
  String discountType = "";
  TextEditingController discountOrderController = TextEditingController();
  String? status = "";
  TextEditingController notesController = TextEditingController();
  var totalProductsPrice = 0.0.obs;
  var expenses = 0.0.obs;
  var discountAmount = 0.0.obs;
  var totalOrderAmount = 0.0.obs;
  TextEditingController marketerDiscountController =
      TextEditingController(text: '0.0');
  String marketerDiscountType = "";
  TextEditingController paidAmountController =
      TextEditingController(text: '0.0');
  TextEditingController remainingAmountController = TextEditingController();
  RxDouble remainingAmount = 0.0.obs;
  List<Map<String, dynamic>> orderProducts = [];
  var loading = false.obs;
  var orderSaving = false;
  HomeController homeController = Get.find<HomeController>();
  final accountsController = Get.find<AccountsController>();
  BoxClient boxClient = BoxClient();

  String convertOrderType(String? type) {
    switch (type) {
      case 'بيع للزبائن':
        return 'sell_to_customers';
      case 'بيع مفرق':
        return 'retail_sale';
      case 'مشتريات':
        return 'purchases';
      case 'مردود بيع':
        return 'sales_return';
      case 'مردود شراء':
        return 'purchase_return';
      case 'نقل':
        return 'transfer';
    }
    return '';
  }

  String convertBuyingType(String? type) {
    switch (type) {
      case 'مباشر':
        return 'direct';
      case 'توصيل':
        return 'delivery';
      case 'شحن':
        return 'shipping';
    }
    return '';
  }

  int convertOrderStatusToInt(status) {
    switch (status) {
      case 'جاري التجهيز':
        return 0;
      case 'تم التسديد':
        return 1;
      case 'في شركة الشحن':
        return 2;
      case 'قيد التوصيل':
        return 3;
      case 'تامة':
        return 4;
    }
    return 5;
  }

  String converDiscountType(String discountType) {
    switch (discountType) {
      case 'رقم':
        return 'number';
      case 'نسبة':
        return 'percent';
    }
    return '';
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

  void setexpenses(expenses) {
    expensesController.value = TextEditingValue(text: expenses);
  }

  void setDiscountType(type) {
    discountType = type;
  }

  void setDiscountOrder(discount) {
    discountOrderController.value = TextEditingValue(text: discount);
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
    if (discountType == 'نسبة') {
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
    totalOrderAmount.value =
        totalProductsPrice.value - expenses.value - discountAmount.value;
  }

  void refreshOrderCalculations() {
    calculateTotalProductsPrice();
    calculateDiscountBasedOnType();
    calculateTotalOrderAmount();
  }

  void setMarketerDiscount(discount) {
    marketerDiscountController.value = TextEditingValue(text: discount);
  }

  void setMarketerDiscountType(type) {
    marketerDiscountType = type;
  }

  void calculateRemainingAmount(String paidAmount) {
    remainingAmount.value = paidAmount.isNotEmpty
        ? totalOrderAmount.value - double.parse(paidAmount)
        : totalOrderAmount.value;
    remainingAmountController.value =
        TextEditingValue(text: remainingAmount.toStringAsFixed(2));
  }

  Future<void> createOrder() async {
    String orderType = convertOrderType(type);
    num paidUp = num.parse(paidAmountController.text);
    String butyingType = convertBuyingType(buyingType);
    int orderStatus = convertOrderStatusToInt(status);
    int? marketerId = marketerAccount != null ? marketerAccount!.id : null;
    String discountOrderType = converDiscountType(discountType);
    String? discountMarketerType = marketerAccount != null
        ? converDiscountType(marketerDiscountType)
        : null;
    getOrderProductsMap();
    loading.value = true;
    var order = await orderRepo.createOrder(
        counterPartyAccount!.id,
        totalOrderAmount.value,
        notesController.text,
        orderType,
        paidUp,
        remainingAmount.value,
        wareAccount!.id,
        null,
        bankAccount!.id,
        butyingType,
        orderStatus,
        expenses.value,
        discountAmount.value,
        marketerId,
        discountOrderType,
        orderProducts,
        discountMarketerType);
    loading.value = false;
    if (order != null) {
      orderSaving = true;
      homeController.getOrders();
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

  // Future<void> updateOrder(int id) async {
  //   loading.value = true;
  //   var order = //await orderRepo.updateOrder();
  //       loading.value = false;
  //   if (order != null) {
  //     homeController.getOrders();
  //     SnackBars.showSuccess('تم التعديل بنجاح');
  //   } else {
  //     SnackBars.showError('فشل التعديل');
  //   }
  // }

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

  void setDefaultAccounts() async {
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
      ware = homeController.wares.firstWhere((w) => w.id == wareId);
      marketer = accountsController.getAccountFromId(marketerId);
    }
    setCounterPartyAccount(counterParty);
    setBankAccount(bank);
    setWare(ware);
    setMarketerAccount(marketer);
  }

  void setDefaultFields() {
    setDefaultAccounts();
    type = "بيع للزبائن";
    buyingType = "مباشر";
    status = "تامة";
    discountType = "رقم";
    marketerDiscountType = "رقم";
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
    status = "";
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

  @override
  void onInit() {
    accountsController.getClientsAndSupplierAccounts();
    accountsController.getMarketerAccounts();
    setDefaultFields();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
