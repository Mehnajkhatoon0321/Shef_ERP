import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';
import 'package:shef_erp/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/auth_flow/login_screen.dart';
import 'package:shef_erp/screen/dashboard/admin_dashboard.dart';

import 'package:shef_erp/screen/dashboard/dashboard.dart';
import 'package:shef_erp/screen/dashboard/requester_dashboard.dart';
import 'package:shef_erp/screen/dashboard/vender_dashboard.dart';
import 'package:shef_erp/screen/master/master.dart';
import 'package:shef_erp/screen/reports/reports.dart';
import 'package:shef_erp/screen/requisition/admin/admin_requisition.dart';
import 'package:shef_erp/screen/requisition/requester/requisition_requester.dart';
import 'package:shef_erp/screen/requisition/unit_head/requisition.dart';
import 'package:shef_erp/screen/requisition/vender/vendor_requisition.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';

import '../../utils/pref_utils.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(40.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };
  String? userRole;
  @override
  void initState() {
    userRole =  PrefUtils.getRole();
    // TODO: implement initState
    super.initState();
  }

  void _onTap(BuildContext context, int index, String userRole) {
    // Get the filtered items based on user role
    final filteredItems = getFilteredItems(userRole);

    // Make sure the index is within the range of the filtered list
    if (index < 0 || index >= filteredItems.length) {
      return; // Or handle out-of-range errors as needed
    }

    // Get the title of the selected item
    final selectedItemTitle = filteredItems[index]["title"];

    switch (selectedItemTitle) {
      case 'Dashboard':
        if (userRole == 'Vendor' ) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VendorDashboard()),
          );
        }else if (userRole == 'Purchase Manager') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminDashboard()),
          );
        }
        else if (userRole == 'Requester') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RequesterDashboard()),
          );
        }
        else if (userRole == 'Program Director') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminDashboard()),
          );
        }
        else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        }
        break;

      case 'Requisition':
        if (userRole == 'Unit Head') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RequisitionScreen()),
          );
        }else if (userRole == 'Purchase Manager') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminRequisition()),
          );
        }else if (userRole == 'Requester') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  BlocProvider(
  create: (context) => AllRequesterBloc(),
  child: RequisitionRequester(),
)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VenderRequisition()),
          );
        }
        break;

      case 'Reports':
        if (userRole == 'Purchase Manager') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportScreen()),
          );
        }
        // Handle cases for other roles if necessary
        break;

      case 'Master':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MasterScreen()), // Adjust with your actual MasterPage widget
        );
        break;

      default:
      // Handle default or error case
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define common dimensions based on screen sizedouble containerHeight =(displayType == 'desktop' || displayType == 'tablet') ? screenHeight * 0.55:screenHeight * 0.5;
    double servicesContainerHeight = (displayType == 'desktop' || displayType == 'tablet') ?screenHeight * 0.9:screenHeight * 0.75; // Remaining height for services section

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primaryColourDark,
      appBar: AppBar(

        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColourDark,

        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openEndDrawer(); // Open the end drawer
              },
              child: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height:MediaQuery.of(context).size.height/5,
              child: UserAccountsDrawerHeader(
                accountName: Text("Mehnaj Khan", style: FTextStyle.nameProfile),
                accountEmail: Text("mehnaj@example.com", style: FTextStyle.emailProfile),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColour,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.primaryColour),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile'); // Define your route
              },
            ),
            const Divider(color: AppColors.primaryColour,),
            ListTile(
              leading: const Icon(Icons.lock, color: AppColors.primaryColour),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.pushNamed(context, '/change-password'); // Define your route
              },
            ),          const Divider(color: AppColors.primaryColour,),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.primaryColour),
              title: const Text('Logout'),
              onTap: () {
                _showDeleteDialog(); // Define your logout function
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Divider(color: Colors.white,thickness: 3,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [




                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Good Day',style: FTextStyle.preHeadingBoldStyle.copyWith(color: Colors.white,fontSize: 24),),
                        Text('Hi Mehnaj khatoon',style: FTextStyle.preHeadingBoldStyle.copyWith(color: Colors.white),).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!),   ],
                    ),
                  ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height/6,
                      decoration: BoxDecoration(
                        color:Colors.white, // Background color
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                        border: Border.all(

                            color: AppColors.yellow, // Border color
                            width:5 // Border width
                        ), boxShadow: [
                        BoxShadow(
                          color:AppColors.yellow.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius:4,// Blur radius
                          offset: const Offset(0, 3), // Offset from the container
                        ),
                      ],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Welcome \n lets plan your day',style: FTextStyle.preHeadingStyle,).animateOnPageLoad(
                                animationsMap['imageOnPageLoadAnimation2']!),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topCenter,

                                child: Image.asset(
                                  'assets/images/timer.png',
                                  // color: AppColors.primaryColourDark,
                                  width: (displayType == 'desktop' || displayType == 'tablet')
                                      ? 150.w
                                      : 200,
                                  height: (displayType == 'desktop' || displayType == 'tablet')
                                      ? 100.h
                                      : 140,
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['imageOnPageLoadAnimation2']!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.02, ),
                    child: Text(
                      "Services",
                      style: FTextStyle.HeadingTxtStyle.copyWith(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    child: Container(
                      height: servicesContainerHeight,
                      child: GridView.builder(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:  3,
                          crossAxisSpacing: screenWidth * 0.02,
                          mainAxisSpacing: screenHeight * 0.02,
                        ),
                        itemCount: getFilteredItems(userRole!).length,
                        itemBuilder: (context, index) {
                          final item = getFilteredItems(userRole!)[index];
                          return GestureDetector(
                            onTap: () => _onTap(context, index,userRole!),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
                                      child: Container(
                                        width: (displayType == 'desktop' || displayType == 'tablet') ? screenWidth * 0.15 : screenWidth * 0.15,
                                        height: (displayType == 'desktop' || displayType == 'tablet') ? screenWidth * 0.15 : screenWidth * 0.15,
                                        color: Colors.grey,
                                        child: Image.asset(
                                          item["image"],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    item["title"],
                                    style: FTextStyle.HeadingTxtStyle.copyWith(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<Map<String, dynamic>> getFilteredItems(String userRole) {
    final List<Map<String, dynamic>> allItems = [
      {
        "image": "assets/images/dashboard.png",
        "title": 'Dashboard',
      },
      {
        "image": "assets/images/requisition.png",
        "title": 'Requisition',
      },
      {
        "image": "assets/images/report.png",
        "title": 'Reports',
      },
      {
        "image": "assets/images/master.png",
        "title": 'Master',
      },
    ];

    if (userRole == 'Vendor') {
      // Show only Dashboard and Requisition
      return allItems.where((item) =>
      item["title"] == 'Dashboard' || item["title"] == 'Requisition').toList();
    }
    else if (userRole == 'Unit Head') {
      // Show Dashboard, Requisition, and Reports
      return allItems.where((item) =>
      item["title"] == 'Dashboard' || item["title"] == 'Requisition' ).toList();
    } else if (userRole == 'Requester') {
      // Show Dashboard, Requisition, and Reports
      return allItems.where((item) =>
      item["title"] == 'Dashboard' || item["title"] == 'Requisition' ).toList();
    }
    else if (userRole == 'Purchase Manager') {
      // Show all items
      return allItems;
    } else {
      // Default case if role does not match any of the known roles
      return [];
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Are you sure you want to logout?",
                    style: FTextStyle.preHeadingStyle),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.formFieldBackColour,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColour,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: const Text("OK",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => AuthFlowBloc(),
                                child: const LogScreen(),
                              )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

