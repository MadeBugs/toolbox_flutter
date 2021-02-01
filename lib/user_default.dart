import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDefaults {
  static SharedPreferences _storage;

  /// 静态私有实例对象
  static final _instance = UserDefaults._init();

  SharedPreferences get sharedPreferences => _storage;

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

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setString(String key, String value) async {
    await _initStorage();
    _storage.setString(key, value);
  }

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setMap(String key, Map value) async {
    await _initStorage();
    _storage.setString(key, JsonEncoder().convert(value));
  }

  /// Saves a list of strings [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  setStringList(String key, List<String> value) async {
    await _initStorage();
    _storage.setStringList(key, value);
  }

  /// 存储List
  setList(String key, List value) {
    _storage.setString(key, JsonEncoder().convert(value));
  }

  /// Removes an entry from persistent storage.
  remove(String key) async {
    await _initStorage();
    _storage.remove(key);
  }

  /// Completes with true once the user preferences for the app has been cleared.
  clear() {
    _storage.clear();
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool getBool(String key) {
    return _storage.getBool(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  int getInt(String key) {
    return _storage.getInt(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  double getDouble(String key) {
    return _storage.getDouble(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String getString(String key) {
    return _storage.getString(key);
  }

  /// map是转换成String类型存储的
  /// 获取的时候先进行判断，是否可以转换成map
  /// 如果不能则直接返回String类型值
  getMap(String key) {
    var value = _storage.getString(key);
    if (_isJson(value)) {
      return JsonDecoder().convert(value);
    }
    return value;
  }

  List<String> getStringList(String key) {
    return _storage.getStringList(key);
  }

  /// 获取的为String类型，然后进行转化，
  /// 如果不能转换为List类型，则直接返回String类型
  /// 所以返回类型为dynamic
  getList(String key) {
    final value = _storage.getString(key);
    if (_isJson(value)) {
      return JsonDecoder().convert(value);
    }
    return value;
  }

  _isJson(dynamic value) {
    try {
      JsonDecoder().convert(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
