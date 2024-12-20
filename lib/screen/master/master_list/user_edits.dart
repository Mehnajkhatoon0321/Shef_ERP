import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/user_list.dart';

import 'package:shef_erp/utils/colours.dart';

import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
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
  bool isButtonEnabled = false;
  bool isLoadingEdit = false;
  // String? selectedUnitItem;
  String? selectedRoleItem;
  List<String> selectedUnitItem = [];
  List<dynamic> selectedUnitId = [];
  // String? selectedRoleId;
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController contactController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController designationController =
      TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final GlobalKey<FormFieldState<String>> _unitNameKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _roleNameKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _contactKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _addressKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _designationKey =
      GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  Map<String, dynamic> responseData = {};
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _unitNameNode = FocusNode();
  final FocusNode _roleNameNode = FocusNode();
  final FocusNode _contactFocusedNode = FocusNode();
  final FocusNode _addressFocusedNode = FocusNode();
  final FocusNode _designationFocusedNode = FocusNode();
  final FocusNode _nameFocusedNode = FocusNode();
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;
  bool isEmailFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isUnitNameFieldFocused = false;
  bool isRoleNameFieldFocused = false;
  bool isContactFieldFocused = false;
  bool isAddressFieldFocused = false;
  bool isDesignationFieldFocused = false;
  bool isNameFieldFocused = false;
  void _updateButtonState() {
    setState(() {
      isButtonEnabled =widget.screenflag.isEmpty
          ?
      (

              selectedUnitItem.isNotEmpty &&
          selectedRoleItem != null &&
          selectedRoleItem!.isNotEmpty &&
          nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          contactController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          designationController.text.isNotEmpty
      )
          :
      (
      selectedUnitItem.isNotEmpty &&
      selectedRoleItem != null &&
      selectedRoleItem!.isNotEmpty &&
      nameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&

      contactController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      designationController.text.isNotEmpty);

      // Validate fields
      if (isEmailFieldFocused) {
        _emailKey.currentState!.validate();
      }
      if (isPasswordFieldFocused) {
        _passwordKey.currentState!.validate();
      }
      if (isUnitNameFieldFocused) {
        _unitNameKey.currentState!.validate();
      }
      if (isRoleNameFieldFocused) {
        _roleNameKey.currentState!.validate();
      }
      if (isContactFieldFocused) {
        _contactKey.currentState!.validate();
      }
      if (isAddressFieldFocused) {
        _addressKey.currentState!.validate();
      }
      if (isDesignationFieldFocused) {
        _designationKey.currentState!.validate();
      }
      if (isNameFieldFocused) {
        _nameKey.currentState!.validate();
      }
    });
  }

  
  
  String? unitFromList;
  List<dynamic> listData = [];

  void initState() {
    BlocProvider.of<AllRequesterBloc>(context)
        .add(EditDetailUserHandler(widget.id));
    isButtonEnabled ==
        selectedUnitItem.isNotEmpty &&
        selectedRoleItem != null &&
        selectedRoleItem!.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&

        contactController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        designationController.text.isNotEmpty;

    super.initState();
  }

  bool _hasPressedSaveButton = false;
  bool _hasRoleSaveButton = false;


  List<String> UnitNames = [];
  List<String> RolesNames = [];
  List<dynamic> RoleDataList = [];

  // String? selectedUnitId;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
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
            }
            else if (state is UserEditDetailsSuccess) {
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
                  nameController.text = user["name"] ?? '';
                  addressController.text = user["address"] ?? '';
                  designationController.text = user["designation"] ?? '';
                  contactController.text = user["contact"] ?? '';

                  // Set role
                  selectedRoleItem = (user['roles']?.isNotEmpty ?? false)
                      ? user['roles'][0]['name']
                      : '';

                  // Get the user unit IDs from the 'unit' field, which is a comma-separated string
                  String userUnitIds = user['unit'] ?? '';
                  List<String> unitIds = userUnitIds.split(',');

                  // Find the corresponding unit names and IDs based on the unitIds
                  var selectedUnits = listData.where((unit) =>
                      unitIds.contains(unit['id'].toString())).toList();

                  if (selectedUnits.isNotEmpty) {
                    selectedUnitItem = selectedUnits
                        .map<String>((unit) => unit['name'] as String)
                        .toList(); // Set the list of unit names

                    selectedUnitId = selectedUnits
                        .map<String>((unit) => unit['id'].toString())
                        .toList(); // Set the list of unit IDs as strings
                  } else {
                    selectedUnitItem = []; // Clear the list if no units found
                    selectedUnitId = [];   // Clear the list if no units found
                  }
                }

              });
            }
            else if (state is UserEditDetailsFailure) {
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
              isLoadingEdit = false;

              if (state.createResponse.containsKey('message')) {
                var deleteMessage = state.createResponse['message'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(deleteMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
              }


              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context,[true]);
              });
            } else if (state is UserCreateFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                  context, state.failureMessage['message'].toString());
            } else if (state is CheckNetworkConnection) {
              CommonPopups.showCustomPopup(
                context,
                'Internet is not connected.',
              );
            } else if (state is UserUpdateSuccess) {
              isLoadingEdit = false;

              if (state.updateResponse.containsKey('message')) {
                var deleteMessage = state.updateResponse['message'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(deleteMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
              }

              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context,[true]);
              });
            } else if (state is UserUpdateFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                  context, state.failureMessage.toString());
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formKey,
                onChanged: _updateButtonState,
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
                              selectedRoleItem = eventValue;

                              _updateButtonState();// Update the selected role


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
                    if (_hasRoleSaveButton && selectedRoleItem == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 6),
                        child: Text(
                          "Please select a role",
                          style: FTextStyle.formErrorTxtStyle,
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
                          color: AppColors.formFieldHintColour,
                          width: 1.3,
                        ),
                        color: AppColors.formFieldBackColour,
                      ),
                      child: InkWell(
                        onTap: () => _showMultiSelectDialog(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text.rich(
                                    TextSpan(
                                      children: selectedUnitItem.isNotEmpty
                                          ? selectedUnitItem.map((unit) {
                                        return TextSpan(
                                          text: unit + ', ', // Add a comma and space
                                          style: FTextStyle.formhintTxtStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,fontSize: 16.2// Make text bold
                                          ),
                                        );
                                      }).toList()
                                          : [
                                        TextSpan(
                                          text: "Select Unit",
                                          style: FTextStyle.formhintTxtStyle,
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis, // Show "..." if text exceeds available space
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: () => _showMultiSelectDialog(context), // Open dialog on icon tap
                            ),
                          ],
                        ),
                      ),
                    )
