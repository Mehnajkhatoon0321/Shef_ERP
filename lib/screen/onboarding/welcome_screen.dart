import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';

import 'package:shef_erp/screen/auth_flow/login_screen.dart';


import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryColourDark,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.0.w), // Use ScreenUtil for padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28, // 30% of screen height
                ),
                Image.asset(
                  "assets/images/logowhite.png",
                  width: (displayType == 'desktop' || displayType == 'tablet')
                      ? 250.w // Use ScreenUtil for width
                      : 220.w, // Adjust width based on screen size
                  height: (displayType == 'desktop' || displayType == 'tablet')
                      ? 140.h // Use ScreenUtil for height
                      : 140.h, // Adjust height based on screen size
                ),
                SizedBox(height: 5.h), // Use ScreenUtil for spacing
                Text(
                  "Welcome To",
                  style: FTextStyle.HeadingTxtStyle.copyWith(
                    fontSize: 30.sp,
                    color: Colors.white,
                  ),
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                SizedBox(height: 7.h), // Use ScreenUtil for spacing
                Text(
                  "Login an account and access thousand of cool stuffs",
                  style: FTextStyle.formSubheadingTxtStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp, // Use ScreenUtil for font size
                  ),
                  textAlign: TextAlign.center, // Aligning text to center
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1), // 10% of screen height
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen width
                  height: 50.h, // Use ScreenUtil for height
                  child: ElevatedButton(
                    onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => AuthFlowBloc(),
                                    child: LogScreen(),
                                  )),
                        );

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r), // Use ScreenUtil for radius
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "Get Started",
                      style: FTextStyle.loginBtnStyle.copyWith(
                        color: AppColors.primaryColourDark,
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  BlocProvider(
  create: (context) => AuthFlowBloc(),
  child: LogScreen(),
)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you have an account ?",
                        style: FTextStyle.formLabelTxtStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp, // Use ScreenUtil for font size
                        ),
                      ),
                      Text(
                        Constants.signintoAccountTxt,
                        style: FTextStyle.authlogin_signupTxtStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h), // Use ScreenUtil for spacing
              ],
            ),
          ),
        ),
      ),
    );}

}