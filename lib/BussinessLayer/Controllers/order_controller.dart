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
  var loading = false.obs;
  HomeController homeController = Get.find<HomeController>();
  final accountsController = Get.find<AccountsController>();
  BoxClient boxClient = BoxClient();

  int convertOrderTypeToInt(String type) {
    switch (type) {
      case 'بيع للزبائن':
        return 0;
      case 'بيع مفرق':
        return 1;
      case 'مشتريات':
        return 2;
      case 'مردود بيع':
        return 3;
      case 'مردود شراء':
        return 4;
    }
    return 5;
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

  // Future<void> createOrder() async {
  //   if (true)
  //   // name.isNotEmpty &&
  //   {
  //     loading.value = true;
  //     var order = //await orderRepo.createOrder(id, total, notes, type, paidUp, restOfTheBill, wareId, toWareId, bankId, sellType, status, expenses, discount);
  //         loading.value = false;
  //     if (order != null) {
  //       homeController.getOrders();
  //       SnackBars.showSuccess('تم انشاء الطلب');
  //     } else {
  //       SnackBars.showError('فشل انشاء الطلب');
  //     }
  //   } else {
  //     SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
  //   }
  // }

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
    Account? counterParty, bank, marketer;
    Ware? ware;
    counterParty = await boxClient.getCounterPartyAccount();
    bank = await boxClient.getBankAccount();
    ware = await boxClient.getWareAccount();
    marketer = await boxClient.getMarketerAccount();
    if (counterParty == null && bank == null && ware == null) {
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
