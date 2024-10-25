import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/vendor.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_popups.dart';

import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class VendorEdit extends StatefulWidget {
  final String screenFlag; // Example field
  final String id; // Required ID field

  const VendorEdit({
    Key? key,
    required this.screenFlag,
    required this.id,
  }) : super(key: key);

  @override
  State<VendorEdit> createState() => _VendorEditState();
}

class _VendorEditState extends State<VendorEdit> {
  bool isButtonPartEnabled = false;
  String? panNameFile;
  String? gstNameFile;
  String? cancelledNameFile;
  File? imagesIdPan;
  File? imagesIdGST;
  int? selectedCategoryId;
  File? imagesIdCancelled;
  bool passwordVisible = true;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, int> categoryMap = {};
  late final TextEditingController gstName = TextEditingController();
  late final TextEditingController panName = TextEditingController();
  late final TextEditingController cancelledName = TextEditingController();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController companyNameController =
      TextEditingController();
  late final TextEditingController roleController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController contactController = TextEditingController();
  late final TextEditingController whatsAppController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController addressCompanyController =
      TextEditingController();
  late final TextEditingController panCardController = TextEditingController();
  late final TextEditingController gstCardController = TextEditingController();
  late final TextEditingController tanCardController = TextEditingController();
  late final TextEditingController accountNameController =
      TextEditingController();
  late final TextEditingController accountNumberController =
      TextEditingController();
  late final TextEditingController accountIFCIController =
      TextEditingController();
  late final TextEditingController bankNameController = TextEditingController();
  late final TextEditingController bankBranchController =
      TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  //
  final GlobalKey<FormFieldState<String>> _accountNameKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _accountNumberKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _accountIFSIKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _branchNAmeKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _bankNameKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _panKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _gstKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cancelledKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _roleKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _contactKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _whatsAppKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _addressKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _addressCompanyKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _companyNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _panCardNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _gstNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _tanNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _typeKey =
      GlobalKey<FormFieldState<String>>();
  final FocusNode _gstFocusNode = FocusNode();
  final FocusNode _panFocusNode = FocusNode();
  final FocusNode _cancelledFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _roleFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _contactFocusNode = FocusNode();
  final FocusNode _whatsAppFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _addressCompanyFocusNode = FocusNode();
  final FocusNode _companyNameFocusNode = FocusNode();
  final FocusNode _panCardNameFocusNode = FocusNode();
  final FocusNode _gstCardNameFocusNode = FocusNode();
  final FocusNode _tanCardNameFocusNode = FocusNode();
  final FocusNode _typeFocusNode = FocusNode();

  final FocusNode _accountNameNameFocusNode = FocusNode();

  final FocusNode _accountNumberNameFocusNode = FocusNode();
  final FocusNode _accountIFSIFocusNode = FocusNode();

  final FocusNode _bankNameFocusNode = FocusNode();
  final FocusNode _bankBranchFocusNode = FocusNode();

  final FocusNode _passwordFocusNode = FocusNode();
  String? selectedCategoryItem;
  bool isLoading = false;
  bool isLoadingEdit = false;
  List<String> categoryNames = [];

  @override
  void initState() {
    super.initState();
    if(widget.screenFlag.isNotEmpty) {
      BlocProvider.of<AllRequesterBloc>(context)
          .add(VendorUserHandler(widget.id));
    }
  }
  String? fileUploadValidator(String? filePath, {int? fileSize}) {
    if (filePath == null || filePath.isEmpty) {
      return 'Please upload a file.';
    }

    final validFileExtensions = ['pdf', 'jpeg', 'jpg', 'png'];
    final fileExtension = filePath.split('.').last.toLowerCase();

    if (!validFileExtensions.contains(fileExtension)) {
      return 'Invalid file type. Only pdf, jpeg, jpg, and png are allowed.';
    }

    // Check file size if it's provided
    if (fileSize != null && fileSize > 2 * 1024 * 1024) { // 2 MB in bytes
      return 'File size exceeds 2 MB.';
    }

    return null; // Return null if validation passes
  }

