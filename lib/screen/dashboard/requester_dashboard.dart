import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';

import 'package:shef_erp/screen/auth_flow/login_screen.dart';
import 'package:shef_erp/screen/auth_flow/navigation.dart';
import 'package:shef_erp/screen/auth_flow/profile_details.dart';
import 'package:shef_erp/screen/dashboard/admin_dashboard.dart';
import 'package:shef_erp/screen/dashboard/dashboard.dart';
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
import 'package:shef_erp/utils/pref_utils.dart';

class RequesterDashboard extends StatefulWidget {
  const RequesterDashboard({super.key});

  @override
  State<RequesterDashboard> createState() => _RequesterDashboardState();
}

class _RequesterDashboardState extends State<RequesterDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> listItem = [
    {'subtitle': 'Dashboard', 'icon': Icons.dashboard},
    {'subtitle': 'Requisition', 'icon': Icons.list_alt},
    {'subtitle': 'Reports', 'icon': Icons.request_page_outlined},
    {'subtitle': 'Master', 'icon': Icons.book},
    {'subtitle': 'My Profile', 'icon': Icons.person},
    {'subtitle': 'Logout', 'icon': Icons.logout},
  ];

  List<dynamic> _items = [
    {
      "title": "All Requisitions",
      "total": "21",
      "image": "https://via.placeholder.com/150"
    },
    {
      "title": "Today,s Requisitions",
      "total": "12",
      "image": "https://via.placeholder.com/150"
    },
    {
      "title": "Pending Requisitions",
      "total": "33",
      "image": "https://via.placeholder.com/150"
    },
    {
      "title": "Delivered Requisition",
      "total": "4",
      "image": "https://via.placeholder.com/150"
    }
  ];
  String? userRole;

  @override
  void initState() {
    userRole = PrefUtils.getRole();
    // TODO: implement initState
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    print('displayType>> $displayType');

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Dashboard',
            style: FTextStyle.HeadingTxtWhiteStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.primaryColourDark,
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: UserAccountsDrawerHeader(
                  accountName:
                      Text("${PrefUtils.getUserName()}", style: FTextStyle.nameProfile),
                  accountEmail: Text("${PrefUtils.getUserEmailLogin()}",
                      style: FTextStyle.emailProfile),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColourDark,
                  ),
                ),
              ),
              ...listItem.map((item) {
                // Allow all items for Purchase Manager role
                if (userRole == 'Purchase Manager') {
                  return  Column(
                    children: [
                      ListTile(
                        leading: Icon(item['icon'],color: AppColors.primaryColourDark,),
                        title: Text(item['subtitle'],
                            style: FTextStyle.FaqsTxtStyle.copyWith( color: AppColors.primaryColourDark)),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          switch (item['subtitle']) {
                            case 'Dashboard':
                              _navigateBasedOnRole(PrefUtils.getRole());
                              break;
                            case 'Requisition':
                              _navigateOnRole(PrefUtils.getRole());
                              break;
                            case 'Reports':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReportScreen()),
                              );
                              break;
                            case 'Master':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen()),
                              );
                              break;
                            case 'My Profile':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfileDetails()),
                              );
                              break;
                            case 'Logout':
                              _showLogDialog();
                              break;
                            default:
                            // Handle default case if needed
                              break;
                          }
                        },
                      ),
                      const Divider(
                          height: 1,
                          color: AppColors.primaryColourDark,
                          thickness: 1), // Add a divider after each ListTile
                    ],
                  );
                }

                // Hide Master and Reports for Requester role
                if (userRole == 'Requester' &&
                    (item['subtitle'] == 'Master' ||
                        item['subtitle'] == 'Reports')) {
                  return SizedBox.shrink(); // Hide these items
                }

                return Column(
                  children: [
                    ListTile(
                      leading: Icon(item['icon'],color: AppColors.primaryColourDark,),
                      title: Text(item['subtitle'],
                          style: FTextStyle.FaqsTxtStyle.copyWith( color: AppColors.primaryColourDark)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        switch (item['subtitle']) {
                          case 'Dashboard':
                            _navigateBasedOnRole(PrefUtils.getRole());
                            break;
                          case 'Requisition':
                            _navigateOnRole(PrefUtils.getRole());
                            break;
                          case 'Reports':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReportScreen()),
                            );
                            break;
                          case 'Master':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MasterScreen()),
                            );
                            break;
                          case 'My Profile':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileDetails()),
                            );
                            break;
                          case 'Logout':
                            _showLogDialog();
                            break;
                          default:
                            // Handle default case if needed
                            break;
                        }
                      },
                    ),
                    const Divider(
                        height: 1,
                        color: AppColors.primaryColourDark,
                        thickness: 1), // Add a divider after each ListTile
                  ],
                );
              }),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: FTextStyle.preHeadingBoldStyle
                          .copyWith(color: Colors.black, fontSize: 24),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Welcome',
                            style: FTextStyle.preHeadingBoldStyle
                                .copyWith(color: AppColors.primaryColourDark, fontSize: 29),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Hi  ${PrefUtils.getUserName()}',
                            style: FTextStyle.preHeadingBoldStyle
                                .copyWith(color: Colors.black),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation2']!),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3.0, vertical: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    border: Border.all(
                        color: AppColors.yellow, // Border color
                        width: 3 // Border width
                        ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.yellow.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 4, // Blur radius
                        offset: const Offset(0, 3), // Offset from the container
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome \n lets plan your day',
                          style: FTextStyle.preHeadingStyle,
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!),
                        Container(
                          height: 220,
                          // color: Colors.redAccent,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/timer.png',
                            // color: AppColors.primaryColourDarkDark,
                            width: (displayType == 'desktop' ||
                                    displayType == 'tablet')
                                ? 150.w
                                : 120,
                            height: (displayType == 'desktop' ||
                                    displayType == 'tablet')
                                ? 100.h
                                : 200,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: ListView.builder(
                    itemCount: _items.length, // Number of items
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      bool isEvenIndex = index % 2 == 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        // Spacing between rows
                        decoration: BoxDecoration(
                          color: isEvenIndex ? Colors.blue : Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: isEvenIndex
                                  ? Colors.blue.shade700
                                  : Colors.yellow.shade700,
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  item['total'], // Title from JSON
                                  style: const TextStyle(
                                    fontSize: 16.0, // Font size
                                    fontWeight: FontWeight.bold, // Text weight
                                  ),
                                ),
                              ),
                              Text(
                                item['title'], // Title from JSON
                                style: const TextStyle(
                                  fontSize: 16.0, // Font size
                                  fontWeight: FontWeight.bold, // Text weight
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showLogDialog() {
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
                        backgroundColor: AppColors.primaryColourDark,
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
  void _navigateBasedOnRole(String role) {
    Widget nextPage;

    switch (role) {
      case 'Unit Head':
        nextPage = const Dashboard(); // Replace with your Admin screen widget
        break;
      case 'super-admin':
        nextPage = const Navigation(); // Replace with your Admin screen widget
        break;
      case 'Purchase Manager':
        nextPage = const AdminDashboard(); // Replace with your User screen widget
        break;

      case 'Program Director':
        nextPage = const AdminDashboard(); // Replace with your User screen widget
        break;
      case 'Vendor':
        nextPage = const VendorDashboard(); // Replace with your User screen widget
        break;
      case 'Requester':
        nextPage = const RequesterDashboard(); // Replace with your User screen widget
        break;
      default:


        return; // No navigation occurs if the role is not recognized
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }
  void _navigateOnRole(String role) {
    Widget nextPage;

    switch (role) {
      case 'Unit Head':
        nextPage =  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: RequisitionScreen(),
        );
        break;

      case 'Purchase Manager':
        nextPage =  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: AdminRequisition(),
        );
        break;
      case 'Program Director':
        nextPage =  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: VenderRequisition(),
        );
        break;
      case 'Vendor':
        nextPage =  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: VenderRequisition(),
        );
        break;
      case 'Requester':
        nextPage =  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: RequisitionRequester(),
        );
        break;
      default:
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextPage));
  }
}
