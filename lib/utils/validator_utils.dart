
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shef_erp/utils/constant.dart';



class ValidatorUtils {
  static bool isValidEmail(String email) {
    if (email.length > 254) {
      return false; // email address too long
    }

    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
    );

    if (!regex.hasMatch(email)) {
      return false; // invalid email format
    }

    List<String> parts = email.split('@');

    if (parts.length != 2 || parts[0].isEmpty || parts[1].isEmpty) {
      return false; // email should contain one @ symbol and non-empty parts
    }

    if (parts[0].length > 64) {
      return false; // local part before @ should not exceed 64 characters
    }

    if (parts[1].length > 255) {
      return false; // domain part after @ should not exceed 255 characters
    }

    return true;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email field cannot be empty';
    }

    if (!isValidEmail(value)) {
      return 'Invalid email format';
    }

    return null;
  }

  static String? model(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill the field.';
    }
    if (value.length < 3 || value.length > 60) {
      return "Please write field must be between 3 and 60 characters.";
    }


    return null;
  }

  static String? dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date.';
    }

    try {
      // Try parsing the date using the expected format
      final DateTime parsedDate = DateFormat('dd-MM-yyyy').parseStrict(value);

    } catch (e) {
      return 'Invalid date format. Use dd-MM-yyyy.';
    }

    return null;
  }
  static String? uploadValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Upload file is required';
    }
    return null;
  }


  static String? specificationValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Specification is required';
    }
    return null;
  }

  static String? quantityValidator(String? value) {
    if (value == null || value.isEmpty || int.tryParse(value) == null) {
      return 'Valid quantity is required';
    }
    return null;
  }

  static String? remarkValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Remark is required';
    }
    return null;
  }
  static String? simpleNameValidator(String? value) {
    // Check if the value is null or empty
    if (value == null || value.trim().isEmpty) {
      return Constants.nameRequired; // Error message for empty name
    }

    // Check if the length of the name is between 1 and 60 characters
    if (value.length < 1 || value.length > 60) {
      return Constants.nameLength; // Error message for invalid length
    }

    // The name is valid
    return null;
  }


  static String? nameValidator(String? value) {
    if (value == null || value.trim().split(' ').length < 2) {
      return Constants.name1;
    }
    if (value.length < 3 || value.length > 60) {
      return Constants.name2;
    }
    return null;
  }

  static String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Constants.weight;
    }

    return null;
  }


  //
  // static String? addressValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return Constants.nullAddressField;
  //   } else if (value.length < 10 || value.length > 200) {
  //     return Constants.lengthAddressField;
  //   } else {
  //     return null;
  //   }
  // }
  static String? addressValidator(String? value) {
    // Check if the value is null or empty
    if (value == null || value.trim().isEmpty) {
      return Constants.nullAddressField; // Error message for empty address
    }

    // Check if the length of the address is between 5 and 100 characters
    if (value.length < 5 || value.length > 100) {
      return Constants.lengthAddressField; // Error message for invalid length
    }

    // The address is valid
    return null;
  }

  static String confirmPassValidator(String pass, String confirmPass) {
    if (confirmPass.isEmpty) {
      return Constants.nullField;
    } else if (confirmPass != pass) {
      return Constants.confirmPassError;
    } else {
      return "";
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Constants.nullField;
    }
    // Password strength validation
    if (value.length < 8) {
      return Constants.lengtherror;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return Constants.uppercaseError;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return Constants.lowercaseError;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return Constants.numberError;
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return Constants.specialChaacterError;
    } else {
      return null;
    }
  }



  //firstName


  static bool _isValidNameFormat(String value) {
    final nameRegExp = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    return nameRegExp.hasMatch(value);
  }
  static String? firstNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Constants.firstNameRequired;
    }
    if (value.length < 3 || value.length > 60) {
      return Constants.firstNameLength;
    }
    if (!_isValidNameFormat(value)) {
      return Constants.firstNameInvalid;
    }
    return null;
  }



  static String? mobileNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Constants.mobileNumberRequired; // Adjust this constant as needed
    }

    // Check if the mobile number contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return Constants.mobileNumberInvalid; // Adjust this constant as needed
    }

    if (value.length < 10 || value.length > 15) {
      return Constants.mobileNumberLength; // Adjust this constant as needed
    }

    // The mobile number is valid
    return null;
  }


  //>>>>>>>>>>>>>>>>>>isValid
