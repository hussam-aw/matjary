import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Repositories/payments_repo.dart';
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
  PaymentsRepo paymentsRepo = PaymentsRepo();
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
    } else {
      bankController.clear();
    }
  }

  int? getBankAccountId() {
    if (bankAccount != null) {
      return bankAccount!.id;
    } else {
      return null;
    }
  }

  void setCounterPartyAccount(Account? account) {
    counterPartyAccount = account;
    if (account != null) {
      counterPartyController.value = TextEditingValue(text: account.name);
    } else {
      counterPartyController.clear();
    }
  }

  int? getCounterPartyAccountId() {
    if (counterPartyAccount != null) {
      return counterPartyAccount!.id;
    } else {
      return null;
    }
  }

  void setAmount(amount) {
    if (amount.isNotEmpty) {
      amountController.value = TextEditingValue(text: amount);
    } else {
      amountController.clear();
    }
  }

  num getAmount() {
    return amountController.text.isEmpty ? 0 : num.parse(amountController.text);
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

  void setNotes(notes) {
    if (notes.isNotEmpty) {
      notesController.value = TextEditingValue(text: notes);
    } else {
      notesController.clear();
    }
  }

  String getNotes() {
    return notesController.text;
  }

  void setDefaultAccounts(bool clear) async {
    if (!clear) {
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
    } else {
      setCounterPartyAccount(null);
      setBankAccount(null);
    }
  }

  void setDefaultFields({bool clear = false}) {
    setPaymentType('مقبوضات');
    setDefaultAccounts(clear);
    setAmount('');
    setDate('');
    setNotes('');
  }

  Future<void> createPayment() async {
    int? bankId = getBankAccountId();
    int? counterPartyId = getCounterPartyAccountId();
    num amount = getAmount();
    String date = getDate();
    String notes = getNotes();
    if (bankId != null && counterPartyId != null && date.isNotEmpty) {
      setDefaultFields(clear: true);
      loading.value = true;
      var payment = await paymentsRepo.createPayment(
        paymentType,
        counterPartyId,
        bankId,
        notes,
        amount,
        date,
      );
      loading.value = false;
      if (payment != null) {
        boxClient.setCounterPartyAccount(counterPartyId);
        boxClient.setBankAccount(bankId);
        await accountsController.getAccounts();
        SnackBars.showSuccess('تم انشاء القيد الدفعة');
      } else {
        SnackBars.showError('فشل انشاء الدفعة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  @override
  void onInit() {
    setDefaultFields();
    super.onInit();
  }
}
