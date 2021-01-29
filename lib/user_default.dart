import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDefaults {
  static SharedPreferences _storage;

  /// 静态私有实例对象
  static final _instance = UserDefaults._init();

  /// 工厂构造函数，返回实例对象
  factory UserDefaults() => _instance;

  /// 命名构造函数，初始化UserDefaults实例对象
  UserDefaults._init() {
    _initStorage();
  }

  /// SharedPreferences.getInstance()是一个异步方法，需要用await接收它的值
  _initStorage() async {
    if (_storage == null) {
      _storage = await SharedPreferences.getInstance();
    }
  }

  /// Saves a boolean [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setBool(String key, bool value) async {
    await _initStorage();
    _storage.setBool(key, value);
  }

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setDouble(String key, double value) async {
    await _initStorage();
    _storage.setDouble(key, value);
  }

  /// Saves an integer [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setInt(String key, int value) async {
    await _initStorage();
    _storage.setInt(key, value);
  }

  setString(String key, value) async {
    await _initStorage();
    if (value is Map) {
      _storage.setString(key, JsonEncoder().convert(value));
    } else {
      _storage.setString(key, value);
    }
  }

  /// Saves a list of strings [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setStringList(String key, List<String> value) async {
    await _initStorage();
    _storage.setStringList(key, value);
  }
}