//first name

  static bool isValidFirstName(String value) {
    // Check if the value is null or empty
    if (value.isEmpty) {
      return false;
    }
    // Check if the length of the first name is between 3 and 60 characters
    if (value.length < 3 || value.length > 60) {
      return false;
    }
    // Check if the first name contains only valid characters
    if (!_isValidNameFormat(value)) {
      return false;
    }
    // The first name is valid
    return true;
  }
  // static bool isValidAddress(String value) {
  //   // Check if the value is null or empty
  //   if (value.isEmpty) {
  //     return false;
  //   }
  //
  //   // Check if the length of the address is between 5 and 100 characters
  //   if (value.length < 5 || value.length > 100) {
  //     return false;
  //   }



    // The address is valid
  //   return true;
  // }

  static bool isValidLastName(String value) {
    // Check if the value is null or empty
    if (value.isEmpty) {
      return false;
    }
    // Check if the length of the last name is between 3 and 60 characters
    if (value.length < 3 || value.length > 60) {
      return false;
    }
    // Check if the last name contains only valid characters
    if (!_isValidNameFormat(value)) {
      return false;
    }
    // The last name is valid
    return true;
  }

  static bool isValidPassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    // Password length validation
    if (value.length < 8) {
      return false;
    }
    // Password contains at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    // Password contains at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    // Password contains at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    // Password contains at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    // Password meets all criteria
    return true;
  }
  static bool isValidSimpleName(String value) {
    // Check if the value is null or empty
    if (value.isEmpty) {
      return false;
    }

    // Check if the length of the name is between 1 and 60 characters
    if (value.length < 1 || value.length > 60) {
      return false;
    }

    // The name is valid
    return true;
  }

  static bool isValidName(String value) {
    // Check if the value is null or empty
    if (value.isEmpty) {
      return false;
    }
    // Check if the full name has at least two parts (first name and last name)
    if (value.trim().split(' ').length < 2) {
      return false;
    }
    // Check if the length of the full name is between 3 and 60 characters
    if (value.length < 3 || value.length > 60) {
      return false;
    }
    // The full name is valid
    return true;
  }

static  bool isValidAddress(String value) {
    // Check if the value is null or empty
    if (value.isEmpty) {
      return false;
    }

    // Check if the length of the address is between 10 and 200 characters
    if (value.length < 10 || value.length > 200) {
      return false;
    }

    // The address is valid
    return true;
  }
  static String? panCardValidator(String? value) {
    // Check if the value is null or empty
    if (value == null || value.trim().isEmpty) {
      return Constants.panCardRequired; // Error message for empty PAN card
    }

    // Check if the value matches the PAN card format
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value)) {
      return Constants.panCardInvalid; // Error message for invalid PAN card format
    }

    // The PAN card is valid
    return null;
  }

  static bool isValidPincode(String value) {
    // Check if the value is null or empty
    if (value.isEmpty) {
      return false;
    }
    // Check if the value contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return false;
    }
    // Check if the length of the pincode is between 4 and 8 characters (adjust as per your requirement)
    if (value.length < 4 || value.length > 8) {
      return false;
    }
    // The pincode is valid
    return true;
  }

  static bool isValidPhone(String value) {
    if (value.isEmpty) {
      return false;
    }
    // Check if the length of the phone number is at least 8 digits
    if (value.length < 8) {
      return false;
    }
    return true;
  }

  static bool isValidConfirmPassword(String pass, String confirmPass) {
    if (confirmPass.isEmpty || pass != confirmPass) {
      return false;
    }
    return true;
  }

  static bool isValidCommon(String value) {
    if (value.isEmpty) {
      return false;
    }
    // Check if the length of the phone number is at least 8 digits

    return true;
  }

  static bool isValidQuantity(String value) {
    if (value.isEmpty) {
      return false;
    }

    // Attempt to parse the value as an integer
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return false; // Not a valid number
    }

    // Check if the number is within the range 1 to 1000
    if (intValue < 1 || intValue > 1000) {
      return false;
    }

    return true; // The number is valid
  }
  static bool isValidDate(String value) {
    if (value.isEmpty) {
      return false; // Date field should not be empty
    }

    // Optionally, you can parse the date and check if it's a valid date
    try {
      final DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(value);
      return parsedDate != null;
    } catch (e) {
      return false; // If parsing fails, the date is invalid
    }
  }













  }