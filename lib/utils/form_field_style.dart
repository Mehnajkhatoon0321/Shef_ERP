
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/font_text_Style.dart';



class FormFieldStyle {





  static InputDecoration defaultemailDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      hintText: Constants.emailHint,
      hintStyle: FTextStyle.formhintTxtStyle,
      filled: true,
      fillColor: AppColors.formFieldBackColour);










  static InputDecoration defaultPasswordInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    hintText: Constants.passwordHint,
    hintStyle: FTextStyle.formhintTxtStyle,
    filled: true,
    fillColor: AppColors.formFieldBackColour,
  );
  static InputDecoration defaultDropdownInputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      filled: true,
      errorStyle: FTextStyle.formErrorTxtStyle,
      fillColor: AppColors.formFieldBackColour,
      hintText: Constants.dobHint,
      hintStyle: FTextStyle.formhintTxtStyle,
      contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 12)
  );


  static InputDecoration defaultAddressInputDecoration =
  InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.formFieldBorderColour,
        )),
    hintText: Constants.addressHint,
    hintStyle: FTextStyle.formhintTxtStyle,
    filled: true,
    fillColor: AppColors.formFieldBackColour,
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  );



  static InputDecoration defaultInputDecoration =
  InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColour,
        )),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColour,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColour,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColour,
        )),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColour,
        )),
    hintText: Constants.addressHint,
    hintStyle: FTextStyle.formhintTxtStyle,
    filled: true,
    fillColor: AppColors.formFieldBackColour,
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  );






  static InputDecoration dropDown=InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color:   AppColors.formFieldBorderColour),
      borderRadius: BorderRadius.circular(28),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColour),
      borderRadius: BorderRadius.circular(28),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
      borderSide: BorderSide(color: Colors.red),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.formFieldBorderColour),
      borderRadius: BorderRadius.circular(28),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    filled: true,
    fillColor: AppColors.formFieldBackColour,
    hintText: "Select Product Category",
    hintStyle:FTextStyle.formhintTxtStyle,
    errorStyle: TextStyle(color: Colors.red),
  );
}