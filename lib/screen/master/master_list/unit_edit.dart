import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/units.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';

class UnitEdit extends StatefulWidget {
  String id;
  String screenflag;
  String name;
  String billingAddress;
  String address;

  UnitEdit({super.key, required this.screenflag,required this.name,required this.billingAddress,required this.address,required this.id});

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
  bool isButtonEnabled = true;
  bool isLoadingEdit = false;

  final formKey = GlobalKey<FormState>();
  late final TextEditingController editController = TextEditingController();
  late final TextEditingController descriptionController =
  TextEditingController();
  late final TextEditingController addressController =
  TextEditingController();

  void initState() {
    super.initState();
    if (widget.screenflag.isNotEmpty && widget.screenflag == "Edit") {
      editController.text = widget.name;
      descriptionController.text = widget.billingAddress;
      addressController.text = widget.address;
    }
  }




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
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  BlocProvider(
                  create: (context) => AllRequesterBloc(),
                  child:  Units(

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
                  child:  Units(

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
                  child: Text("Event Name", style: FTextStyle.preHeadingStyle),
                ),
                TextFormField(
                  controller: editController,
                  decoration: InputDecoration(
                    hintText: "Enter Event",
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Event Billing Address",
                          style: FTextStyle.preHeadingStyle)

                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Enter Billing Address",
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
    );
  }
}