,



                    if (_hasPressedSaveButton && selectedUnitItem == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 6),
                        child: Text(
                          "Please select a unit",
                          style: FTextStyle.formErrorTxtStyle,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Name", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      key: _nameKey,
                      focusNode: _nameFocusedNode,
                      controller: nameController,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Name",
                      ),
                        onChanged: (value) => _updateButtonState(),
                        onTap: (){

                         isEmailFieldFocused = false;
                         isPasswordFieldFocused = false;
                         isUnitNameFieldFocused = false;
                         isRoleNameFieldFocused = false;
                         isContactFieldFocused = false;
                         isAddressFieldFocused = false;
                         isDesignationFieldFocused = false;
                         isNameFieldFocused = true;
                      },
                      validator: ValidatorUtils.simpleNameValidator
                    ),
                    Text(
                      Constants.emailLabel,
                      style: FTextStyle.preHeadingStyle,
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!),
                    const SizedBox(height: 5),
                    TextFormField(
                      key: _emailKey,
                      onChanged: (value) => _updateButtonState(),
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Email",
                      ),
                      inputFormatters: [NoSpaceFormatter()],
                      controller: emailController,
                      validator: ValidatorUtils.emailValidator,
                      onTap: () {
                        setState(() {
                          isPasswordFieldFocused = false;
                          isEmailFieldFocused = true;
                          isUnitNameFieldFocused = false;
                          isRoleNameFieldFocused = false;
                          isContactFieldFocused = false;
                          isAddressFieldFocused = false;
                          isDesignationFieldFocused = false;
                          isNameFieldFocused = true;
                        });
                      },
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Event Contact",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                        key: _contactKey,
                        onChanged: (value) => _updateButtonState(),
                        focusNode: _contactFocusedNode,
                        controller: contactController,
                        keyboardType: TextInputType.number,
                        decoration:
                            FormFieldStyle.defaultInputEditDecoration.copyWith(
                          fillColor: Colors.grey[100],
                          filled: true,
                          hintText: "Enter Contact",
                        ),
                        onTap: (){

                          isEmailFieldFocused = false;
                          isPasswordFieldFocused = false;
                          isUnitNameFieldFocused = false;
                          isRoleNameFieldFocused = false;
                          isContactFieldFocused = true;
                          isAddressFieldFocused = false;
                          isDesignationFieldFocused = false;
                          isNameFieldFocused = false;
                        },
                        validator: ValidatorUtils.mobileNumberValidator),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:
                            Text("Address", style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                        key: _addressKey,
                        focusNode: _addressFocusedNode,
                        onChanged: (value) => _updateButtonState(),
                        controller: addressController,
                        decoration:
                            FormFieldStyle.defaultInputEditDecoration.copyWith(
                          fillColor: Colors.grey[100],
                          filled: true,
                          hintText: "Enter Address",
                        ),
                        onTap: (){

                          isEmailFieldFocused = false;
                          isPasswordFieldFocused = false;
                          isUnitNameFieldFocused = false;
                          isRoleNameFieldFocused = false;
                          isContactFieldFocused = false;
                          isAddressFieldFocused = true;
                          isDesignationFieldFocused = false;
                          isNameFieldFocused = false;
                        },
                        validator: ValidatorUtils.addressValidator),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Designation",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      key: _designationKey,
                      focusNode: _designationFocusedNode,
                      controller: designationController,
                      onChanged: (value) => _updateButtonState(),
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Designation",
                      ),
                      onTap: (){

                        isEmailFieldFocused = false;
                        isPasswordFieldFocused = false;
                        isUnitNameFieldFocused = false;
                        isRoleNameFieldFocused = false;
                        isContactFieldFocused = false;
                        isAddressFieldFocused = false;
                        isDesignationFieldFocused = true;
                        isNameFieldFocused = false;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a designation';
                        }
                        return null;
                      },
                    ),

                    Visibility(
                      visible:  widget.screenflag.isEmpty,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child:
                              Text("Password", style: FTextStyle.preHeadingStyle)),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            key: _passwordKey,
                            focusNode: _passwordFocusNode,
                            controller: passwordController,
                            onChanged: (value) => _updateButtonState(),
                            decoration:
                            FormFieldStyle.defaultInputEditDecoration.copyWith(
                              hintText: "Enter Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
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
                            validator: ValidatorUtils.passwordValidator,
                            obscureText: !passwordVisible,
                            inputFormatters: [NoSpaceFormatter()],
                            onTap: () {
                              setState(() {
                                isPasswordFieldFocused = true;
                                isEmailFieldFocused = false;
                                isUnitNameFieldFocused = false;
                                isRoleNameFieldFocused = false;
                                isContactFieldFocused = false;
                                isAddressFieldFocused = false;
                                isDesignationFieldFocused = true;
                                isNameFieldFocused = false;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                   ,
                    const SizedBox(height: 40),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          child: ElevatedButton(
                            onPressed:  () {
                              setState(() {
                                _hasPressedSaveButton = true; // Set the flag to true
                                _hasRoleSaveButton = true; // Set the flag to true
                              });
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoadingEdit = true; // Start loading
                                      });

                                      // Determine whether to update or create a vendor
                                      if (widget.screenflag.isNotEmpty) {
                                        BlocProvider.of<AllRequesterBloc>(context)
                                            .add(
                                          UserUpdateEventHandler(
                                            id: widget.id.toString(),
                                            name: nameController.text.toString(),

                                            address:
                                                addressController.text.toString(),
                                            email:
                                                emailController.text.toString(),
                                            contact:
                                                contactController.text.toString(),


                                            unitID: selectedRoleItem == 'Purchase Manager'
                                                ? ['0']  // Pass ['0'] as a list for 'Purchase Manager'
                                                : selectedUnitId.isNotEmpty ? selectedUnitId : [],

                                            // Pass the selected unit ID
                                            role: selectedRoleItem.toString(),
                                            // Pass the selected role name

                                            password: passwordController.text
                                                .toString(),
                                            designation: designationController
                                                .text
                                                .toString(),
                                          ),
                                        );
                                      } else {
                                        BlocProvider.of<AllRequesterBloc>(context)
                                            .add(
                                          UserCreateEventHandler(
                                            id: widget.id.toString(),
                                            name: nameController.text.toString(),

                                            address:
                                                addressController.text.toString(),
                                            email:
                                                emailController.text.toString(),
                                            contact:
                                                contactController.text.toString(),

                                            unitID: selectedRoleItem == 'Purchase Manager'
                                                ? ['0']  // Pass ['0'] as a list for 'Purchase Manager'
                                                : selectedUnitId.isNotEmpty ? selectedUnitId : [], //


                                              // Pass the selected unit ID
                                            role: selectedRoleItem.toString(),
                                            // Pass the selected role name

                                            password: passwordController.text
                                                .toString(),
                                            designation: designationController
                                                .text
                                                .toString(),
                                          ),
                                        );
                                      }

                                      // Note: Your submission logic is handled in the Bloc event
                                    } else {
                                      // If any field is invalid, trigger validation error display
                                      formKey.currentState!.validate();
                                    }
                                  }
                               ,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                              backgroundColor: isButtonEnabled ||widget.screenflag.isNotEmpty
                                  ? AppColors.primaryColourDark
                                  : AppColors.formFieldBackColour,
                            ),
                            child: isLoadingEdit
                                ? const CircularProgressIndicator(
                                    color: Colors.blue)
                                : Text("Save", style: FTextStyle.loginBtnStyle),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMultiSelectDialog(BuildContext context) {
    // Create temporary variables to manage selection in the dialog
    List<String> tempSelectedUnitNames = List.from(selectedUnitItem);
    List<dynamic> tempSelectedUnitIds = List.from(selectedUnitId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Units"),
          content: SingleChildScrollView(
            child: ListBody(
              children: UnitNames.map((unitName) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    // Check if the unit is already selected
                    bool isSelected = tempSelectedUnitNames.contains(unitName);

                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(unitName),
                      onChanged: (bool? selected) {
                        setState(() {
                          if (selected == true) {
                            // Add to temporary selection
                            if (!tempSelectedUnitNames.contains(unitName)) {
                              tempSelectedUnitNames.add(unitName);
                              var selectedUnit = listData.firstWhere(
                                    (unit) => unit['name'] == unitName,
                                orElse: () => {'id': '', 'name': ''},
                              );
                              if (selectedUnit['id'] != null) {
                                tempSelectedUnitIds.add(selectedUnit['id'].toString());
                              }
                            }
                          } else {
                            // Remove from temporary selection
                            tempSelectedUnitNames.remove(unitName);
                            var selectedUnit = listData.firstWhere(
                                  (unit) => unit['name'] == unitName,
                              orElse: () => {'id': '', 'name': ''},
                            );
                            if (selectedUnit['id'] != null) {
                              tempSelectedUnitIds.remove(selectedUnit['id'].toString());
                            }
                          }
                        });
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            // OK Button
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                setState(() {
                  // Update the actual selectedUnitItem and selectedUnitId
                  selectedUnitItem = List.from(tempSelectedUnitNames);
                  selectedUnitId = List.from(tempSelectedUnitIds);
                  _updateButtonState(); // Ensure button state is updated
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  // void _showMultiSelectDialog(BuildContext context) {
  //   // Ensure default selection is populated
  //   List<String> defaultSelectedUnitNames = selectedUnitItem;
  //   List<dynamic> defaultSelectedUnitIds = selectedUnitId;
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Select Units"),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: UnitNames.map((unitName) {
  //               return StatefulBuilder(
  //                 builder: (context, setState) {
  //                   // Check if the unit is already selected
  //                   bool isSelected = defaultSelectedUnitNames.contains(unitName);
  //
  //                   return CheckboxListTile(
  //                     value: isSelected,
  //                     title: Text(unitName),
  //                     onChanged: (bool? selected) {
  //                       setState(() {
  //                         if (selected == true) {
  //                           // Add to selectedUnitItem and selectedUnitId
  //                           if (!defaultSelectedUnitNames.contains(unitName)) {
  //                             defaultSelectedUnitNames.add(unitName);
  //                             var selectedUnit = listData.firstWhere(
  //                                   (unit) => unit['name'] == unitName,
  //                               orElse: () => {'id': '', 'name': ''},
  //                             );
  //                             if (selectedUnit['id'] != null) {
  //                               defaultSelectedUnitIds.add(selectedUnit['id'].toString());
  //                             }
  //                           }
  //                         } else {
  //                           // Remove from selectedUnitItem and selectedUnitId
  //                           defaultSelectedUnitNames.remove(unitName);
  //                           var selectedUnit = listData.firstWhere(
  //                                 (unit) => unit['name'] == unitName,
  //                             orElse: () => {'id': '', 'name': ''},
  //                           );
  //                           if (selectedUnit['id'] != null) {
  //                             defaultSelectedUnitIds.remove(selectedUnit['id'].toString());
  //                           }
  //                         }
  //                         _updateButtonState();
  //                       });
  //                     },
  //                   );
  //                 },
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           // OK Button
  //           TextButton(
  //             child: const Text("OK"),
  //             onPressed: () {
  //               setState(() {
  //                 // Update the actual selectedUnitItem and selectedUnitId after dialog
  //                 selectedUnitItem = List.from(defaultSelectedUnitNames);
  //                 selectedUnitId = List.from(defaultSelectedUnitIds);
  //               });
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }






}
