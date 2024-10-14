import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/billing.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class BillingEdit extends StatefulWidget {
  String screenflag;
  String id;
  String billingAddress;
  String address;

  BillingEdit(
      {required this.screenflag,
      required this.id,
      required this.billingAddress,
      required this.address,
      super.key});

  @override
  State<BillingEdit> createState() => _BillingEditState();
}

class _BillingEditState extends State<BillingEdit> {
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

  final formKey = GlobalKey<FormState>();

  late final TextEditingController billingAddressController =
      TextEditingController();
  late final TextEditingController addressController = TextEditingController();

  final GlobalKey<FormFieldState<String>> _billingAddressKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _addressKey =
      GlobalKey<FormFieldState<String>>();

  final FocusNode _billingFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  bool isEventFieldFocused = false;
  bool isBillingAddressFieldFocused = false;
  bool isAddressFieldFocused = false;

  void initState() {
    super.initState();
    if (widget.screenflag.isNotEmpty && widget.screenflag == "Edit") {
      billingAddressController.text = widget.billingAddress;
      addressController.text = widget.address;

      isButtonEnabled = billingAddressController.text.isNotEmpty &&
          addressController.text.isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.formFieldBackColour,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.screenflag.isEmpty ? 'Create Billing' : "Edit Billing",
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
          if (state is BillingCreateLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          } else if (state is BillingCreateSuccess) {
            setState(() {
              setState(() {
                isLoadingEdit = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => AllRequesterBloc(),
                          child: BillingList(),
                        )),
              );
            });
          } else if (state is BillingCreateFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.failureMessage);
          } else if (state is CheckNetworkConnection) {
            CommonPopups.showCustomPopup(
              context,
              'Internet is not connected.',
            );
          } else if (state is BillingUpdateSuccess) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => AllRequesterBloc(),
                          child: BillingList(),
                        )),
              );
            });
          } else if (state is BillingUpdateFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.failureMessage);
          }
        },
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
                    child: Text("Event Billing Address",
                        style: FTextStyle.preHeadingStyle)),
                TextFormField(
                    key: _billingAddressKey,
                    focusNode: _billingFocusNode,
                    controller: billingAddressController,
                    decoration:
                        FormFieldStyle.defaultInputEditDecoration.copyWith(
                      fillColor: Colors.grey[100],
                      filled: true,
                      hintText: "Enter Billing Address",
                    ),
                    onTap: () {
                      isBillingAddressFieldFocused = true;
                      isAddressFieldFocused = false;
                    },
                    validator: ValidatorUtils.addressValidator),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Address", style: FTextStyle.preHeadingStyle)),
                TextFormField(
                    key: _addressKey,
                    focusNode: _addressFocusNode,
                    controller: addressController,
                    decoration:
                        FormFieldStyle.defaultInputEditDecoration.copyWith(
                      fillColor: Colors.grey[100],
                      filled: true,
                      hintText: "Enter  Address",
                    ),
                    onTap: () {
                      isBillingAddressFieldFocused = false;
                      isAddressFieldFocused = true;
                    },
                    validator: ValidatorUtils.addressValidator),
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
                                BillingUpdateEventHandler(
                                  id: widget.id.toString(),
                                  billingAddress:
                                      billingAddressController.text.toString(),
                                  address: addressController.text.toString(),
                                ),
                              );
                            } else {
                              BlocProvider.of<AllRequesterBloc>(context).add(
                                BillingCreateEventHandler(
                                  billingAddress:
                                      billingAddressController.text.toString(),
                                  address: addressController.text.toString(),
                                ),
                              );
                            }
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
    );
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = ValidatorUtils.isValidAddress(addressController.text) &&
          ValidatorUtils.isValidAddress(billingAddressController.text);

      if (isBillingAddressFieldFocused == true) {
        _billingAddressKey.currentState!.validate();
      }
      if (isAddressFieldFocused == true) {
        _addressKey.currentState!.validate();
      }
    });
  }
}
