import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isButtonEnabled = false;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  bool isEmailFieldFocused = false;
  bool isLoading = false;
  final FocusNode _emailFocusNode = FocusNode();
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
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: AppColors.primaryColourDark,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/logowhite.png',
                        width: (displayType == 'desktop' ||
                                displayType == 'tablet')
                            ? 250.w
                            : 190,
                        height: (displayType == 'desktop' ||
                                displayType == 'tablet')
                            ? 100.h
                            : 160,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(150.0),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          (displayType == 'desktop' || displayType == 'tablet')
                              ? 50
                              : 20),
                  children: [

                    const SizedBox(height: 45),
                    Text(
                      Constants.ForgotPassTxt,
                      style: FTextStyle.HeadingTxtStyle.copyWith(
                          fontSize: 30, fontWeight: FontWeight.w900),
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!),

                    const SizedBox(height: 30),
                    Text(
                      Constants.ForgotPassSubTxt,
                      style: FTextStyle.formSubheadingTxtStyle,
                      textAlign: TextAlign.left, // Aligning text to center
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!),

                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 15),
                      child: Form(
                          onChanged: () {
                            if (ValidatorUtils.isValidEmail(_email.text)) {
                              setState(() {
                                isButtonEnabled = true;
                              });
                            } else {
                              setState(() {
                                isButtonEnabled = false;
                              });
                            }
                            if (isEmailFieldFocused == true) {
                              _emailKey.currentState!.validate();
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Constants.emailLabel,
                                style: FTextStyle.formLabelTxtStyle,
                              ).animateOnPageLoad(
                                  animationsMap['imageOnPageLoadAnimation2']!),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: _emailKey,
                                  focusNode: _emailFocusNode,
                                  decoration:
                                      FormFieldStyle.defaultemailDecoration,
                                  inputFormatters: [NoSpaceFormatter()],
                                  controller: _email,
                                  validator: ValidatorUtils.emailValidator,
                                  onTap: () {
                                    setState(() {
                                      isEmailFieldFocused = true;
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          )),
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // BlocProvider.of<AuthFlowBloc>(context).add(ForgotPasswordPatientEventHandler(email: _email.text.toString()
                          // ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26)),
                          backgroundColor: AppColors.primaryColourDark,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(Constants.continueBtnTxt,
                                style: FTextStyle.loginBtnStyle),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BlocProvider(
                        //               create: (context) => AuthFlowBloc(),
                        //               child: const LogScreen(),
                        //             )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Go back to",
                            style: FTextStyle.formLabelTxtStyle,
                          ),
                          Text(
                            Constants.signintoAccountTxt,
                            style: FTextStyle.authlogin_signupTxtStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
