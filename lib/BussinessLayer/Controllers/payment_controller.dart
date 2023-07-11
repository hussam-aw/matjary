import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class PaymentController extends GetxController {
  String? paymentType;
  TextEditingController bankController = TextEditingController();
  Account? bankAccount;
  TextEditingController counterPartyController = TextEditingController();
  Account? counterPartyAccount;
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  StatementRepo statementRepo = StatementRepo();
  AccountsController accountsController = Get.find<AccountsController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;

  Map<String, String> counterPaymentTypes = {
    'مقبوضات': 'income',
    'مدفوعات': 'payment',
  };

  void setPaymentType(type) {
    if (type != null) {
      paymentType = counterPaymentTypes[type]!;
    }
  }

  void setBankAccount(Account? account) {
    bankAccount = account;
    if (account != null) {
      bankController.value = TextEditingValue(text: account.name);
    }
  }

  void setCounterPartyAccount(Account? account) {
    counterPartyAccount = account;
    if (account != null) {
      counterPartyController.value = TextEditingValue(text: account.name);
    }
  }

  num getAmount() {
    return amountController.text.isEmpty ? 0 : num.parse(amountController.text);
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

  void setNotes(notes) {
    notesController.value = TextEditingValue(text: notes);
  }

  Future<void> createPayment() async {
    String bankId = bankAccount!.id.toString();
    String counterPartyId = counterPartyAccount!.id.toString();
    num amount = getAmount();
    String date = dateController.text;
    String notes = notesController.text;
    if (bankId.isNotEmpty && counterPartyId.isNotEmpty && date.isNotEmpty) {
      loading.value = true;
      var payment = await statementRepo.createPayment(
        paymentType,
        counterPartyAccount!.id,
        bankAccount!.id,
        notes,
        amount,
        date,
      );
      loading.value = false;
      if (payment != null) {
        boxClient.setCounterPartyAccount(counterPartyAccount!.id);
        boxClient.setBankAccount(bankAccount!.id);
        await accountsController.getAccounts();
        SnackBars.showSuccess('تم انشاء القيد الدفعة');
      } else {
        SnackBars.showError('فشل انشاء الدفعة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  void setDefaultAccounts() async {
    Account? bank, counterParty;
    int? bankId, counterPartyId;
    counterPartyId = await boxClient.getCounterPartyAccount();
    bankId = await boxClient.getBankAccount();
    counterParty = accountsController.getAccountFromId(counterPartyId);
    bank = accountsController.getAccountFromId(bankId);
    if (counterParty == null && bank == null) {
      counterParty = accountsController.accounts.isNotEmpty
          ? accountsController.accounts[0]
          : null;
      bankAccount = accountsController.accounts.isNotEmpty
          ? accountsController.bankAccounts[0]
          : null;
    }
    setCounterPartyAccount(counterParty);
    setBankAccount(bank);
  }

  void setDefaultFields() {
    setPaymentType('مقبوضات');
    setDefaultAccounts();
    setDate('');
  }

  @override
  void onInit() {
    setDefaultFields();
    super.onInit();
  }
}
