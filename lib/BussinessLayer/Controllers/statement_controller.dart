import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Repositories/statement_repo.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class StatementController extends GetxController {
  TextEditingController fromAccountController = TextEditingController();
  TextEditingController toAccountController = TextEditingController();
  TextEditingController amountController = TextEditingController(text: "0.0");
  TextEditingController dateController = TextEditingController(
    text:
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
  );
  TextEditingController statementTextController = TextEditingController();
  StatementRepo statementRepo = StatementRepo();
  var loading = false.obs;

  void setFromAccount(accountName) {
    fromAccountController.value = TextEditingValue(text: accountName);
  }

  void setToAccount(accountName) {
    toAccountController.value = TextEditingValue(text: accountName);
  }

  void setDate(date) {
    dateController.value = TextEditingValue(text: date);
  }

  void setStatementText(accountName) {
    statementTextController.value =
        TextEditingValue(text: 'تسجيل دفعة نقدية من الزبون ${accountName}');
  }

  // Future<void> createAccount() async {
  //   String name = nameController.text;
  //   String balance = balanceController.text;
  //   String email = emailController.text;
  //   String mobileNumber = mobilePhoneController.text;
  //   String address = addressController.text;
  //   if (name.isNotEmpty &&
  //       balance.isNotEmpty &&
  //       type!.isNotEmpty &&
  //       style!.isNotEmpty &&
  //       email.isNotEmpty &&
  //       mobileNumber.isNotEmpty &&
  //       address.isNotEmpty) {
  //     loading.value = true;
  //     var account = await accountsRepo.createAccount(
  //         MyApp.appUser!.id,
  //         name,
  //         int.parse(balance),
  //         convertAccountTypeToNumber(type),
  //         convertAccountStyleToNumber(style),
  //         email,
  //         address,
  //         mobileNumber);
  //     loading.value = false;
  //     if (account != null) {
  //       SnackBars.showSuccess('تم انشاء القيد المحاسبي');
  //     } else {
  //       SnackBars.showError('فشل انشاء القيد المحاسبي');
  //     }
  //   } else {
  //     SnackBars.showWarning('يرجى تعبئة الحقول المطلوبة');
  //   }
  // }
}
