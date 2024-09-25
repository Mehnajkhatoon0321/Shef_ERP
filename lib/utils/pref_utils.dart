


import 'package:shef_erp/utils/shared_preference.dart';

class PrefUtils {


  static void setToken(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.token, value);
  }

  static String getToken() {
    final String? value = Prefs.prefs?.getString(SharedPrefsKeys.token);
    return value ?? '';
  }

  static void setRole(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.role, value);
  }

  static String getRole() {
    final String? value = Prefs.prefs?.getString(SharedPrefsKeys.role);
    return value ?? '';
  }

  static void setRememberMe(bool value) {
    Prefs.prefs?.setBool(SharedPrefsKeys.rememberMe, value);
  }

  static bool getRememberMe() {
    final bool? value = Prefs.prefs?.getBool(SharedPrefsKeys.rememberMe);
    return value ?? false;
  }


  static void setUserPassword(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.userPassword, value);
  }

  static String getUserPassword() {
    final String? value = Prefs.prefs?.getString(SharedPrefsKeys.userPassword);
    return value ?? '';
  }

  static void setUserEmailLogin(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.userEmailLogin, value);
  }

  static String getUserEmailLogin() {
    final String? value =
    Prefs.prefs?.getString(SharedPrefsKeys.userEmailLogin);
    return value ?? '';
  }

  static void setUserName(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.name, value);
  }

  static String getUserName() {
    final String? value =
    Prefs.prefs?.getString(SharedPrefsKeys.name);
    return value ?? '';
  }
  static void setUserId(int value) {
    Prefs.prefs?.setString(SharedPrefsKeys.userId, value.toString());
  }

  static int getUserId() {
    final String? value = Prefs.prefs?.getString(SharedPrefsKeys.userId);
    return int.tryParse(value ?? '') ?? 0;
  }

  static void setIsLogin(bool value) {
    Prefs.prefs?.setBool(SharedPrefsKeys.isLogin, value);
  }

  static bool getIsLogin() {
    final bool? value = Prefs.prefs?.getBool(SharedPrefsKeys.isLogin);
    return value ?? false;
  }


}


class SharedPrefsKeys {
  static const isLogin = 'isLogin';
  static const token = 'token';
  static const role = 'role';
  static const rememberMe = 'rememberMe';
  static const userPassword = 'userPassword';
  static const userEmailLogin = 'userEmailLogin';
  static const userId = 'userId';
  static const name = 'name';

}
