import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/auth_flow/login_screen.dart';
import 'package:shef_erp/screen/auth_flow/navigation.dart';
import 'package:shef_erp/screen/auth_flow/profile_details.dart';
import 'package:shef_erp/screen/dashboard/admin_dashboard.dart';
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
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _items = [
    {
      "title": "All Requisitions",
      "total": "21",
      "image": "https://via.placeholder.com/150"
    },
    {
      "title": "Today's Requisitions",
      "total": "12",
      "image": "https://via.placeholder.com/150"
    },
  ];

  String? userRole;
  List<Map<String, dynamic>> listItem = [
    {'subtitle': 'Dashboard', 'icon': Icons.dashboard},
    {'subtitle': 'Requisition', 'icon': Icons.list_alt},
    {'subtitle': 'Reports', 'icon': Icons.request_page_outlined},
    {'subtitle': 'Master', 'icon': Icons.book},
    {'subtitle': 'My Profile', 'icon': Icons.person},
    {'subtitle': 'Logout', 'icon': Icons.logout},
  ];

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;


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
            children: [
              Text(
                "Welcome to Unit Head",
                style: FTextStyle.HeadingTxtStyle.copyWith(fontSize: 28, color: Colors.black),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      bool isEvenIndex = index % 2 == 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        decoration: BoxDecoration(
                          color: isEvenIndex ? Colors.blue : Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: isEvenIndex ? Colors.blue.shade700 : Colors.yellow.shade700,
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
                            children: [
                              Text(
                                item['total'],
                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item['title'],
                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
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
                Text("Are you sure you want to logout?", style: FTextStyle.preHeadingStyle),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.formFieldBackColour,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      ),
                      child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColourDark,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      ),
                      child: const Text("OK", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthFlowBloc(),
                              child: const LogScreen(),
                            ),
                          ),
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
        nextPage = const Dashboard();
        break;
      case 'super-admin':
        nextPage = const Navigation();
        break;
      case 'Purchase Manager':
        nextPage = const AdminDashboard();
        break;
      case 'Program Director':
        nextPage = const AdminDashboard();
        break;
      case 'Vendor':
        nextPage = const VendorDashboard();
        break;
      case 'Requester':
        nextPage = const RequesterDashboard();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextPage));
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
