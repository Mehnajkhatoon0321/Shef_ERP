import 'package:flutter/material.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/constant.dart';
import 'package:shef_erp/utils/font_text_Style.dart';



class FormFieldStyle {





  static InputDecoration defaultemailDecoration = const InputDecoration(
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










  static InputDecoration defaultPasswordInputDecoration = const InputDecoration(
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
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: AppColors.formFieldBorderColour,
          )),
      focusedBorder: const OutlineInputBorder(
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
      contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 12)
  );


  static InputDecoration defaultAddressInputDecoration =
  const InputDecoration(
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
  const InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColourDark,
        )),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColourDark,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColourDark,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColourDark,
        )),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColourDark,
        )),
    hintText: Constants.addressHint,
    hintStyle: FTextStyle.formhintTxtStyle,
    filled: true,
    fillColor: AppColors.formFieldBackColour,
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  );






  static InputDecoration dropDown=InputDecoration(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color:   AppColors.formFieldBorderColour),
      borderRadius: BorderRadius.circular(28),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColourDark),
      borderRadius: BorderRadius.circular(28),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
      borderSide: BorderSide(color: Colors.red),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.formFieldBorderColour),
      borderRadius: BorderRadius.circular(28),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    filled: true,
    fillColor: AppColors.formFieldBackColour,
    hintText: "Select Product Category",
    hintStyle:FTextStyle.formhintTxtStyle,
    errorStyle: const TextStyle(color: Colors.red),
  );
}