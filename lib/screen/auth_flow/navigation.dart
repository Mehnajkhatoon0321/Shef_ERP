import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shef_erp/screen/dashboard/dashboard.dart';
import 'package:shef_erp/screen/reports/reports.dart';
import 'package:shef_erp/screen/requisition/requisition.dart';
import 'package:shef_erp/screen/requisition/vendor_requisition.dart';
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
  final List<Map<String, dynamic>> listItem = [
    {
      "image": "assets/images/dashboard.png",
      "title": 'Dashboard',
    },
    {
      "image": "assets/images/requisition.png",
      "title": 'Requisition',
    },
    {
      "image": "assets/images/requisition.png",
      "title": 'Reports',
    },
  ];
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
  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
        break;
      case 1:
        userRole == 'Unit Head'?
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const VenderRequisition()),
    ):
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RequisitionScreen()),
        );


        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ReportScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define common dimensions based on screen size
    double profileImageWidth = (displayType == 'desktop' || displayType == 'tablet') ? screenWidth * 0.4 : screenWidth * 0.4;
    double profileImageHeight = (displayType == 'desktop' || displayType == 'tablet') ? screenHeight * 0.14 : screenHeight * 0.14;
    double containerHeight =(displayType == 'desktop' || displayType == 'tablet') ? screenHeight * 0.55:screenHeight * 0.5;
    double servicesContainerHeight = (displayType == 'desktop' || displayType == 'tablet') ?screenHeight * 0.6:screenHeight * 0.65; // Remaining height for services section

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: containerHeight,
              decoration: BoxDecoration(
                // gradient: linearGradient(250, ['#1c217d', '#f6f6f6']),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // SizedBox(height: screenHeight * 0.05),
                        Padding(
                          padding: EdgeInsets.only(top:(displayType == 'desktop' || displayType == 'tablet') ? screenHeight * 0.04:screenHeight * 0.07, right: screenWidth * 0.04),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: profileImageWidth,
                              height: profileImageHeight,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle, // Ensure the container is circular
                                image: DecorationImage(
                                  image: AssetImage('assets/images/profile.png'),
                                  fit: BoxFit.cover, // Adjust fit as needed
                                ),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left:(displayType == 'desktop' || displayType == 'tablet') ? screenWidth * 0.04:screenWidth * 0.06, top:(displayType == 'desktop' || displayType == 'tablet') ? screenHeight * 0.02:screenHeight * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome To !",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.07,
                                    // fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontFamily: 'Outfit-SemiBold',
                                  ),
                                ),
                                Text(
                                  "Mehnaj Khatoon",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
                ],
              ),
            ),
          ),
          Positioned(
            top: containerHeight * 0.75, // Adjust based on the container height
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColourDark,
                borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(screenWidth * 0.05),
                  // topRight: Radius.circular(screenWidth * 0.05),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.07, ),
                    child: Text(
                      "Services",
                      style: FTextStyle.HeadingTxtStyle.copyWith(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Container(
                      height: servicesContainerHeight,
                      child: GridView.builder(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: userRole == 'Unit Head'?3:2,
                          crossAxisSpacing: screenWidth * 0.02,
                          mainAxisSpacing: screenHeight * 0.02,
                        ),
                        itemCount: listItem.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _onTap(context, index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.formFieldBorderColour,
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
                                        width:(displayType == 'desktop' || displayType == 'tablet') ? screenWidth * 0.15 :screenWidth * 0.15,
                                        height: (displayType == 'desktop' || displayType == 'tablet') ?screenWidth * 0.15:screenWidth * 0.15,
                                        color: Colors.grey,
                                        child: Image.asset(
                                          listItem[index]["image"],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    listItem[index]["title"],
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}

