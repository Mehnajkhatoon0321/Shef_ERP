import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/auth_flow/login_screen.dart';
import 'package:shef_erp/screen/auth_flow/navigation.dart';
import 'package:shef_erp/screen/auth_flow/profile_details.dart';
import 'package:shef_erp/screen/dashboard/admin_dashboard.dart';
import 'package:shef_erp/screen/dashboard/dashboard.dart';
import 'package:shef_erp/screen/dashboard/requester_dashboard.dart';
import 'package:shef_erp/screen/master/master.dart';
import 'package:shef_erp/screen/master/master_list/events.dart';
import 'package:shef_erp/screen/master/master_list/product_category.dart';
import 'package:shef_erp/screen/master/master_list/product_service.dart';
import 'package:shef_erp/screen/reports/reports.dart';

import 'package:shef_erp/screen/requisition/vender/vendor_requisition.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/colours.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  Map<String, double> dataMap = {

  };


  String? userRole;
  List<Map<String, dynamic>> listItem = [
    {'subtitle': 'Dashboard', 'icon': Icons.dashboard},
    {'subtitle': 'Requisition', 'icon': Icons.list_alt},


    {'subtitle': 'Reports', 'icon': Icons.request_page_outlined},
    {'subtitle': 'My Profile', 'icon': Icons.person},
    {'subtitle': 'Logout', 'icon': Icons.logout},
  ];
  int? _expandedIndex;
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
  Future<bool> _showExitConfirmation(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor),
            SizedBox(width: 8), // Add some space between icon and title
            Text(
              'Exit Confirmation',
              style: FTextStyle.FaqsTxtStyle,
            ),
          ],
        ),
        content: const Text(
          'Do you really want to exit the app?',
          style: FTextStyle.listTitle,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Don't exit
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Exit
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false; // Return false if the dialog was dismissed without a choice
  }

  Map<String, dynamic> errorServerMessage = {};
  String? errorMessage;
  bool isInitialLoading = false;
  String allRequisition = "0"; // Initialize to an appropriate default
  String todayRequisition = "0";
  String pendingRequisition = "0";
  String deliveredRequisition = "0";
  @override
  void initState() {
    userRole = PrefUtils.getRole();
    BlocProvider.of<AllRequesterBloc>(context).add(DashBoardHandler());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    print('displayType>> $displayType');
    String? userRole;
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit=(await _showExitConfirmation(context)) as bool;
        return shouldExit;


      },

      child: MediaQuery(
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
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer(); // Open the end drawer
                },
                child: const Icon(
                  Icons.menu,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    // Add your action here
                    print("Bell icon tapped!");
                    // You can navigate to another page or show a dialog, etc.
                  },
                  child: const Icon(
                    Icons.notifications,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.9,
                  child: UserAccountsDrawerHeader(

                    accountName:
                    Text("${PrefUtils.getUserName()}", style: FTextStyle.nameProfile),
                    accountEmail: Text("${PrefUtils.getInsideEmailLogin()}",maxLines: 1,
                        style: FTextStyle.emailProfile),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColourDark,
                    ),
                  ),
                ),
                ...buildMenuItems(listItem, PrefUtils.getRole()),

              ],
            ),
          ),
          body:   BlocListener<AllRequesterBloc, AllRequesterState>(
            listener: (context, state) {
              if (state is DashBoardLoading) {
                setState(() {
                  isInitialLoading = true;
                });
              } else if (state is DashBoardSuccess) {
                setState(() {
                  isInitialLoading = false;
                  var responseData = state.dashboardList;

                  allRequisition =
                      responseData['all_requistion'].toString();
                  todayRequisition =
                      responseData['todays_requistion'].toString();
                  pendingRequisition =
                      responseData['pending_requistion'].toString();
                  deliveredRequisition =
                      responseData['delivered_requistion'].toString();

                  Map<String, dynamic> unitWiseRequisition =
                  responseData['unit_wise_requistition'];

                  dataMap = unitWiseRequisition.map(
                          (key, value) => MapEntry(key, value.toDouble()));
                });
              } else if (state is DashBoardFailure) {
                setState(() {
                  isInitialLoading = false;
                });
                errorMessage = state.dashboardFailure['message'];

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage.toString()),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );

                if (kDebugMode) {
                  print("error>> ${state.dashboardFailure}");
                }
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context);
                });
              }
            },
  child: SingleChildScrollView(
            child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3.0, vertical: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height *0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
            
                            // Background color
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners
                            border: Border.all(
                                color: Colors.yellow.shade700, // Border color
                                width: 1 // Border width
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.shade700, // Shadow color
                                spreadRadius: 0.5, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset:
                                const Offset(0, 3), // Offset from the container
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.9,
                                  child: Text(
                                    'Welcome\n'
                                        '${PrefUtils.getUserName()}'
                                        '\nlets plan your day',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: FTextStyle.preHeadingStyle
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ).animateOnPageLoad(
                                      animationsMap['imageOnPageLoadAnimation2']!),
                                ),
                                Expanded(
                                  child: Container(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation2']!),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Container
                          Expanded(
                            child: Container(
                              height: 100,
                              // Set your desired height here
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.primaryColourDark,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.primaryColourDark,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "${allRequisition}",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                            color: AppColors
                                                .primaryColourDark,
                                            fontSize: 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "All Requisition",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                              color: AppColors
                                                  .formFieldHintColour,
                                              fontSize: 18),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 14,
                                    top: 9,
                                    child: Icon(
                                      Icons.data_thresholding_rounded,
                                      size: 29,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
            
                          const SizedBox(width: 20),
                          // Space between containers
            
                          // Second Container
                          Expanded(
                            child: Container(
                              height: 100,
                              // Set your desired height here
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.primaryColourDark,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.primaryColourDark,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "${todayRequisition}",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                            color: AppColors
                                                .primaryColourDark,
                                            fontSize: 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Today's Requisition",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                              color: AppColors
                                                  .formFieldHintColour,
                                              fontSize: 18),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 14,
                                    top: 9,
                                    child: Icon(
                                      Icons.today,
                                      size: 29,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Container
                          Expanded(
                            child: Container(
                              height: 100,
                              // Set your desired height here
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.primaryColourDark,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.primaryColourDark,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "${pendingRequisition}",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                            color: AppColors
                                                .primaryColourDark,
                                            fontSize: 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Pending Requisition",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                              color: AppColors
                                                  .formFieldHintColour,
                                              fontSize: 18),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 14,
                                    top: 9,
                                    child: Icon(Icons.pending_actions,
                                        size: 29, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
            
                          const SizedBox(width: 20),
                          // Space between containers
            
                          // Second Container
                          Expanded(
                            child: Container(
                              height: 100,
                              // Set your desired height here
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.primaryColourDark,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.primaryColourDark,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "${deliveredRequisition}",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                            color: AppColors
                                                .primaryColourDark,
                                            fontSize: 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Delivered Requisition",
                                          style: FTextStyle
                                              .authlogin_signupTxtStyle
                                              .copyWith(
                                              color: AppColors
                                                  .formFieldHintColour,
                                              fontSize: 18),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 14,
                                    top: 9,
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 29,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height:
                        MediaQuery.of(context).size.height * 0.39,
                        child: Center(
                          child: isInitialLoading
                              ? CircularProgressIndicator()
                              : dataMap.isNotEmpty
                              ? Container(
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                title: AxisTitle(
                                    text:
                                    'Unit wise Requisitions'),
                                // isVisible: true,
                                // interval: 1,
                                labelStyle: TextStyle(
                                  color: Colors.transparent,
                                  fontSize: 8,
                                ),
                                labelAlignment:
                                LabelAlignment.start,
                                // maximumLabels: 20,
                                // labelRotation: 90, // Set the label rotation here
                                // Hides the labels
                              ),
                              primaryYAxis: NumericAxis(
                                // title:
                                //     AxisTitle(text: 'Count'),
                                minimum: 0,
                                maximum: dataMap.values
                                    .reduce((a, b) =>
                                a > b ? a : b),
                                interval: 1,
                              ),
                              title: ChartTitle(
                                  text: 'Unit wise Overview'),
                              tooltipBehavior:
                              TooltipBehavior(
                                  enable: true),
                              series: <CartesianSeries>[
                                ColumnSeries<
                                    MapEntry<String, double>,
                                    String>(
                                  name: "Unit Requisitions",
                                  dataSource: dataMap.entries
                                      .toList(),
                                  xValueMapper: (MapEntry<
                                      String,
                                      double>
                                  data,
                                      _) =>
                                  data.key,
                                  yValueMapper: (MapEntry<
                                      String,
                                      double>
                                  data,
                                      _) =>
                                  data.value,
                                  pointColorMapper: (MapEntry<
                                      String, double>
                                  data,
                                      _) {
                                    List<Color> colors = [
                                      Colors.blue,
                                      Colors.green,
                                      Colors.red,
                                      Colors.orange,
                                      Colors.purple,
                                      Colors.teal,
                                      Colors.amber,
                                      Colors.pink,
                                      Colors.brown,
                                      Colors.cyan,
                                      Colors.indigo,
                                      Colors.yellow,
                                    ];
                                    int index = dataMap.keys
                                        .toList()
                                        .indexOf(data.key);
                                    return colors[index %
                                        colors
                                            .length]; // Cycle through colors
                                  },
                                  dataLabelSettings:
                                  DataLabelSettings(
                                      isVisible: true,
                                      labelPosition:
                                      ChartDataLabelPosition
                                          .inside),
                                ),
                              ],
                            ),
                          )
                              : Center(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text("No data available"),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
            
            
            
            
                    ]
                )),
          ),
)
        ),
      ),
    );
  }







  void _showLogDialog(int index) {
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
        nextPage = BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: Dashboard(),
        );
        // Replace with your Admin screen widget
        break;
      case 'Purchase Manager':
        nextPage =  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: AdminDashboard(),
        ); // Replace with your User screen widget
        break;
      case 'Program Director':
        nextPage = BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: AdminDashboard(),
        ); // Replace // Replace with your User screen widget
        break;
      case 'Vendor':
        nextPage =BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: VendorDashboard(),
        ); // Replace


        // Replace with your User screen widget
        break;
      case 'Requester':
        nextPage =BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: RequesterDashboard(),
        ); // Repl

        // Replace with your User screen widget
        break;
      default:


        return; // No navigation occurs if the role is not recognized
    }


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  List<Widget> buildMenuItems(List<Map<String, dynamic>> listItem, String userRole) {
    List<Widget> widgets = [];

    for (int index = 0; index < listItem.length; index++) {
      var item = listItem[index];

      // Check if the item is valid and has the necessary keys
      if (item == null || !item.containsKey('subtitle')) {
        print('Invalid item: $item'); // Log invalid items
        continue; // Skip this item if it's not valid
      }

      // Ensure subtitle is not null
      String subtitle = item['subtitle'] ?? 'Unknown'; // Provide a default value

      // Allow all items for Purchase Manager role
      if (userRole == 'Purchase Manager') {
        if (item.containsKey('subLine') && item['subLine'] != null && item['subLine'].isNotEmpty) {
          widgets.add(
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    leading: Icon(item['icon'],      color: AppColors.aboutUsHeadingColor),
                    title: Text(subtitle, style: FTextStyle.FaqsTxtStyle.copyWith()),
                    initiallyExpanded: _expandedIndex == index,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedIndex = expanded ? index : null;
                      });
                    },
                    children: buildSubMenuItems(item['subLine']),
                  ),
                ),
              ],
            ),
          );
        } else {
          widgets.add(buildListTile(item, index, listItem.length));
          if (index != listItem.length - 1) {
            const Divider(height: 1, color: Colors.grey, thickness: 1.5);
          }
        }
      }
      // Hide Master and Reports for Requester role
      else if (userRole == 'Requester' && (subtitle == 'Master' || subtitle == 'Reports')) {
        continue; // Skip these items
      } else {
        widgets.add(buildListTile(item, index, listItem.length));
      }
    }

    return widgets;
  }

  List<Widget> buildSubMenuItems(List<Map<String, dynamic>>? subItems) {
    if (subItems == null || subItems.isEmpty) return []; // Return empty if subItems is null or empty

    List<Widget> widgets = [];
    for (var item in subItems) {
      if (item == null || !item.containsKey('title')) {
        continue; // Skip invalid sub-items
      }

      String subtitle = item['title'] ?? 'Unknown';
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: Colors.grey[100],
            child: ListTile(
              leading: Icon(item['icon'],color: AppColors.aboutUsTextColor,),
              title: Text(subtitle, style: FTextStyle.Faqssubtitle),
              onTap: () {
                handleSubMenuTap(item);
              },
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget buildListTile(Map<String, dynamic> item, int index, int totalLength) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Visibility(
            visible: index == totalLength - 3 && PrefUtils.getRole() == 'Purchase Manager',
            child: const Divider(height: 1, color: Colors.grey, thickness: 1.5)),
        ListTile(
          leading: Icon(item['icon'],       color: AppColors.aboutUsHeadingColor),
          title: Text(item['subtitle'] ?? 'Unknown', style: FTextStyle.FaqsTxtStyle),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            handleMenuNavigation(item['subtitle']);
          },
        ),
        if (index != totalLength - 1)

          const Divider(height: 1, color: Colors.grey, thickness: 1.5)
      ],
    );
  }





  void handleMenuNavigation(String subtitle) {
    switch (subtitle) {
      case 'Dashboard':
        _navigateBasedOnRole(PrefUtils.getRole());
        break;
      case 'Requisition':
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: VenderRequisition(),
        )));
        break;
      case 'Reports':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
        break;
      case 'Master':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MasterScreen()));
        break;
      case 'My Profile':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileDetails()));
        break;
      case 'Logout':
        _showLogDialog(-1);
        break;
      default:
      // Handle default case if needed
        break;
    }
  }

  void handleSubMenuTap(Map<String, dynamic> subMenuItem) {
    Navigator.pop(context); // Close the drawer after selection

    // Navigate based on the submenu item tapped
    switch (subMenuItem['title']) {
      case 'Product/Category':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BlocProvider(
    create: (context) => AllRequesterBloc(),
    child: ProductCategory(),
    )),
    
        );
        break;
      case 'Product/Services':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BlocProvider(
  create: (context) => AllRequesterBloc(),
  child: ProductService(),
)),
        );
        break;
      case 'Events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BlocProvider(
  create: (context) => AllRequesterBloc(),
  child: EventScreen(),
)),
        );
        break;
      default:
      // Handle other cases if necessary
        break;
    }
  }


}


class PieChartData {
  final String category;
  final double value;

  PieChartData(this.category, this.value);
}


