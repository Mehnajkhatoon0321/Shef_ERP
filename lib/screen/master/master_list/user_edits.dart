import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/user_list.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class UserEdits extends StatefulWidget {
  String screenflag;
  String id;

  UserEdits({required this.screenflag, required this.id, super.key});

  @override
  State<UserEdits> createState() => _UserEditsState();
}

class _UserEditsState extends State<UserEdits> {
  @override
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
  bool isButtonEnabled = true;
  bool isLoadingEdit = false;
  String? selectedUnitItem;
  String? selectedRoleItem;
  bool isEmailFieldFocused = false;
  bool isPasswordFieldFocused = false;
  String? selectedRoleId;
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  final formKey = GlobalKey<FormState>();
  late final TextEditingController editController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController designationController =
      TextEditingController();
  late final TextEditingController passwsordController =
      TextEditingController();
  late final GlobalKey<FormFieldState<String>> _unitNameKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _roleNameKey =
      GlobalKey<FormFieldState<String>>();
  Map<String, dynamic> responseData = {};
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  String? unitFromList;
  List<dynamic> listData = [];
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  bool isValidPass(String pass) {
    if (pass.isEmpty) {
      return false;
    }
    return true;
  }

  void initState() {
    if (widget.screenflag.isNotEmpty) {
      // emailController.text=widget.email;
      // editController.text=widget.name;
    }

    BlocProvider.of<AllRequesterBloc>(context)
        .add(EditDetailUserHandler(widget.id));
    super.initState();
  }

