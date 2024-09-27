import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class UnitEdit extends StatefulWidget {
  String screenflag;

   UnitEdit({super.key, required this.screenflag});

  @override
  State<UnitEdit> createState() => _UnitEditState();
}

class _UnitEditState extends State<UnitEdit> {
  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    bool isLoadingEdit = false;
    final _formKey = GlobalKey<FormState>();
    late final TextEditingController _editController = TextEditingController();
    late final TextEditingController _descriptionController = TextEditingController();
    late final TextEditingController _addressController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.formFieldBorderColour,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.screenflag.isEmpty ?'Unit Create ':"Unit Edit",
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
        isLoadingEdit = false;
        var deleteMessage = state.createResponse['message'];


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(deleteMessage),
            backgroundColor: AppColors.primaryColour,
          ),
        );
        Navigator.pop(context);

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
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
    }


    // TODO: implement listener
  },
  child: MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
  child: Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Event Name", style: FTextStyle.preHeadingStyle),
              ),
              TextFormField(
                controller: _editController,
                decoration: InputDecoration(
                  hintText: "Enter Event",
                  hintStyle: FTextStyle.formhintTxtStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
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
                child: Text("Event Billing Address", style: FTextStyle.preHeadingStyle),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter Billing Address",
                  hintStyle: FTextStyle.formhintTxtStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
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
                child: Text("Address", style: FTextStyle.preHeadingStyle),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Enter Address",
                  hintStyle: FTextStyle.formhintTxtStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
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
              const SizedBox(height: 65),
              // SizedBox(
              //   height: (displayType == 'desktop' ||
              //       displayType == 'tablet')
              //       ? 70
              //       : 52,
              //   child: ElevatedButton(
              //       onPressed: isButtonEnabled
              //           ? () async {
              //         setState(() {
              //           isLoading = true;
              //         });
              //
              //         BlocProvider.of<AuthFlowBloc>(context)
              //             .add(
              //           LogEventHandler(
              //             email: _email.text.toString(),
              //             password: _password.text.toString(),
              //           ),
              //         );
              //       }
              //           : null,
              //       style: ElevatedButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(26),
              //         ),
              //         backgroundColor: isButtonEnabled
              //             ? AppColors.primaryColourDark
              //             : AppColors.disableButtonColor,
              //       ),
              //       child:
              //       isLoading
              //           ? const CircularProgressIndicator(
              //         color: Colors.white,
              //       )
              //           : Text(
              //         Constants.loginBtnTxt,
              //         style: FTextStyle.loginBtnStyle,
              //       )),
              // ).animateOnPageLoad(
              //     animationsMap['imageOnPageLoadAnimation2']!),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    ),
  ),
),
),
      );

  }
}