  Map<String, dynamic> responseData = {};
  bool isPanFieldFocused = false;
  bool isPanCardFieldFocused = false;
  bool isGSTFieldFocused = false;
  bool isGSTNameFieldFocused = false;

  bool isCancelledFieldFocused = false;
  bool isCancelledNameFieldFocused = false;
  bool isNameFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isContactFieldFocused = false;
  bool isAddressFieldFocused = false;
  bool isCompanyFieldFocused = false;
  bool isWhatsAppFieldFocused = false;
  bool isCompanyNameFieldFocused = false;

  bool isAccountNameFieldFocused = false;

  bool isAccountNumberFieldFocused = false;
  bool isAccountIFSIFieldFocused = false;
  bool isBankNameFocused = false;
  bool isBankBranchFocused = false;
  bool isCompanyAddressFocused = false;
  bool isPasswordFieldFocused = false;

  void _updateButtonState() {
    setState(() {
      if (
          ValidatorUtils.isValidEmail(emailController.text) &&
          ValidatorUtils.isValidSimpleName(nameController.text) &&
          ValidatorUtils.isValidPhone(contactController.text) &&
          ValidatorUtils.isValidPhone(whatsAppController.text) &&
          ValidatorUtils.isValidPassword(passwordController.text) ) {
        isButtonPartEnabled = true;
      } else {
        isButtonPartEnabled = false;
      }

      if (isNameFieldFocused == true) {
        _nameKey.currentState!.validate();
      }

      if (isEmailFieldFocused == true) {
        _emailKey.currentState!.validate();
      }
      if (isContactFieldFocused == true) {
        _contactKey.currentState!.validate();
      }
      if (isWhatsAppFieldFocused == true) {
        _whatsAppKey.currentState!.validate();
      }
      if (isAddressFieldFocused == true) {
        _addressKey.currentState!.validate();
      }
      if (isCompanyFieldFocused == true) {
        _addressCompanyKey.currentState!.validate();
      }
      if (isEmailFieldFocused == true) {
        _emailKey.currentState!.validate();
      }
      if (isPanFieldFocused == true) {
        _panKey.currentState!.validate();
      }
      if (isPanCardFieldFocused == true) {
        _panCardNameKey.currentState!.validate();
      }

      if (isGSTFieldFocused == true) {
        _gstKey.currentState!.validate();
      }
      if (isGSTNameFieldFocused == true) {
        _gstNameKey.currentState!.validate();
      }
      if (isCancelledFieldFocused == true) {
        _cancelledKey.currentState!.validate();
      }
      if (isCancelledNameFieldFocused == true) {
        _tanNameKey.currentState!.validate();
      }

      if (isAccountNameFieldFocused == true) {
        _accountNameKey.currentState!.validate();
      }
      if (isAccountNumberFieldFocused == true) {
        _accountNumberKey.currentState!.validate();
      }
      if (isAccountIFSIFieldFocused == true) {
        _accountIFSIKey.currentState!.validate();
      }
      if (isBankNameFocused == true) {
        _bankNameKey.currentState!.validate();
      }
      if (isBankBranchFocused == true) {
        _branchNAmeKey.currentState!.validate();
      }

      if (isCompanyAddressFocused == true) {
        _addressCompanyKey.currentState!.validate();
      }
      if (isCompanyNameFieldFocused == true) {
        _companyNameKey.currentState!.validate();
      }
      if (isPasswordFieldFocused == true) {
        _passwordKey.currentState!.validate();
      }
    });
  }