  late final FocusNode _unitNameNode = FocusNode();
  late final FocusNode _roleNameNode = FocusNode();
  List<String> UnitNames = [];
  List<String> RolesNames = [];
  List<dynamic> RoleDataList = [];
  List<dynamic> UnitsDataList = [];
  String? selectedUnitId;
  late final FocusNode _specificationNameNode = FocusNode();
  late final TextEditingController specificationName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    return Scaffold(
      backgroundColor: AppColors.formFieldBorderColour,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.screenflag.isEmpty ? 'User Create ' : "User Edit",
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColourDark,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: BlocListener<AllRequesterBloc, AllRequesterState>(
        listener: (context, state) {
          if (state is UserEditDetailsLoading) {
          } else if (state is UserEditDetailsSuccess) {
            setState(() {
              isLoadingEdit = false;

              responseData = state.userEditDeleteList;

              RoleDataList = state.userEditDeleteList['roles'];

              RolesNames =
                  RoleDataList.map<String>((item) => item['name'] as String)
                      .toList();
              print("AllData>>>>${responseData}");
              var user = state.userEditDeleteList['user'] ?? {};

              listData = state.userEditDeleteList['units'];
              UnitNames = listData
                  .map<String>((item) => item['name'] as String)
                  .toList();

              if (user.isNotEmpty && widget.screenflag.isNotEmpty) {
                // Set user details
                emailController.text = user["email"] ?? '';
                editController.text = user["name"] ?? '';
                addressController.text = user["address"] ?? '';
                designationController.text = user["designation"] ?? '';
                descriptionController.text = user["contact"] ?? '';

                // Set role
                selectedRoleItem = (user['roles']?.isNotEmpty ?? false)
                    ? user['roles'][0]['name']
                    : '';

                // Set the selected unit based on user unit ID
                String userUnitId = user['unit'] ?? '';
                var unit = listData.firstWhere(
                  (u) => u['id'].toString() == userUnitId,
                  orElse: () => null,
                );

                if (unit != null) {
                  selectedUnitItem = unit['name'];
                  selectedUnitId = unit['id']
                      .toString(); // Set the ID directly if the unit is found
                } else {
                  selectedUnitItem = null;
                  selectedUnitId =
                      null; // Ensure ID is also null if no unit is found
                }
              }
            });
          } else if (state is UserEditDetailsFailure) {
            setState(() {
              isLoadingEdit = false;
            });
            if (kDebugMode) {
              print("error>> ${state.deleteEditFailure}");
            }
          }
          if (state is UserUpdateLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          } else if (state is UserCreateLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          } else if (state is UserCreateSuccess) {
            setState(() {
              isLoadingEdit = false;

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => AllRequesterBloc(),
                          child: const UserList(),
                        )),
              );
            });
          } else if (state is UserCreateFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.failureMessage.toString());
          } else if (state is CheckNetworkConnection) {
            CommonPopups.showCustomPopup(
              context,
              'Internet is not connected.',
            );
          } else if (state is UserUpdateSuccess) {
            setState(() {
              isLoadingEdit = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => AllRequesterBloc(),
                          child: const UserList(),
                        )),
              );
            });
          } else if (state is UserUpdateFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.failureMessage.toString());
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
              onChanged: () {
                // Update button enable state based on field validity
                setState(() {
                  isButtonEnabled = selectedUnitItem != null &&
                      selectedUnitItem!.isNotEmpty &&
                      selectedRoleItem != null &&
                      selectedRoleItem!.isNotEmpty &&
                      ValidatorUtils.isValidEmail(emailController.text) &&
                      isValidPass(passwsordController.text);

                  if (isEmailFieldFocused == true) {
                    _emailKey.currentState!.validate();
                  }
                  if (isPasswordFieldFocused == true) {
                    _passwordKey.currentState!.validate();
                  }
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Role",
                      style: FTextStyle.preHeadingStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      border: Border.all(
                          color: AppColors.formFieldHintColour, width: 1.3),
                      color: AppColors.formFieldBackColour,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: _roleNameKey,
                        focusNode: _roleNameNode,
                        isExpanded: true,
                        value: selectedRoleItem,
                        // This should reflect the current user's role
                        hint: const Text(
                          "Select Role",
                          style: FTextStyle.formhintTxtStyle,
                        ),
                        onChanged: (String? eventValue) {
                          setState(() {
                            selectedRoleItem =
                                eventValue; // Update the selected role
                            isButtonEnabled =
                                eventValue != null && eventValue.isNotEmpty;
                          });
                        },
                        items: RolesNames.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Unit Name",
                      style: FTextStyle.preHeadingStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      border: Border.all(
                          color: AppColors.formFieldHintColour, width: 1.3),
                      color: AppColors.formFieldBackColour,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: _unitNameKey,
                        focusNode: _unitNameNode,
                        isExpanded: true,
                        value: selectedUnitItem,
                        // This should reflect the current user's unit
                        hint: const Text(
                          "Select Unit",
                          style: FTextStyle.formhintTxtStyle,
                        ),
                        onChanged: (String? eventValue) {
                          setState(() {
                            selectedUnitItem =
                                eventValue; // Update the selected unit

                            // Update the selectedUnitId based on the selected unit
                            selectedUnitId = UnitsDataList.firstWhere(
                              (unit) => unit['name'] == eventValue,
                              orElse: () => {'id': '', 'name': ''},
                            )['id']
                                as String; // Ensure we safely cast to String

                            // Update button enabled state
                            isButtonEnabled =
                                eventValue != null && eventValue.isNotEmpty;
                          });
                        },
                        items: UnitNames.map<DropdownMenuItem<String>>(
                            (String unitName) {
                          return DropdownMenuItem<String>(
                            value: unitName, // Use the unit name as the value
                            child: Text(unitName),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Name", style: FTextStyle.preHeadingStyle),
                  ),
                  TextFormField(
                    controller: editController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an Name';
                      }
                      return null;
                    },
                  ),
                  Text(
                    Constants.emailLabel,
                    style: FTextStyle.preHeadingStyle,
                  ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!),
                  const SizedBox(height: 5),
                  TextFormField(
                    key: _emailKey,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    inputFormatters: [NoSpaceFormatter()],
                    controller: emailController,
                    validator: ValidatorUtils.emailValidator,
                    onTap: () {
                      setState(() {
                        isPasswordFieldFocused = false;
                        isEmailFieldFocused = true;
                      });
                    },
                  ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Event Contact",
                          style: FTextStyle.preHeadingStyle)),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Enter Contact",
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:
                          Text("Address", style: FTextStyle.preHeadingStyle)),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: "Enter Address",
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a address';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Designation",
                          style: FTextStyle.preHeadingStyle)),
                  TextFormField(
                    controller: designationController,
                    decoration: InputDecoration(
                      hintText: "Enter Designation",
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a designation';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:
                          Text("Password", style: FTextStyle.preHeadingStyle)),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    key: _passwordKey,
                    focusNode: _passwordFocusNode,
                    controller: passwsordController,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.formFieldHintColour, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        isPasswordFieldFocused = true;
                        isEmailFieldFocused = false;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: (displayType == 'desktop' ||
                                  displayType == 'tablet')
                              ? 70
                              : 40,
                          child: ElevatedButton(
                              onPressed: isButtonEnabled
                                  ? () async {
                                      setState(() {
                                        isLoadingEdit = true;
                                      });
                                      if (widget.screenflag.isNotEmpty) {
                                        BlocProvider.of<AllRequesterBloc>(
                                                context)
                                            .add(
                                          UserUpdateEventHandler(
                                            id: widget.id.toString(),
                                            name:
                                                editController.text.toString(),

                                            address: addressController.text
                                                .toString(),
                                            email:
                                                emailController.text.toString(),
                                            contact: descriptionController.text
                                                .toString(),

                                            unitID: selectedRoleItem ==
                                                    'Purchase Manager'
                                                ? '0'
                                                : (selectedUnitId ?? '0'),
                                            // Pass the selected unit ID
                                            role: selectedRoleItem.toString(),
                                            // Pass the selected role name

                                            password: passwsordController.text
                                                .toString(),
                                            designation: designationController
                                                .text
                                                .toString(),
                                          ),
                                        );
                                      } else {
                                        BlocProvider.of<AllRequesterBloc>(
                                                context)
                                            .add(
                                          UserCreateEventHandler(
                                            id: widget.id.toString(),
                                            name:
                                            editController.text.toString(),

                                            address: addressController.text
                                                .toString(),
                                            email:
                                            emailController.text.toString(),
                                            contact: descriptionController.text
                                                .toString(),

                                            unitID: selectedRoleItem ==
                                                'Purchase Manager'
                                                ? '0'
                                                : (selectedUnitId ?? '0'),
                                            // Pass the selected unit ID
                                            role: selectedRoleItem.toString(),
                                            // Pass the selected role name

                                            password: passwsordController.text
                                                .toString(),
                                            designation: designationController
                                                .text
                                                .toString(),
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                backgroundColor: isButtonEnabled
                                    ? AppColors.primaryColourDark
                                    : AppColors.disableButtonColor,
                              ),
                              child: isLoadingEdit
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Save",
                                      style: FTextStyle.loginBtnStyle,
                                    )),
                        )),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
