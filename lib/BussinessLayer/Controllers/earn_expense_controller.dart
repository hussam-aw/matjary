import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/earns_expenses_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class EarnExpenseController extends GetxController {
  String? statementType;
  TextEditingController statementTextController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  Account? bankAccount;
  TextEditingController dateController = TextEditingController();
  AccountsController accountsController = Get.find<AccountsController>();
  EarnsExpensesRepo earnsExpensesRepo = EarnsExpensesRepo();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;

  Map<String, String> counterStatementTypes = {
    'إيرادات': 'revenues',
    'مصاريف': 'expenses',
  };

  void setStatementType(type) {
    if (type != null) {
      statementType = counterStatementTypes[type]!;
    }
  }

  void setStatementText(statementText) {
    statementTextController.value = TextEditingValue(text: statementText);
  }

  num getAmount() {
    return amountController.text.isEmpty ? 0 : num.parse(amountController.text);
  }

  void setBankAccount(Account? account) {
    bankAccount = account;
    if (account != null) {
      bankController.value = TextEditingValue(text: account.name);
    }
  }

  String getDateString(date) {
    if (date.isEmpty) {
      return DateFormatter.getCurrentDateString();
    }
    return date;
  }

  void setDate(date) {
    dateController.value = TextEditingValue(text: getDateString(date));
  }

  Future<void> createStatementBasesOnType() async {
    String statementText = statementTextController.text;
    num amount = getAmount();
    String bankId = bankAccount!.id.toString();
    String date = dateController.text;
    if (bankId.isNotEmpty && date.isNotEmpty) {
      loading.value = true;
      var statement = await earnsExpensesRepo.createStatementBsedOnType(
        statementType,
        statementText,
        amount,
        bankAccount!.id,
        date,
      );
      loading.value = false;
      if (statement != null) {
        boxClient.setBankAccount(bankAccount!.id);
        await accountsController.getAccounts();
        SnackBars.showSuccess('تم انشاء القيد');
      } else {
        SnackBars.showError('فشل انشاء الدفعة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  void setDefaultAccounts() async {
    Account? bank;
    int? bankId;
    bankId = await boxClient.getBankAccount();
    bank = accountsController.getAccountFromId(bankId);
    if (bank == null) {
      bankAccount = accountsController.accounts.isNotEmpty
          ? accountsController.bankAccounts[0]
          : null;
    }
    setBankAccount(bank);
  }

  void setDefaultFields() {
    setStatementType('إيرادات');
    setDefaultAccounts();
    setDate('');
  }

  @override
  void onInit() {
    setDefaultFields();
    super.onInit();
  }
}
