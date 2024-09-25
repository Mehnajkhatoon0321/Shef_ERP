import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/screen/auth_flow/navigation.dart';
import 'package:shef_erp/screen/dashboard/admin_dashboard.dart';
import 'package:shef_erp/screen/dashboard/dashboard.dart';
import 'package:shef_erp/screen/dashboard/requester_dashboard.dart';
import 'package:shef_erp/screen/dashboard/vender_dashboard.dart';
import 'package:shef_erp/screen/onboarding/welcome_screen.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () => navigateUser(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Center(
            child: Image.asset(
              'assets/images/applogo.png',
              width: (displayType == 'desktop' || displayType == 'tablet') ? 250.w : 250,
              height: (displayType == 'desktop' || displayType == 'tablet') ? 100.h : 170,
            ),
          ),
        ),
      ),
    );
  }

  void navigateUser(BuildContext context) {
    // Check if the user is logged in
    bool isLoggedIn = PrefUtils.getIsLogin(); // Adjust this to your login check logic
    Widget nextPage;

    if (isLoggedIn) {
      String role = PrefUtils.getRole(); // Get the user's role
      nextPage = _navigateBasedOnRole(role); // Navigate based on role
    } else {
      nextPage = const WelcomeScreen(); // Navigate to WelcomeScreen if not logged in
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => nextPage),
          (route) => false,
    );
  }

  Widget _navigateBasedOnRole(String role) {
    switch (role) {
      case 'Unit Head':
        return const Dashboard(); // Navigate to Dashboard if role is Unit Head
      case 'super-admin':
        return const Navigation(); // Navigate for super-admin
      case 'Purchase Manager':
        return const AdminDashboard(); // Navigate for Purchase Manager
      case 'Program Director':
        return const AdminDashboard(); // Navigate for Program Director
      case 'Vendor':
        return const VendorDashboard(); // Navigate for Vendor
      case 'Requester':
        return const RequesterDashboard(); // Navigate for Requester
      default:
        return const WelcomeScreen(); // Default case if role is not recognized
    }
  }
}
