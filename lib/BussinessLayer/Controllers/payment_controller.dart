import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payments_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/DataAccesslayer/Clients/box_client.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
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
  PaymentsController paymentsController = Get.find<PaymentsController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;
  var savingState = false;

  Map<String, String> counterPaymentTypes = {
    'مقبوضات': 'income',
    'مدفوعات': 'payment',
  };

  void setPaymentType(type) {
    if (type != null) {
      paymentType = type;
    }
  }

  void setCounterPaymentType(type) {
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
    if (amount != null) {
      amountController.value = TextEditingValue(text: amount.toString());
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

  void setDefaultFields(
      {bool clear = false, String? paymentType = 'مقبوضات', Payment? payment}) {
    if (payment != null) {
      setPaymentType(payment.type);
      setCounterPartyAccount(payment.counterParty);
      setBankAccount(payment.bank);
      setAmount(payment.amount);
      setDate(DateFormatter.getFormated(payment.date));
      setNotes(payment.statement);
    } else {
      setCounterPaymentType(paymentType);
      setDefaultAccounts(clear);
      setAmount(null);
      setDate('');
      setNotes('');
    }
  }

  Future<void> createPayment() async {
    savingState = false;
    int? bankId = getBankAccountId();
    int? counterPartyId = getCounterPartyAccountId();
    num amount = getAmount();
    String date = getDate();
    String notes = getNotes();
    if (bankId != null && counterPartyId != null && date.isNotEmpty) {
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
        setDefaultFields(clear: true);
        boxClient.setCounterPartyAccount(counterPartyId);
        boxClient.setBankAccount(bankId);
        await accountsController.getAccounts();
        paymentsController.getPayments();
        savingState = true;
        setDefaultFields(clear: true);
        SnackBars.showSuccess('تم انشاء القيد الدفعة');
      } else {
        SnackBars.showError('فشل انشاء الدفعة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> updatePayment(id) async {
    savingState = false;
    int? bankId = getBankAccountId();
    int? counterPartyId = getCounterPartyAccountId();
    num amount = getAmount();
    String date = getDate();
    String notes = getNotes();
    if (bankId != null && counterPartyId != null && date.isNotEmpty) {
      loading.value = true;
      var payment = await paymentsRepo.updatePayment(
        id,
        paymentType,
        counterPartyId,
        bankId,
        notes,
        amount,
        date,
      );
      loading.value = false;
      if (payment != null) {
        await paymentsController.getPayments();
        savingState = true;
        SnackBars.showSuccess('تم تعديل القيد الدفعة');
      } else {
        SnackBars.showError('فشل تعديل الدفعة');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> deletePayment(id) async {
    loading.value = true;
    var payment = await paymentsRepo.deletePayment(id);
    loading.value = false;
    if (payment != null) {
      paymentsController.getPayments();
      SnackBars.showSuccess('تم الحذف بنجاح');
    } else {
      SnackBars.showError('فشل الحذف');
    }
  }
}
