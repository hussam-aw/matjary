import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
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
  int? bankAccountId;
  TextEditingController counterPartyController = TextEditingController();
  int? counterPartyId;
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  PaymentsRepo paymentsRepo = PaymentsRepo();
  AccountsController accountsController = Get.find<AccountsController>();
  PaymentsController paymentsController = Get.find<PaymentsController>();
  BoxClient boxClient = BoxClient();
  var loading = false.obs;
  var savingState = false;
  final connectivityController = Get.find<ConnectivityController>();

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
    if (account != null) {
      bankAccountId = account.id;
      bankController.value =
          TextEditingValue(text: accountsController.getAccountName(account.id));
    } else {
      bankController.clear();
    }
  }

  int? getBankAccountId() {
    return bankAccountId;
  }

  void setCounterPartyAccount(Account? account) {
    if (account != null) {
      counterPartyId = account.id;
      counterPartyController.value =
          TextEditingValue(text: accountsController.getAccountName(account.id));
    } else {
      counterPartyId = null;
      counterPartyController.clear();
    }
  }

  int? getCounterPartyAccountId() {
    return counterPartyId;
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
      int? bankId, counterId;
      counterId = await boxClient.getCounterPartyAccount();
      bankId = await boxClient.getBankAccount();
      counterParty = accountsController.getAccountFromId(counterId);
      bank = accountsController.getAccountFromId(bankId);
      if (counterParty == null && bank == null) {
        counterParty = accountsController.accounts.isNotEmpty
            ? accountsController.accounts[0]
            : null;
        bank = accountsController.accounts.isNotEmpty
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
      setCounterPartyAccount(
          accountsController.getAccountFromId(payment.counterPartyId));
      setBankAccount(accountsController.getAccountFromId(payment.bankId));
      setAmount(payment.amount);
      setDate(DateFormatter.getFormated(payment.createdAt));
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
    bool connected = connectivityController.isConnected;
    if (bankId != null && counterPartyId != null && date.isNotEmpty) {
      loading.value = true;
      bool isPaymentCreated = await paymentsRepo.createPayment(
        connected,
        paymentType,
        counterPartyId,
        bankId,
        notes,
        amount,
        date,
      );
      loading.value = false;
      if (isPaymentCreated) {
        setDefaultFields(clear: true);
        boxClient.setCounterPartyAccount(counterPartyId);
        boxClient.setBankAccount(bankId);
        if (connected) {
          await accountsController.getAccounts();
          paymentsController.getPayments();
        }
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
      if (connectivityController.isConnected) {
        loading.value = true;
        bool isPaymentUpdated = await paymentsRepo.updatePayment(
          id,
          paymentType,
          counterPartyId,
          bankId,
          notes,
          amount,
          date,
        );
        loading.value = false;
        if (isPaymentUpdated) {
          await paymentsController.getPayments();
          savingState = true;
          SnackBars.showSuccess('تم تعديل القيد الدفعة');
        } else {
          SnackBars.showError('فشل تعديل الدفعة');
        }
      } else {
        SnackBars.showError('لا يوجد اتصال بالانترنت');
      }
    } else {
      SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
    }
  }

  Future<void> deletePayment(id) async {
    if (connectivityController.isConnected) {
      loading.value = true;
      var isPaymentDeleted = await paymentsRepo.deletePayment(id);
      loading.value = false;
      if (isPaymentDeleted) {
        paymentsController.getPayments();
        SnackBars.showSuccess('تم الحذف بنجاح');
      } else {
        SnackBars.showError('فشل الحذف');
      }
    } else {
      SnackBars.showError('لا يوجد اتصال بالانترنت');
    }
  }
}
