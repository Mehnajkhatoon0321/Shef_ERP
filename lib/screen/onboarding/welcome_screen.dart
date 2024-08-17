import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/screen/onboarding/auth_flow/login_screen.dart';

import 'package:shef_erp/screen/onboarding/onboarding.dart';
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
    var displayType = valueType
        .toString()
        .split('.')
        .last;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: AppColors.primaryColour,
        // backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/3,
              ),
              Image.asset("assets/images/logowhite.png",   width: (displayType == 'desktop' || displayType == 'tablet')
                  ? 250.w
                  : 220,
                height: (displayType == 'desktop' || displayType == 'tablet')
                    ? 140.h
                    : 140,),
              const SizedBox(height:20),
              Text(
                "Welcome To",
                style: FTextStyle.HeadingTxtStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  color: Colors.white
                )).animateOnPageLoad(animationsMap[
              'imageOnPageLoadAnimation2']!),
              const SizedBox(height:5),
              Text(
                "Login an account and access thousand of cool stuffs",
                style: FTextStyle.formSubheadingTxtStyle.copyWith(color: Colors.white,fontSize: 18),
                textAlign: TextAlign.center, // Aligning text to center
              ).animateOnPageLoad(animationsMap[
              'imageOnPageLoadAnimation2']!),
               SizedBox(height:MediaQuery.of(context).size.height/9,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,  // 80% of the screen width
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const OnboardingScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Get Started",
                    style: FTextStyle.loginBtnStyle.copyWith(color: AppColors.primaryColour),
                  ),
                ),
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),

              const SizedBox(height:20),
              GestureDetector(
                onTap: () {         Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogScreen()));

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account ?",
                      style: FTextStyle.formLabelTxtStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      Constants.signintoAccountTxt,
                      style: FTextStyle.authlogin_signupTxtStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),

    );
  }
}