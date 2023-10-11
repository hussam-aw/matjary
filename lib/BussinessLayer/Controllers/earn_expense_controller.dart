import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/earns_expenses_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/DataAccesslayer/Repositories/earns_expenses_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class EarnExpenseController extends GetxController {
  String? statementType;
  TextEditingController statementTextController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  int? bankAccountId;
  TextEditingController dateController = TextEditingController();
  AccountsController accountsController = Get.find<AccountsController>();
  EarnsExpensesRepo earnsExpensesRepo = EarnsExpensesRepo();
  EarnsExpensesController earnsExpensesController =
      Get.find<EarnsExpensesController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;
  var savingState = false;
  final connectivityController = Get.find<ConnectivityController>();

  Map<String, String> counterStatementTypes = {
    'إيرادات': 'revenues',
    'مصاريف': 'expenses',
  };

  void setCounterStatementType(type) {
    if (type != null) {
      statementType = counterStatementTypes[type]!;
    }
  }

  void setStatementType(type) {
    if (type != null) {
      statementType = type;
    }
  }

  void setStatementText(statementText) {
    if (statementText.isNotEmpty) {
      statementTextController.value = TextEditingValue(text: statementText);
    } else {
      statementTextController.clear();
    }
  }

  String getStatementText() {
    return statementTextController.text;
  }

  void setAmount(amount) {
    if (amount != null) {
      amountController.value = TextEditingValue(text: amount.toString());
    } else {
      amountController.clear();
    }
  }

  num getAmount() {
    return amountController.text.isEmpty ? 0 : num.parse(amountController.text);
  }

  void setBankAccount(Account? account) {
    if (account != null) {
      bankAccountId = account.id;
      bankController.value = TextEditingValue(text: account.name);
    } else {
      bankController.clear();
    }
  }

  int? getBankAccountId() {
    return bankAccountId;
  }

  String getDateString(date) {
    if (date.isEmpty) {
      return DateFormatter.getCurrentDateString();
    }
    return date;
  }

  void setDate(date) {
    if (date.isNotEmpty) {
      dateController.value = TextEditingValue(text: date);
    } else {
      dateController.value =
          TextEditingValue(text: DateFormatter.getCurrentDateString());
    }
  }

  String getDate() {
    return dateController.text;
  }

  void setDefaultAccounts(clear) async {
    if (!clear) {
      Account? bank;
      int? bankId;
      bankId = await boxClient.getBankAccount();
      bank = accountsController.getAccountFromId(bankId);
      bank ??= accountsController.accounts.isNotEmpty
          ? accountsController.bankAccounts[0]
          : null;
      setBankAccount(bank);
    } else {
      setBankAccount(null);
    }
  }

  void setDefaultFields({bool clear = false, StatementWithType? statement}) {
    if (statement != null) {
      setStatementType(statement.type);
      setBankAccount(accountsController.getAccountFromId(statement.bankId));
      setAmount(statement.amount);
      setDate(DateFormatter.getFormated(statement.createdAt));
      setStatementText(statement.statement);
    } else {
      setCounterStatementType('إيرادات');
      setDefaultAccounts(clear);
      setAmount(null);
      setDate('');
      setStatementText('');
    }
  }

  Future<void> createStatementBasedOnType() async {
    savingState = false;
    String statementText = getStatementText();
    num amount = getAmount();
    int? bankId = getBankAccountId();
    String date = getDate();
    bool connected = connectivityController.isConnected;
    if (bankId != null && date.isNotEmpty) {
      loading.value = true;
      bool isStatementCreated =
          await earnsExpensesRepo.createStatementBsedOnType(
        connected,
        statementType,
        statementText,
        amount,
        bankId,
        date,
      );
      loading.value = false;
      if (isStatementCreated) {
        boxClient.setBankAccount(bankId);
        if (connected) {
          await accountsController.getAccounts();
          await earnsExpensesController.getEarnsAndExpenses();
        }
        savingState = true;
        setDefaultFields(clear: true);
        SnackBars.showSuccess('تم انشاء القيد');
      } else {
        SnackBars.showError('فشل انشاء القيد');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updateStatement(id) async {
    savingState = false;
    String statementText = getStatementText();
    num amount = getAmount();
    int? bankId = getBankAccountId();
    String date = getDate();
    if (bankId != null && date.isNotEmpty) {
      if (connectivityController.isConnected) {
        loading.value = true;
        var statement = await earnsExpensesRepo.updateStatement(
          id,
          statementType,
          statementText,
          amount,
          bankId,
          date,
        );
        loading.value = false;
        if (statement != null) {
          await earnsExpensesController.getEarnsAndExpenses();
          savingState = true;
          SnackBars.showSuccess('تم تعديل القيد');
        } else {
          SnackBars.showError('فشل تعديل القيد');
        }
      } else {
        SnackBars.showError('لا يوجد اتصال بالانترنت');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> deleteStatement(id) async {
    if (connectivityController.isConnected) {
      loading.value = true;
      bool isStatementDeleted = await earnsExpensesRepo.deleteStatement(id);
      loading.value = false;
      if (isStatementDeleted) {
        earnsExpensesController.getEarnsAndExpenses();
        SnackBars.showSuccess('تم الحذف بنجاح');
      } else {
        SnackBars.showError('فشل الحذف');
      }
    } else {
      SnackBars.showError('لا يوجد اتصال بالانترنت');
    }
  }
}
