import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';

import 'package:shef_erp/screen/auth_flow/login_screen.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class RequesterDashboard extends StatefulWidget {
  const RequesterDashboard({super.key});

  @override
  State<RequesterDashboard> createState() => _RequesterDashboardState();
}

class _RequesterDashboardState extends State<RequesterDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> _items = [
    {"title": "All Requisitions","total": "21", "image": "https://via.placeholder.com/150"},
    {"title": "Today,s Requisitions","total": "12", "image": "https://via.placeholder.com/150"},
    {"title": "Pending Requisitions","total": "33", "image": "https://via.placeholder.com/150"},
    {"title": "Delivered Requisition","total": "4", "image": "https://via.placeholder.com/150"}
  ];

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

          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),

        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Welcome to Requester ",style: FTextStyle.HeadingTxtStyle.copyWith(
                  fontSize: 28,
                  color: Colors.black
                // fontWeight: FontWeight.w900
              ),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 20),
                  child: ListView.builder(
                    itemCount: _items.length, // Number of items
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      bool isEvenIndex = index % 2 == 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15.0), // Spacing between rows
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
}
