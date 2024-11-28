import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';


import 'package:shef_erp/utils/colours.dart';

import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class UnitEdit extends StatefulWidget {
  String id;
  String screenflag;
  String name;
  String billingAddress;
  String address;

  UnitEdit(
      {super.key,
      required this.screenflag,
      required this.name,
      required this.billingAddress,
      required this.address,
      required this.id});

  @override
  State<UnitEdit> createState() => _UnitEditState();
}

class _UnitEditState extends State<UnitEdit> {
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
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController eventNameController =
      TextEditingController();
  late final TextEditingController billingAddressController =
      TextEditingController();
  late final TextEditingController addressController = TextEditingController();

  final GlobalKey<FormFieldState<String>> _eventNameKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _billingAddressKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _addressKey =
      GlobalKey<FormFieldState<String>>();
  final FocusNode _eventFocusNode = FocusNode();
  final FocusNode _billingFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  bool isEventFieldFocused = false;
  bool isBillingAddressFieldFocused = false;
  bool isAddressFieldFocused = false;
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;


  void initState() {
    super.initState();
    if (widget.screenflag.isNotEmpty && widget.screenflag == "Edit") {
      eventNameController.text = widget.name;
      billingAddressController.text = widget.billingAddress;
      addressController.text = widget.address;

      isButtonEnabled = eventNameController.text.isNotEmpty &&
          billingAddressController.text.isNotEmpty &&
          addressController.text.isNotEmpty;
    }


  }


  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            widget.screenflag.isEmpty ? 'Unit Create ' : "Unit Edit",
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
            if (state is UnitCreateLoading) {
              setState(() {
                isLoadingEdit = true;
              });
            } else if (state is UnitCreateSuccess) {
              isLoadingEdit = false;

              if (state.createResponse is Map &&
                  state.createResponse.containsKey('message')) {
                var deleteMessage =
                state.createResponse['message'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(deleteMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
              }

              Future.delayed(const Duration(milliseconds: 500),
                      () {
                    Navigator.pop(context,[true]);
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
            } else if (state is UnitUpdateSuccess) {
              isLoadingEdit = false;

              if (state.updateResponse is Map &&
                  state.updateResponse.containsKey('message')) {
                var deleteMessage =
                state.updateResponse['message'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(deleteMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
              }
              Future.delayed(const Duration(milliseconds: 500),
                      () {
                    Navigator.pop(context,[true]);
                  });


              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => BlocProvider(
              //       create: (context) => AllRequesterBloc(),
              //       child:  Units(),
              //     ),
              //   ),
              // ).then((result) {
              //   // Handle any result if needed
              //   if (result != null) {
              //     BlocProvider.of<AllRequesterBloc>(context)
              //         .add(GetUnitHandler("", pageNo, pageSize));
              //   }
              // });

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
                onChanged: _updateButtonState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Event Name", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      key: _eventNameKey,
                      focusNode: _eventFocusNode,
                      controller: eventNameController,
                      decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Event Name",
                      ),
                      onTap: () {
                        isEventFieldFocused = true;
                        isBillingAddressFieldFocused = false;
                        isAddressFieldFocused = false;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Event name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Event Billing Address", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      key: _billingAddressKey,
                      focusNode: _billingFocusNode,
                      controller: billingAddressController,
                      decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Billing Address",
                      ),
                      onTap: () {
                        isEventFieldFocused = false;
                        isBillingAddressFieldFocused = true;
                        isAddressFieldFocused = false;
                      },
                        validator: ValidatorUtils.addressValidator
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Address", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      key: _addressKey,
                      focusNode: _addressFocusNode,
                      controller: addressController,
                      decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Address",
                      ),
                      onTap: () {
                        isEventFieldFocused = false;
                        isBillingAddressFieldFocused = false;
                        isAddressFieldFocused = true;
                      },
                      validator: ValidatorUtils.addressValidator
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // All fields are valid, proceed with submission
                                setState(() {
                                  isLoadingEdit = true; // Start loading
                                });

                                // Determine whether to update or create a vendor
                                if (widget.screenflag.isNotEmpty) {
                                  BlocProvider.of<AllRequesterBloc>(context).add(
                                    UnitUpdateEventHandler(
                                      id: widget.id.toString(),
                                      name: eventNameController.text.toString(),
                                      billingAddress: billingAddressController.text.toString(),
                                      address: addressController.text.toString(),
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<AllRequesterBloc>(context).add(
                                    UnitCreateEventHandler(
                                      name: eventNameController.text.toString(),
                                      billingAddress: billingAddressController.text.toString(),
                                      address: addressController.text.toString(),
                                    ),
                                  );
                                }
                              } else {
                                // If any field is invalid, trigger validation error display
                                formKey.currentState!.validate();
                              }
                            } ,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                              backgroundColor: isButtonEnabled
                                  ? AppColors.primaryColourDark
                                  : AppColors.formFieldBorderColour,
                            ),
                            child: isLoadingEdit
                                ? CircularProgressIndicator(color: Colors.blue)
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
  void _updateButtonState() {
    setState(() {
      isButtonEnabled = ValidatorUtils.isValidAddress(addressController.text) &&
          ValidatorUtils.isValidAddress(billingAddressController.text) &&
          ValidatorUtils.isValidSimpleName(eventNameController.text);
      if (isEventFieldFocused == true) {
        _eventNameKey.currentState!.validate();
      }

      if (isBillingAddressFieldFocused == true) {
        _billingAddressKey.currentState!.validate();
      }
      if (isAddressFieldFocused == true) {
        _addressKey.currentState!.validate();
      }
    });
  }
}
