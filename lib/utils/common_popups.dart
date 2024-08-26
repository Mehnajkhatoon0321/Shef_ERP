
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/deletePopupManager.dart';

import 'colours.dart';
import 'font_text_Style.dart';

class CommonPopups {
  static void showCustomNetworkPopup(BuildContext context, String message, {String? imagePath}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Image(
                  image: AssetImage("assets/Images/onboard.png"),
                  width:100,
                  height:100,
                  fit: BoxFit.cover,
                ),
                Text(message, textAlign: TextAlign.center),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  static void showCustomPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
        var displayType = valueType.toString().split('.').last;
        print('displayType>> $displayType');
        return CustomPopup(
          message: message,
          onOkPressed: () {
            Navigator.pop(context); // Close the popup when OK is pressed.
          },
            displayType: displayType
        );
      },
    );
  }

  static void showDeleteCustomPopup(
    BuildContext context,
    String message,
    VoidCallback onActionPressed,
  ) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    print('displayType>> $displayType');
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing dialog on outside tap
      builder: (BuildContext context) {
        return DeleteCustomPopup(
          message: message,
          onActionPressed: () {
            onActionPressed(); // Call the provided callback
          },
            displayType:displayType
        );
      },
    );
  }

  static void showSnackBar(context, textMsg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(textMsg,style: FTextStyle.TextSnakbar)));
  }
}

class CustomPopup extends StatelessWidget {
  final String message;
  final VoidCallback onOkPressed;
  final String displayType;

  const CustomPopup(
      {super.key, required this.message, required this.onOkPressed, required this.displayType});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: FTextStyle.formSubheadingTxtStyle,
          ),
          SizedBox(height: 16.h), // Add extra SizedBox for spacing
          Align(
            alignment: Alignment.center,
            child: displayType == 'mobile'
                ? ElevatedButton(
              onPressed: onOkPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColour,
                textStyle: FTextStyle.loginBtnStyle,
                // Adjusted button height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                elevation: 1,
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                    fontFamily: 'Outfit-Regular',
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            )
                : SizedBox(
              height: 52.h,
              width: 100.h,
                  child: ElevatedButton(
                                onPressed: onOkPressed,
                                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColour,
                  textStyle: FTextStyle.loginBtnStyle,
                  // Adjusted button height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  elevation: 1,
                  side: const BorderSide(color: Colors.white),
                                ),
                                child:  Text(
                  'OK',
                  style: TextStyle(
                      fontFamily: 'Outfit-Regular',
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                                ),
                              ),
                ),
          )
        ],
      ),
    );
  }
}

class DeleteCustomPopup extends StatefulWidget {
  final String message;
  final VoidCallback onActionPressed;
  final String displayType;

  DeleteCustomPopup({
    super.key,
    required this.message,
    required this.onActionPressed,
    required this.displayType,
  });

  @override
  _DeleteCustomPopupState createState() => _DeleteCustomPopupState();
}

class _DeleteCustomPopupState extends State<DeleteCustomPopup> {
  bool _isLoadingUi = false;
  @override
  void initState() {
    // Register the setState function with the singleton
    DeletePopupManager().setOnLoadingChanged((isLoading) {
      setState(() {
        _isLoadingUi = isLoading;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up: unregister the callback when the widget is disposed
    DeletePopupManager().setOnLoadingChanged(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: FTextStyle.formSubheadingTxtStyle,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.displayType == 'mobile'
                  ? ElevatedButton(
                onPressed:  () {
                  Navigator.pop(context); // Call the provided callback
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColour,
                  textStyle: FTextStyle.loginBtnStyle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  elevation: 1,
                  side: const BorderSide(color: Colors.white),
                ),
                child: Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'Outfit-Regular',
                    fontSize: 15.h,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
                  : SizedBox(
                height: 52.h,
                width: 100.h,
                child: ElevatedButton(
                  onPressed:  () {
                    Navigator.pop(context); // Call the provided callback
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColour,
                    textStyle: FTextStyle.loginBtnStyle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    elevation: 1,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontFamily: 'Outfit-Regular',
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w,),
              widget.displayType == 'mobile'
                  ? ElevatedButton(
                onPressed: _isLoadingUi
                    ? null // Disable button when loading
                    : () {
                  widget.onActionPressed(); // Call the provided callback
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColour,
                  textStyle: FTextStyle.loginBtnStyle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  elevation: 1,
                  side: const BorderSide(color: Colors.white),
                ),
                child: _isLoadingUi
                    ? const SizedBox(
                    width: 15.0,
                    height: 15.0,
                    child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 1)) // Disable button when loading
                    : const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: 'Outfit-Regular',
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
                  : SizedBox(
                height: 52.h,
                width: 100.h,
                child: ElevatedButton(
                  onPressed: _isLoadingUi
                      ? null // Disable button when loading
                      : () {
                          widget.onActionPressed(); // Call the provided callback
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColour,
                    textStyle: FTextStyle.loginBtnStyle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    elevation: 1,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: _isLoadingUi
                      ? const SizedBox(
                          width: 15.0,
                          height: 15.0,
                          child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 1)) // Disable button when loading
                      : Text(
                          'Yes',
                          style: TextStyle(
                            fontFamily: 'Outfit-Regular',
                            fontSize: 15.sp,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