  Map<String, dynamic> personalData = {};
  Map<String, dynamic> bankData = {};
  List<String> types = [
    "Proprietorship",
    "Partnership",
    "Private Limikted",
    "Private Limited",
    "Limited Liability Partnership",
    "Public Limited",
    "Society",
    "Other"
  ];
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
            widget.screenFlag.isEmpty ? 'Create Vendor' : "Edit Vendor",
            style: FTextStyle.HeadingTxtWhiteStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.primaryColourDark,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
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
            if (state is VendorDetailsLoading) {
              setState(() {
                isLoading = true;
              });
            }
            else if (state is VendorDetailsSuccess) {
              setState(() {
                responseData = state.vendorDetailsList;

                // Access personal data from Alldata
                personalData = responseData['user'];

      // Use the null-aware operator to provide a default value if the data is null
                nameController.text = personalData['name'] ?? '';
                emailController.text = personalData['email'] ?? '';
                contactController.text = personalData['contact'] ?? '';
                addressController.text = personalData['address'] ?? '';
                passwordController.text = personalData['password'] ?? '';

                bankData = responseData['vendor'];

      // Again, use the null-aware operator for bank data
                whatsAppController.text = bankData['whatsapp'] ?? '';
                companyNameController.text = bankData['company_name'] ?? '';
                selectedCategoryItem =
                    bankData['company_type'] ?? '';
                addressCompanyController.text = bankData['address'] ?? '';
                panCardController.text = bankData['pan'] ?? '';
                // panName.text = bankData['pan_file'] ?? '';
                gstCardController.text = bankData['gst'] ?? '';
                // gstName.text = bankData['gst_file'] ?? '';
                tanCardController.text = bankData['tan'] ?? '';
                // cancelledName.text = bankData['cheque'] ?? '';
                accountNameController.text =
                    bankData['account_holder_name'] ?? '';
                accountNumberController.text = bankData['account_no'] ?? '';
                accountIFCIController.text = bankData['ifsc'] ?? '';
                bankNameController.text = bankData['bank_name'] ?? '';

                bankBranchController.text = bankData['branch'] ?? '';

                // cancelledName.text = bankData['bank_name'] ?? '';
                print(">>>>>>>>>>>personaldata$personalData");
                print(">>>>>>>>>>>bankData$bankData");
              });
            } else if (state is VendorDetailsFailure) {
              setState(() {
                isLoading = false;
              });

              CommonPopups.showCustomPopup(
                  context, state.vendorEditFailure['message']);
              if (kDebugMode) {
                print("error>> ${state.vendorEditFailure}");
              }
            }

