// ignore_for_file: constant_identifier_names

// This library uses SharedPreferences
// which allows saving the username and password in the local mobile storage securely and encrypted
// NOTE: I can use the sqflite but this encrypted and more secure

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String USER_TOKEN = "USER_TOKEN";
const String USERNAME = "USERNAME";
const String USER_PASSWORD = "USER_PASSWORD";
const String IS_LOGIN = "IS_LOGIN";

class LocalStorage {
  static late FlutterSecureStorage _localStorage;

  void init() {
    _localStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  static Future<void> setStringValue(String key, String value) async {
    await _localStorage.write(key: key, value: value);
  }

  static Future<String> getStringValue(String key) async {
    return await _localStorage.read(key: key) ?? "";
  }

  static Future<void> setBoolValue(String key, bool value) async {
    await _localStorage.write(key: key, value: value.toString());
  }

  static Future<bool> getBoolValue(String key) async {
    final r = await _localStorage.read(key: key) ?? "false";
    return r == "true";
  }

  static Future<void> setIntValue(String key, int value) async {
    await _localStorage.write(key: key, value: value.toString());
  }

  static Future<int> getIntValue(String key) async {
    final r = await _localStorage.read(key: key) ?? "0";
    return int.parse(r);
  }

  static removeValue(String key) async {
    await _localStorage.delete(key: key);
  }

  static clearAllData() async {
    await _localStorage.deleteAll();
  }
}
