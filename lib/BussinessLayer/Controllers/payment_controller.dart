import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class PaymentController extends GetxController {
  String paymentType = 'income';
  TextEditingController bankController = TextEditingController();
  Account? bankAccount;
  TextEditingController counterPartyController = TextEditingController();
  Account? counterPartyAccount;
  TextEditingController amountController = TextEditingController(text: '0.0');
  String? amount;
  TextEditingController dateController = TextEditingController(
      text:
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}");
  String? date;
  TextEditingController notesController = TextEditingController();
  String? notes;
  StatementRepo statementRepo = StatementRepo();
  AccountsController accountsController = Get.find<AccountsController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;

  void setPaymentType(type) {
    paymentType = type;
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

  void setAmount(paymentAmount) {
    amount = paymentAmount;
  }

  void setDate(date) {
    if (date.isEmpty) {
      date =
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    }
    dateController.value = TextEditingValue(text: date);
  }

  void setNotes(notes) {
    notesController.value = TextEditingValue(text: notes);
  }

  Future<void> createPayment() async {
    String bankId = bankAccount!.id.toString();
    String counterPartyId = counterPartyAccount!.id.toString();
    String amount = amountController.value.text;
    String date = dateController.text;
    String notes = notesController.text;
    if (bankId.isNotEmpty &&
        counterPartyId.isNotEmpty &&
        amount.toString().isNotEmpty &&
        date.isNotEmpty) {
      loading.value = true;
      var payment = await statementRepo.createPayment(
        paymentType,
        counterPartyAccount!.id,
        bankAccount!.id,
        notes,
        num.parse(amount),
        date,
      );
      loading.value = false;
      if (payment != null) {
        boxClient.setCounterPartyAccount(counterPartyAccount!.id);
        boxClient.setBankAccount(bankAccount!.id);
        await accountsController.getAccounts();
        accountsController.getClientAcoounts();
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

  @override
  void onInit() {
    setDefaultAccounts();
    super.onInit();
  }
}