            if (state is UpdateVendorLoading) {
              setState(() {
                isLoadingEdit = true;
              });
            } else if (state is UpdateVendorSuccess) {
              var response=state.updateResponse;


              setState(() {
                isLoadingEdit = false;
              });

              // Show the success message first
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response['message']),
                  backgroundColor: AppColors.primaryColour,
                ),
              );

              // Delay navigation to allow the Snackbar to be visible
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AllRequesterBloc(),
                      child: Vendor(),
                    ),
                  ),
                );
              });
            } else if (state is UpdateVendorFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                  context, state.failureUpdateMessage['message']);
            } else if (state is CheckNetworkConnection) {
              CommonPopups.showCustomPopup(
                context,
                'Internet is not connected.',
              );
            }
            if (state is VendorCreateLoading) {
              setState(() {
                isLoadingEdit = true; // Show loading indicator
              });
            } else if (state is VendorCreateSuccess) {
              var response = state.createResponse;
              print(">>>>DataList$response");

              setState(() {
                isLoadingEdit = false; // Hide loading indicator
              });

              // Show success message using Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response['message']),
                  backgroundColor: AppColors.primaryColour,
                ),
              );

              // Delay navigation to allow the Snackbar to be visible
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AllRequesterBloc(),
                      child: Vendor(),
                    ),
                  ),
                );
              });
            } else if (state is VendorCreateFailure) {
              setState(() {
                isLoadingEdit = false; // Hide loading indicator
              });

              // Log the failure message for debugging
              print(">>>>DataList${state.failureMessage}");

              // Show a custom popup with the error message
              CommonPopups.showCustomPopup(
                context,
                state.failureMessage,
              );
            }

            // TODO: implement listener
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                onChanged: _updateButtonState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personal Details:",
                        style:
                            FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Role", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: roleController,
                      key: _roleKey,
                      focusNode: _roleFocusNode,
                      readOnly: true,
                      decoration: FormFieldStyle.defaultInputEditDecoration
                          .copyWith(
                              fillColor: Colors.grey[100],
                              filled: true,
                              hintText: "Vendor",
                              hintStyle: FTextStyle.preHeadingStyle),
                      // validator:ValidatorUtils.simpleNameValidator,
                      onTap: () {
                        isPanFieldFocused = false;
                        isGSTFieldFocused = false;
                        isCancelledFieldFocused = false;
                        isNameFieldFocused = true;
                        isEmailFieldFocused = false;
                        isContactFieldFocused = false;
                        isAddressFieldFocused = false;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Contact Person Name",
                          style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: nameController,
                      key: _nameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _nameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Name",
                      ),
                      validator: ValidatorUtils.simpleNameValidator,
                      onTap: () {
                        isPanFieldFocused = false;
                        isGSTFieldFocused = false;
                        isCancelledFieldFocused = false;
                        isNameFieldFocused = true;
                        isEmailFieldFocused = false;
                        isContactFieldFocused = false;
                        isAddressFieldFocused = false;
                      },
                    ),
                    Text(
                      "Email",
                      style: FTextStyle.preHeadingStyle,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      key: _emailKey,
                      focusNode: _emailFocusNode,
                      readOnly: widget.screenFlag.isNotEmpty?true:false,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: widget.screenFlag.isNotEmpty?AppColors.formFieldBorderColour: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Email",
                      ),
                      inputFormatters: [NoSpaceFormatter()],
                      controller: emailController,
                      validator: ValidatorUtils.emailValidator,
                      onTap: () {
                        isPanFieldFocused = false;
                        isGSTFieldFocused = false;
                        isCancelledFieldFocused = false;
                        isNameFieldFocused = false;
                        isEmailFieldFocused = true;
                        isContactFieldFocused = false;
                        isAddressFieldFocused = false;
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Contact No.",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      controller: contactController,
                      key: _contactKey,
                      keyboardType: TextInputType.number,
                      focusNode: _contactFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Contact",
                      ),
                      validator: ValidatorUtils.mobileNumberValidator,
                      onTap: () {
                        isPanFieldFocused = false;
                        isGSTFieldFocused = false;
                        isCancelledFieldFocused = false;
                        isNameFieldFocused = false;
                        isEmailFieldFocused = false;
                        isContactFieldFocused = true;
                        isAddressFieldFocused = false;
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Whatsapp No.",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      controller: whatsAppController,
                      key: _whatsAppKey,
                      keyboardType: TextInputType.number,
                      focusNode: _whatsAppFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Whatsapp",
                      ),
                      validator: ValidatorUtils.mobileNumberValidator,
                      onTap: () {
                        isPanFieldFocused = false;
                        isGSTFieldFocused = false;
                        isCancelledFieldFocused = false;
                        isNameFieldFocused = false;
                        isWhatsAppFieldFocused = true;
                        isEmailFieldFocused = false;
                        isContactFieldFocused = false;
                        isAddressFieldFocused = false;
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:
                            Text("Address", style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      controller: addressController,
                      key: _addressKey,
                      keyboardType: TextInputType.streetAddress,
                      focusNode: _addressFocusNode,
                      maxLines: 4,
                      decoration: FormFieldStyle.defaultInputEditAddressDecoration
                          .copyWith(),

                    ),
                    const SizedBox(height: 10),
                    Text("Company Details:",
                        style:
                            FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19)),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Type", style: FTextStyle.preHeadingStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.0),
                          border: Border.all(color: AppColors.primaryColourDark),
                          color: Colors.grey[100],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            key: _typeKey,
                            focusNode: _typeFocusNode,
                            value:


                            types.contains(selectedCategoryItem) ? selectedCategoryItem : null,
                            hint: const Text(
                              "Select Type",
                              style: FTextStyle.formhintTxtStyle,
                            ),
                            onChanged: (String? categoryValue) {
                              if (categoryValue != null) {
                                setState(() {
                                  selectedCategoryItem = categoryValue;
                                  selectedCategoryId = categoryMap[categoryValue]; // This can be null

                                  isButtonPartEnabled = categoryValue.isNotEmpty;
                                });
                              }
                            },
                            items: types
                                .toSet() // Ensure uniqueness
                                .map<DropdownMenuItem<String?>>((dynamic value) {
                              return DropdownMenuItem<String?>(
                                value: value as String?, // Ensure type safety
                                child: Text(value as String),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:
                          Text("Company Name", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: companyNameController,
                      key: _companyNameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _companyNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Company Name",
                      ),

                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Company Address",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      controller: addressCompanyController,
                      key: _addressCompanyKey,
                      keyboardType: TextInputType.streetAddress,
                      focusNode: _addressCompanyFocusNode,
                      maxLines: 4,
                      decoration: FormFieldStyle.defaultInputEditAddressDecoration
                          .copyWith(),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("PanCard", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: panCardController,
                      key: _panCardNameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _panCardNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Pan Name",
                      ),

                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("PAN Upload (only pdf,jpeg,png,jpg|max:2 MB)",
                            style: FTextStyle.preHeadingStyle)),
                    const SizedBox(height: 10),
                    TextFormField(
                      focusNode: _panFocusNode,
                      key: _panKey,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "PAN File Upload",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom, // Specify custom file types
                              allowedExtensions: [
                                'pdf',
                                'jpeg',
                                'jpg',
                                'png'
                              ], // Allowed extensions
                            );
                            if (result != null && result.files.isNotEmpty) {
                              setState(() {
                                panNameFile = result.files.single.name;
                                imagesIdPan = File(result.files.single.path!);
                                panName.text = panNameFile!;
                              });
                              _updateButtonState(); // Update button state after selection
                            }
                          },
                        ),
                      ),
                      controller: panName,

                      onChanged: (value) {
                        setState(() {
                          isPanFieldFocused = true;
                          isGSTFieldFocused = false;
                          isCancelledFieldFocused = false;
                        });
                        _updateButtonState(); // Update button state on change
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("GST", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: gstCardController,
                      key: _gstNameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _gstCardNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter GST",
                      ),

                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("GST Upload (only pdf,jpeg,png,jpg|max:2 MB)",
                            style: FTextStyle.preHeadingStyle)),
                    const SizedBox(height: 10),
                    TextFormField(
                      focusNode: _gstFocusNode,
                      key: _gstKey,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Upload GST",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom, // Specify custom file types
                              allowedExtensions: [
                                'pdf',
                                'jpeg',
                                'jpg',
                                'png'
                              ], // Allowed extensions
                            );
                            if (result != null && result.files.isNotEmpty) {
                              setState(() {
                                gstNameFile = result.files.single.name;
                                imagesIdGST = File(result.files.single.path!);
                                gstName.text = gstNameFile!;
                              });
                              _updateButtonState(); // Update button state after selection
                            }
                          },
                        ),
                      ),
                      controller: gstName,

                      onChanged: (value) {
                        _updateButtonState(); // Update button state on change
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("TAN", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: tanCardController,
                      key: _tanNameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _tanCardNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter TAN",
                      ),
                     
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                            "Cancelled Cheque (only pdf,jpeg,png,jpg|max:2 MB)",
                            style: FTextStyle.preHeadingStyle)),
                    const SizedBox(height: 10),
                    TextFormField(
                      focusNode: _cancelledFocusNode,
                      key: _cancelledKey,
                      readOnly: true,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Upload Cancelled",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () async {

                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom, // Specify custom file types
                              allowedExtensions: [
                                'pdf',
                                'jpeg',
                                'jpg',
                                'png'
                              ], // Allowed extensions
                            );
                            if (result != null && result.files.isNotEmpty) {
                              setState(() {
                                cancelledNameFile = result.files.single.name;
                                imagesIdCancelled =
                                    File(result.files.single.path!);
                                cancelledName.text = cancelledNameFile!;
                              });
                              _updateButtonState(); // Update button state after selection
                            }
                          },
                        ),
                      ),
                      controller: cancelledName,

                      onChanged: (value) {
                        setState(() {
                          isPanFieldFocused = false;
                          isGSTFieldFocused = false;
                          isCancelledFieldFocused = true;
                        });
                        _updateButtonState(); // Update button state on change
                      },
                    ),
                    Text("Bank Details:",
                        style:
                            FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:
                          Text("Account Name", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: accountNameController,
                      key: _accountNameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _accountNameNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Account Name",
                      ),
             
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Account Number",
                          style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: accountNumberController,
                      key: _accountNumberKey,
                      keyboardType: TextInputType.number
                      ,
                      focusNode: _accountNumberNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Account Number",
                      ),
                 
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("IFSC", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: accountIFCIController,
                      key: _accountIFSIKey,
                      keyboardType: TextInputType.name,
                      focusNode: _accountIFSIFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter IFSC",
                      ),
                  
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Bank Name", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: bankNameController,
                      key: _bankNameKey,
                      keyboardType: TextInputType.name,
                      focusNode: _bankNameFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Bank Name",
                      ),
              
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Branch", style: FTextStyle.preHeadingStyle),
                    ),
                    TextFormField(
                      controller: bankBranchController,
                      key: _branchNAmeKey,
                      keyboardType: TextInputType.name,
                      focusNode: _bankBranchFocusNode,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Branch",
                      ),
                   
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Password", style: FTextStyle.preHeadingStyle),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      key: _passwordKey,
                      focusNode: _passwordFocusNode,
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
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      inputFormatters: [NoSpaceFormatter()],
                      validator: ValidatorUtils.passwordValidator,
                      onTap: () {
                        setState(() {
                          isPasswordFieldFocused = true;
                          isEmailFieldFocused = false;
                        });
                      },
                    ),
                      const SizedBox(height: 15),
                      Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // All fields are valid, proceed with submission
                            setState(() {
                              isLoadingEdit = true; // Start loading
                            });

                            final vendorData = VendorUpdateHandler(
                              name: nameController.text.toString(),
                              contact: contactController.text.toString(),
                              address: addressController.text.toString(),
                              whatsapp: whatsAppController.text.toString(),
                              companyType: selectedCategoryItem.toString(),
                              companyName: companyNameController.text.toString(),
                              caddress: addressCompanyController.text.toString(),
                              pan: panCardController.text.toString(),
                              gst: gstCardController.text.toString(),
                              tan: tanCardController.text.toString(),
                              companyEmail: '', // Consider getting this from a controller if necessary
                              accountName: accountNameController.text.toString(),
                              ifsc: accountIFCIController.text.toString(),
                              accountNo: accountNumberController.text.toString(),
                              bankName: bankNameController.text.toString(),
                              vendorId: widget.id, // Ensure you have a value for this
                              branch: bankBranchController.text.toString(),
                              panImage: imagesIdPan,
                              gstImage: imagesIdGST,
                              cancelledImage: imagesIdCancelled,
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                            );

                            // Determine whether to update or create a vendor
                            if (widget.screenFlag.isNotEmpty) {
                              BlocProvider.of<AllRequesterBloc>(context).add(vendorData);
                            } else {
                              BlocProvider.of<AllRequesterBloc>(context).add(VendorCreateHandler(
                                name: nameController.text.toString(),
                                contact: contactController.text.toString(),
                                address: addressController.text.toString(),
                                whatsapp: whatsAppController.text.toString(),
                                companyType: selectedCategoryItem.toString(),
                                companyName: companyNameController.text.toString(),
                                caddress: addressCompanyController.text.toString(),
                                pan: panCardController.text.toString(),
                                gst: gstCardController.text.toString(),
                                tan: tanCardController.text.toString(),
                                accountName: accountNameController.text.toString(),
                                ifsc: accountIFCIController.text.toString(),
                                accountNo: accountNumberController.text.toString(),
                                bankName: bankNameController.text.toString(),
                                roles: 'Vendor', // Ensure you have a value for this if creating
                                branch: bankBranchController.text.toString(),
                                panImage: imagesIdPan,
                                gstImage: imagesIdGST,
                                cancelledImage: imagesIdCancelled,
                                email: emailController.text.toString(), password: passwordController.text.toString(),
                              ));
                            }

                            // Note: Your submission logic is handled in the Bloc event
                          } else {
                            // If any field is invalid, trigger validation error display
                            _formKey.currentState!.validate();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          backgroundColor: isButtonPartEnabled
                              ? AppColors.primaryColourDark
                              : AppColors.formFieldBorderColour,
                        ),
                        child: isLoadingEdit
                            ? CircularProgressIndicator(color: Colors.blue)
                            : Text(widget.screenFlag.isEmpty ? 'Create' : "Update", style: FTextStyle.loginBtnStyle),
                      ),
                    ),
                  ),
                )

                ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
