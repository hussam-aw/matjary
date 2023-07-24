import 'package:get_storage/get_storage.dart';

import '../Models/user.dart';

class BoxClient {
  var box = GetStorage();
  Future<bool> getAuthState() async {
    if (await box.read('matjary_authed') != null) {
      return true;
    }
    return false;
  }

  Future<User> getAuthedUser() async {
    return User.fromMap(await box.read('matjary_userdata'));
  }

  Future<void> setAuthedUser(User user) async {
    await box.write('matjary_authed', true);
    await box.write('matjary_userdata', user.toMap());
  }

  Future<void> removeUserData() async {
    await box.remove('matjary_authed');
    await box.remove('matjary_userdata');
  }

  Future<void> setFirstSideAccount(int accountId) async {
    await box.remove('first_side_account');
    await box.write('first_side_account', accountId);
  }

  Future<int?> getFirstSideAccount() async {
    var firstSideId = await box.read('first_side_account');
    if (firstSideId != null) {
      return firstSideId;
    }
    return null;
  }

  Future<void> setSecondSideAccount(int? accountId) async {
    await box.remove('second_side_account');
    await box.write('second_side_account', accountId);
  }

  Future<int?> getSecondSideAccount() async {
    var secondSideId = await box.read('second_side_account');
    if (secondSideId != null) {
      return secondSideId;
    }
    return null;
  }

  Future<void> setCounterPartyAccount(int accountId) async {
    await box.remove('counter_party');
    await box.write('counter_party', accountId);
  }

  Future<int?> getCounterPartyAccount() async {
    var counterParty = await box.read('counter_party');
    if (counterParty != null) {
      return counterParty;
    }
    return null;
  }

  Future<void> setBankAccount(int accountId) async {
    await box.remove('bank_account');
    await box.write('bank_account', accountId);
  }

  Future<int?> getBankAccount() async {
    var bank = await box.read('bank_account');
    if (bank != null) {
      return bank;
    }
    return null;
  }

  Future<void> setWareAccount(int wareId) async {
    await box.remove('ware_account');
    await box.write('ware_account', wareId);
  }

  Future<int?> getWareAccount() async {
    var ware = await box.read('ware_account');
    if (ware != null) {
      return ware;
    }
    return null;
  }

  Future<void> setMarketerAccount(int accountId) async {
    await box.remove('marketer_account');
    await box.write('marketer_account', accountId);
  }

  Future<int?> getMarketerAccount() async {
    var marketer = await box.read('marketer_account');
    if (marketer != null) {
      return marketer;
    }
    return null;
  }

  Future<void> setAccountToPinnedAccountList(int accountId) async {
    var accounts = await getPinnedAccountsList();
    if (accounts != null) {
      accounts.add(accountId);
    } else {
      accounts = [accountId];
    }
    await box.remove('pinned_accounts');
    await box.write('pinned_accounts', accounts);
  }

  Future<List<dynamic>?> getPinnedAccountsList() async {
    var accounts = await box.read('pinned_accounts');
    if (accounts != null) {
      return accounts;
    }
    return null;
  }

  Future<void> clearStorage() async {
    await removeUserData();
    await box.remove('first_side_account');
    await box.remove('counter_party');
    await box.remove('bank_account');
    await box.remove('ware_account');
    await box.remove('marketer_account');
    await box.remove('pinned_accounts');
  }
}
