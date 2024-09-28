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
   UserEdits({required this.screenflag,required this.id,super.key});

  @override
  State<UserEdits> createState() => _UserEditsState();
}

class _UserEditsState extends State<UserEdits>{
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
  final formKey = GlobalKey<FormState>();
  late final TextEditingController editController = TextEditingController();
  late final TextEditingController descriptionController =
  TextEditingController();
  late final TextEditingController addressController =
  TextEditingController();
  late final TextEditingController emailController =
  TextEditingController();
  late final GlobalKey<FormFieldState<String>> _unitNameKey =
  GlobalKey<FormFieldState<String>>();  late final GlobalKey<FormFieldState<String>> _roleNameKey =
  GlobalKey<FormFieldState<String>>();
  Map<String, dynamic> responseData = {};

  String? unitFromList;
  void initState() {

    BlocProvider.of<AllRequesterBloc>(context).add(EditDetailUserHandler(widget.id));
    super.initState();
  }
  late final FocusNode _unitNameNode = FocusNode();
  late final FocusNode _roleNameNode = FocusNode();
  List<String> UnitNames = [];
  List<String> RolesNames = [];
  int? selectedUnitId;
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
            setState(() {
              isLoadingEdit = true;
            });
          } else if (state is UserEditDetailsSuccess) {
            setState(() {
              //
              // responseData = state.userEditDeleteList['list'];

              unitFromList = state.userEditDeleteList['units'];


              print("AllData>>>>${responseData}");

              var UnitsDataList = state.userEditDeleteList['units'];
              var RoleDataList = state.userEditDeleteList['roles'];


              UnitNames = UnitsDataList
                  .map<String>((item) => item['name'] as String)
                  .toList();

              RolesNames = RoleDataList
                  .map<String>((item) => item['name'] as String)
                  .toList();




            });
          } else if (state is UserEditDetailsFailure) {
            setState(() {
              isLoadingEdit = false;
            });
            if (kDebugMode) {
              print("error>> ${state.deleteEditFailure}");
            }
          }
          if (state is UnitCreateLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          } else if (state is UnitCreateSuccess) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  BlocProvider(
                  create: (context) => AllRequesterBloc(),
                  child:  UserList(

                  ),
                )),
              );

            });
          } else if (state is UnitCreateFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.failureMessage);
          } else if (state is CheckNetworkConnection) {
            CommonPopups.showCustomPopup(
              context,
              'Internet is not connected.',
            );
          }else if (state is UnitUpdateSuccess) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  BlocProvider(
                  create: (context) => AllRequesterBloc(),
                  child:  UserList(

                  ),
                )),
              );

            });
          } else if (state is UnitUpdateFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.failureMessage);
          }

        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
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
                    // Ensure the container width is constrained properly
                    width: double.infinity,
                    // Expand to full width of parent container
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(28.0),
                      border: Border.all(
                          color: AppColors
                              .formFieldHintColour,width: 1.3),
                      color: AppColors.formFieldBackColour,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: _roleNameKey,
                        focusNode: _roleNameNode,
                        isExpanded: true,
                        // Make the DropdownButton expand to fill the width of the container
                        value: selectedRoleItem,
                        hint: const Text(
                          "Select Role",
                          style:
                          FTextStyle.formhintTxtStyle,
                        ),
                        onChanged: (String? eventValue) {
                          setState(() {
                            selectedRoleItem =
                                eventValue;
                            // Update button enable state
                            isButtonEnabled =
                                eventValue != null &&
                                    eventValue
                                        .isNotEmpty &&
                                    ValidatorUtils
                                        .isValidCommon(
                                        specificationName
                                            .text);
                          });
                        },
                        items: UnitNames.map<
                            DropdownMenuItem<String>>(
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
                    // Ensure the container width is constrained properly
                    width: double.infinity,
                    // Expand to full width of parent container
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(28.0),
                      border: Border.all(
                          color: AppColors
                              .formFieldHintColour,width: 1.3),
                      color: AppColors.formFieldBackColour,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: _unitNameKey,
                        focusNode: _unitNameNode,
                        isExpanded: true,
                        // Make the DropdownButton expand to fill the width of the container
                        value: selectedUnitItem,
                        hint: const Text(
                          "Select Unit",
                          style:
                          FTextStyle.formhintTxtStyle,
                        ),
                        onChanged: (String? eventValue) {
                          setState(() {
                            selectedUnitItem =
                                eventValue;
                            // Update button enable state
                            isButtonEnabled =
                                eventValue != null &&
                                    eventValue
                                        .isNotEmpty &&
                                    ValidatorUtils
                                        .isValidCommon(
                                        specificationName
                                            .text);
                          });
                        },
                        items: UnitNames.map<
                            DropdownMenuItem<String>>(
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
                        return 'Please enter an event';
                      }
                      return null;
                    },
                  ),
                  Text(
                    Constants.emailLabel,
                    style:  FTextStyle.preHeadingStyle,
                  ).animateOnPageLoad(animationsMap[
                  'imageOnPageLoadAnimation2']!),
                  const SizedBox(height: 5),
                  TextFormField(
          
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                    InputDecoration(
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
                    inputFormatters: [NoSpaceFormatter()],
                    controller: emailController,
                    validator: ValidatorUtils.emailValidator,
          
                  ).animateOnPageLoad(animationsMap[
                  'imageOnPageLoadAnimation2']!),
          
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Event Contact",
                          style: FTextStyle.preHeadingStyle)
          
                  ),
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
                      child: Text("Address", style: FTextStyle.preHeadingStyle)
          
                  ),
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
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
          
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Designation", style: FTextStyle.preHeadingStyle)
          
                  ),
                  TextFormField(
                    controller: addressController,
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
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
          
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Password", style: FTextStyle.preHeadingStyle)
          
                  ),
                  TextFormField(
                    controller: addressController,
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
                                if(widget.screenflag.isNotEmpty){
                                  BlocProvider.of<AllRequesterBloc>(context)
                                      .add(
                                    UnitUpdateEventHandler(
                                      id: widget.id.toString(),
                                      name: editController.text.toString(),
                                      billingAddress: descriptionController
                                          .text
                                          .toString(),
                                      address:
                                      addressController.text.toString(),
                                    ),
                                  );
                                }else{
          
                                  BlocProvider.of<AllRequesterBloc>(context)
                                      .add(
                                    UnitCreateEventHandler(
                                      name: editController.text.toString(),
                                      billingAddress: descriptionController
                                          .text
                                          .toString(),
                                      address:
                                      addressController.text.toString(),
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
