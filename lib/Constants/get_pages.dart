import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Bindings/home_binding.dart';
import 'package:matjary/PresentationLayer/Auth/login_screen.dart';
import 'package:matjary/PresentationLayer/Auth/pin_code_screen.dart';
import 'package:matjary/PresentationLayer/Auth/register_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/create_ware_report_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/product_movement_report_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/product_qty_report_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/product_report_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/reports_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/single_ware_report_screen.dart';
import 'package:matjary/PresentationLayer/Private/Reports/wares_report_screen.dart';
import 'package:matjary/PresentationLayer/Private/Settings/settings_screen.dart';
import 'package:matjary/PresentationLayer/Private/Settings/store_icon_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/AccountStatements/account_statement_print_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/AccountStatements/account_statement_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/AccountStatements/account_statement_type_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/EarnsExpenses/create_earn_expense_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/EarnsExpenses/earns_expenses_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/Payments/create_edit_payment_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/Payments/payments_screen.dart';
import 'package:matjary/PresentationLayer/Private/Statements/create_statement.dart';
import 'package:matjary/PresentationLayer/Private/choose_account_screen.dart';
import 'package:matjary/PresentationLayer/Private/choose_category_screen.dart';
import 'package:matjary/PresentationLayer/Private/choose_product_screen.dart';
import 'package:matjary/PresentationLayer/Private/choose_user_screen.dart';
import 'package:matjary/PresentationLayer/Private/choose_ware_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_account_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_category_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_product_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_user_screen.dart';
import 'package:matjary/PresentationLayer/Private/create_edit_ware.dart';
import 'package:matjary/PresentationLayer/Private/notifications_screen.dart';
import 'package:matjary/PresentationLayer/Private/orders/create_edit_order/create_edit_order_screen.dart';
import 'package:matjary/PresentationLayer/Private/orders/create_edit_order/select_products_screen.dart';
import 'package:matjary/PresentationLayer/Private/orders/order_details_screen.dart';
import 'package:matjary/PresentationLayer/Private/orders/order_print_screen.dart';
import 'package:matjary/PresentationLayer/Private/orders/order_screen.dart';
import 'package:matjary/PresentationLayer/Private/orders/orders_screen.dart';
import 'package:matjary/PresentationLayer/Private/profile_screen.dart';
import 'package:matjary/PresentationLayer/Public/home_screen.dart';
import 'package:matjary/PresentationLayer/Public/introduction.dart';

import '../PresentationLayer/Public/splash_screen.dart';
import 'get_routes.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
  GetPage(name: AppRoutes.introScreen, page: () => const OnBoardingPage()),
  GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
  GetPage(name: AppRoutes.registerScreen, page: () => const RegisterScreen()),
  GetPage(name: AppRoutes.pinCodeScreen, page: () => const PinCodeScreen()),
  GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBindings()),
  GetPage(
      name: AppRoutes.createEditAccountScreen,
      page: () => CreateEditAccountScreen()),
  GetPage(
      name: AppRoutes.createEditWareScreen, page: () => CreateEditWareScreen()),
  GetPage(
      name: AppRoutes.createEditProductScreen,
      page: () => CreateEditProductScreen()),
  GetPage(
      name: AppRoutes.createEditCategoryScreen,
      page: () => CreateEditCategoryScreen()),
  GetPage(
      name: AppRoutes.createStatementScreen,
      page: () => CreateStatementScreen()),
  GetPage(
      name: AppRoutes.chooseAccountScreen, page: () => ChooseAccountScreen()),
  GetPage(name: AppRoutes.chooseWareScreen, page: () => ChooseWareScreen()),
  GetPage(
      name: AppRoutes.chooseProductScreen, page: () => ChooseProductScreen()),
  GetPage(
      name: AppRoutes.chooseCategoryScreen, page: () => ChooseCategoryScreen()),
  GetPage(
      name: AppRoutes.createEditOrderScreen,
      page: () => CreateEditOrderScreen()),
  GetPage(name: AppRoutes.selectProducts, page: () => SelectProductsScreen()),
  GetPage(name: AppRoutes.ordersScreen, page: () => OrdersScreen()),
  GetPage(name: AppRoutes.orderScreen, page: () => OrderScreen()),
  GetPage(name: AppRoutes.orderPrintScreen, page: () => OrderPrintScreen()),
  GetPage(name: AppRoutes.orderDetailsScreen, page: () => OrderDetailsScreen()),
  GetPage(
      name: AppRoutes.createEditPaymentScreen,
      page: () => CreateEditPaymentScreen()),
  GetPage(name: AppRoutes.paymentsScreen, page: () => PaymentsScreen()),
  GetPage(
      name: AppRoutes.productReportScreen,
      page: () => const ProductReportScreen()),
  GetPage(
      name: AppRoutes.createWareReportScreen,
      page: () => CreateWareReportScreen()),
  GetPage(
      name: AppRoutes.singleWareReportScreen,
      page: () => SingleWareReportScreen()),
  GetPage(name: AppRoutes.waresReportScreen, page: () => WaresReportScreen()),
  GetPage(
      name: AppRoutes.productQtyReportScreen,
      page: () => ProductQtyReportScreen()),
  GetPage(
      name: AppRoutes.productMovementReportScreen,
      page: () => ProductMovementReportScreen()),
  GetPage(name: AppRoutes.profileScreen, page: () => ProfileScreen()),
  GetPage(
      name: AppRoutes.accountStatementTypeScreen,
      page: () => AccountStatementTypeScreen()),
  GetPage(
      name: AppRoutes.accountStatementScreen,
      page: () => AccountStatementScreen()),
  GetPage(
      name: AppRoutes.accountStatementPrintScreen,
      page: () => AccountStatementPrintScreen()),
  GetPage(
      name: AppRoutes.createEarnExpenseScreen,
      page: () => CreateEarnExpenseScreen()),
  GetPage(
      name: AppRoutes.earnsExpensesScreen, page: () => EarnsExpensesScreen()),
  GetPage(
      name: AppRoutes.createEditUserScreen, page: () => CreateEditUserScreen()),
  GetPage(name: AppRoutes.chooseUserScreen, page: () => ChooseUserScreen()),
  GetPage(name: AppRoutes.settingsScreen, page: () => SettingsScreen()),
  GetPage(name: AppRoutes.storeIconScreen, page: () => StoreIconScreen()),
  GetPage(
      name: AppRoutes.notificationsScreen,
      page: () => const NotificationsScreen(),
      transition: Transition.circularReveal),
  GetPage(
      name: AppRoutes.reportsScreen,
      page: () => const ReportsScreen(),
      transition: Transition.leftToRightWithFade),
];
