import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/screen/dashboard/dashboard.dart';
import 'package:shef_erp/screen/requisition/requisition.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/font_text_Style.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  String title = "Dashboard";

  final List<String> _imagePaths = [
    "assets/images/dashboard.png",
    "assets/images/requisition.png",

  ];

  final List<String> _labels = [
    'Dashboard',
    'Requisition',

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      title = _labels[_selectedIndex];
    });
  }

  final List<Widget> _screens = [
    const Dashboard(),
    const RequisitionScreen(),

  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType
        .toString()
        .split('.')
        .last;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: displayType == 'mobile' ? 55.h : 60.h,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.r),
            bottomRight: Radius.circular(0.r),
          ),
        ),
        backgroundColor: AppColors.primaryColour,
        centerTitle: true,
        title: Text(
          title,
          style: FTextStyle.HeadingTxtWhiteStyle.copyWith(color: Colors.white), // Fixed: Use camel case for style
        ),
      ),
      body: _screens.isNotEmpty
          ? _screens[_selectedIndex]
          : SizedBox.shrink(), // Avoid out of bounds error
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          _imagePaths.length,
              (index) => BottomNavigationBarItem(
            icon: Image.asset(
              _imagePaths[index],
              width: 24.w,
              height: 24.h,
              // color: (index == _selectedIndex)
              //     ? Colors.white
              //     : Colors.white, // Use a different color for better visibility
            ),
            label: _labels[index],
          ),
        ),
        backgroundColor: AppColors.primaryColour,
        selectedLabelStyle: FTextStyle.bottomNavText1.copyWith(
            color: Colors.white,
          fontSize: 16
        ),
        unselectedLabelStyle: FTextStyle.bottomNavText2.copyWith(
            color: Colors.white70
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),

    );
  }
}

