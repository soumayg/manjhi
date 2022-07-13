import 'package:manjhi/model/local_storage_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageController extends ChangeNotifier{
  LocalStorageModel credentials = LocalStorageModel();

  void saveCredentials(String mobileNumber) async {
    credentials.setMobileNumber(mobileNumber);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Manjhi:Username', mobileNumber);
  }

  void deleteCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Manjhi:Username', 'null');
  }

  void getCredentials() async {
    await _getMobileNumberFromLocal();
  }

  Future<bool> validateLoggedInUser() async {
    await _getMobileNumberFromLocal();
    if (credentials.getMobileNumber.toString().contains('null')) {
      return false;
    } else if (credentials.getMobileNumber.toString().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _getMobileNumberFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    var checkUsername = (prefs.getString('Manjhi:Username'));
    if (checkUsername.toString().isEmpty) {
      credentials.setMobileNumber('');
    }
    credentials.setMobileNumber(checkUsername.toString());
  }

}