


import 'package:shef_erp/utils/shared_preference.dart';

class PrefUtils {


  static void setToken(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.token, value);
  }

  static String getToken() {
    final String? value = Prefs.prefs?.getString(SharedPrefsKeys.token);
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

}

class SharedPrefsKeys {

  static const token = 'token';
  static const rememberMe = 'rememberMe';
  static const userPassword = 'userPassword';
  static const userEmailLogin = 'userEmailLogin';
}
