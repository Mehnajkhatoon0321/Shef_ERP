import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/authflow/auth_flow_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/auth_flow/forgot_password.dart';
import 'package:shef_erp/screen/dashboard/admin_dashboard.dart';
import 'package:shef_erp/screen/dashboard/dashboard.dart';
import 'package:shef_erp/screen/dashboard/requester_dashboard.dart';
import 'package:shef_erp/screen/dashboard/vender_dashboard.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shef_erp/utils/validator_utils.dart';



class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormFieldState<String>> _emailKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
  GlobalKey<FormFieldState<String>>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool passwordVisible = false;
  bool checkboxChecked = false;
  bool isButtonEnabled = false;
  bool passIncorrect = false;
  bool emailIncorrect = false;


  bool isEmailFieldFocused = false;
  bool isPasswordFieldFocused = false;

  bool isValidPass(String pass) {
    if (pass.isEmpty) {
      return false;
    }
    return true;
  }

  bool isLoading = false;
  bool rememberMe = false;
  String? userRole;

  @override
  void initState() {
    super.initState();
    checkboxChecked = PrefUtils.getRememberMe();
    if (checkboxChecked) {
      _emailController.text = PrefUtils.getInsideEmailLogin();
      _password.text = PrefUtils.getUserPassword();
    }

    _emailController.addListener(_updateButtonState);
    _password.addListener(_updateButtonState);
    _updateButtonState();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = checkboxChecked &&
          _emailController.text.isNotEmpty &&
          _password.text.isNotEmpty;
    });
  }
  @override
  void dispose() {
    _emailController.dispose();
    _password.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
    var displayType = valueType
        .toString()
        .split('.')
        .last;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthFlowBloc, AuthFlowState>(
          listener: (context, state) {
            if (state is AuthFlowLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is LogSuccess) {
              setState(() {
                isLoading = false;
                PrefUtils.setIsLogin(true);
                if (checkboxChecked) {
                  PrefUtils.setInsideEmailLogin(_emailController.text);
                  PrefUtils.setUserPassword(_password.text);
                }
              });

              Map<String, dynamic> data = state.logResponse;

              print('LoginResponse>>>>>>>>$data');
              if (data.containsKey('token') && data.containsKey('user')) {
                String bearerToken = data['token'];
                Map<String, dynamic> user = data['user'];

                if (user.containsKey('role')) {
                  String roleUser = user['role'];
                  int roleId = user['id'];
                  String email = user['email'];
                  String name = user['name'];

                  // Save token
                  PrefUtils.setToken(bearerToken);
                  // Save user
                  PrefUtils.setRole(roleUser);
                  // Save  role
                  PrefUtils.setUserId(roleId);
                  PrefUtils.setUserEmailLogin(email);
                  PrefUtils.setInsideEmailLogin(email);
                  PrefUtils.setUserName(name);


                  _navigateBasedOnRole(roleUser);
                }
              }
            } else if (state is LogFailure) {
              setState(() {
                isLoading = false;
              });

              CommonPopups.showCustomPopup(context, state.failureMessage);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
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
                                : 180,
                            height: (displayType == 'desktop' ||
                                displayType == 'tablet')
                                ? 100.h
                                : 170,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(170.0),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: (displayType == 'desktop' ||
                            displayType == 'tablet')
                            ? 50
                            : 20,
                      ),
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: Text(
                            Constants.welcomeTxt,
                            style: FTextStyle.HeadingTxtStyle.copyWith(
                              fontSize: 30,
                              // fontWeight: FontWeight.w900
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation2']!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Form(
                            key: formKey,
                            onChanged: () {
                              if (ValidatorUtils.isValidEmail(
                                  _emailController.text) &&
                                  isValidPass(_password.text)) {
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
                              if (isPasswordFieldFocused == true) {
                                _passwordKey.currentState!.validate();
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  Constants.emailLabel,
                                  style: FTextStyle.formLabelTxtStyle,
                                ).animateOnPageLoad(animationsMap[
                                'imageOnPageLoadAnimation2']!),
                                const SizedBox(height: 5),
                                TextFormField(
                                  key: _emailKey,
                                  focusNode: _emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                  FormFieldStyle.defaultemailDecoration,
                                  inputFormatters: [NoSpaceFormatter()],
                                  controller: _emailController,
                                  validator: ValidatorUtils.emailValidator,
                                  onTap: () {
                                    setState(() {
                                      isEmailFieldFocused = true;
                                      isPasswordFieldFocused = false;
                                    });
                                  },
                                ).animateOnPageLoad(animationsMap[
                                'imageOnPageLoadAnimation2']!),
                                const SizedBox(height: 15),
                                Text(
                                  "Password",
                                  style: FTextStyle.formLabelTxtStyle,
                                ).animateOnPageLoad(animationsMap[
                                'imageOnPageLoadAnimation2']!),
                                const SizedBox(height: 5),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  key: _passwordKey,
                                  focusNode: _passwordFocusNode,
                                  decoration: FormFieldStyle
                                      .defaultPasswordInputDecoration
                                      .copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black45,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    fillColor: AppColors.formFieldBackColour,
                                  ),
                                  controller: _password,
                                  obscureText: !passwordVisible,
                                  inputFormatters: [NoSpaceFormatter()],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter password";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    setState(() {
                                      isPasswordFieldFocused = true;
                                      isEmailFieldFocused = false;
                                    });
                                  },
                                ).animateOnPageLoad(animationsMap[
                                'imageOnPageLoadAnimation2']!),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      checkboxChecked = !checkboxChecked;
                                      print(
                                          'Checkbox checked: $checkboxChecked');

                                      PrefUtils.setRememberMe(checkboxChecked);

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: IconTheme(
                                      data: const IconThemeData(
                                        color: AppColors.primaryColourDark,
                                        size: 20,
                                      ),
                                      child: Icon(
                                        checkboxChecked
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                      ),
                                    ),
                                  ),
                                ),

                                Text(
                                  Constants.rememberMeTxt,
                                  style: FTextStyle.rememberMeTextStyle,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const ForgotPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                Constants.forgotPassword,
                                style: FTextStyle.forgotPasswordTxtStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 65),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // All fields are valid, proceed with submission
                                    setState(() {
                                      isLoading = true; // Start loading
                                    });
                                    BlocProvider.of<AuthFlowBloc>(context)
                                        .add(
                                      LogEventHandler(
                                        email: _emailController.text.toString(),
                                        password: _password.text.toString(),
                                      ),
                                    );
                                    // Determine whether to update or create a vendor

                                  } else {
                                    // If any field is invalid, trigger validation error display
                                    formKey.currentState!.validate();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  backgroundColor: isButtonEnabled
                                      ? AppColors.primaryColourDark
                                      : AppColors.formFieldBorderColour,
                                ),
                                child: isLoading
                                    ? CircularProgressIndicator(
                                    color: Colors.white)
                                    : Text(
                                    "Login", style: FTextStyle.loginBtnStyle),
                              ),
                            ),
                          ),
                        )
                            .animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
        nextPage = BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: AdminDashboard(),
        ); // Replace with your User screen widget
        break;
      case 'Program Director':
        nextPage = BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: RequesterDashboard(),
        ); // Replace // Replace with your User screen widget
        break;
      case 'Vendor':
        nextPage = BlocProvider(
          create: (context) => AllRequesterBloc(),
          child: VendorDashboard(),
        ); // Replace


        // Replace with your User screen widget
        break;
      case 'Requester':
        nextPage = BlocProvider(
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
}
