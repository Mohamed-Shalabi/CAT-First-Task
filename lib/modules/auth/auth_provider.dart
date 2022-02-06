import 'dart:convert';
import 'dart:developer';

import 'package:first_task/models/user_model.dart';
import 'package:first_task/shared/cache_helper.dart';
import 'package:first_task/shared/shared_preferences_keys.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  //
  var selectedDialCode = '+20';
  void changeSelectedDialCode(String value) {
    selectedDialCode = value;
    notifyListeners();
  }

  UserModel? _userModel;
  void createUser(String name, String email, int phone, String password) {
    _userModel = UserModel(name: name, email: email, phone: phone, password: password);
    saveUser();
  }

  String saveUser() {
    if (_userModel != null) {
      CacheHelper.instance.setString(SharedPreferencesKeys.userKey, _userModel!.toMap().toString());
      return 'success';
    } else {
      return 'error';
    }
  }

  String getUser() {
    final userString = CacheHelper.instance.getString(SharedPreferencesKeys.userKey) ?? '';
    if (userString.isEmpty) {
      return 'error';
    }
    final userMap = jsonDecode(userString);
    _userModel = UserModel.fromMap(userMap);
    return 'success';
  }

  bool validateUser(String email, String password) {
    var result = 'success';
    if (_userModel == null) {
      result = getUser();
    }
    if (result == 'error') return false;
    log(_userModel!.toMap().toString());
    if (email == _userModel!.email && password == _userModel!.password) {
      return true;
    } else {
      return false;
    }
  }
}