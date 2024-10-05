import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';

import 'package:shef_erp/utils/colours.dart';

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
  File? imagesIdCancelled;

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController gstName = TextEditingController();
  late final TextEditingController panName = TextEditingController();
  late final TextEditingController cancelledName = TextEditingController();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController companyNameController = TextEditingController();
  late final TextEditingController roleController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController contactController = TextEditingController();
  late final TextEditingController whatsAppController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController addressCompanyController = TextEditingController();
  late final TextEditingController panCardController = TextEditingController();
  late final TextEditingController gstCardController = TextEditingController();
  late final TextEditingController tanCardController = TextEditingController();
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
      final GlobalKey<FormFieldState<String>> _contactKey = GlobalKey<FormFieldState<String>>();
      final GlobalKey<FormFieldState<String>> _whatsAppKey = GlobalKey<FormFieldState<String>>();

      final GlobalKey<FormFieldState<String>> _addressKey = GlobalKey<FormFieldState<String>>();
      final GlobalKey<FormFieldState<String>> _addressCompanyKey = GlobalKey<FormFieldState<String>>();
      final GlobalKey<FormFieldState<String>> _companyNameKey = GlobalKey<FormFieldState<String>>();
      final GlobalKey<FormFieldState<String>> _panCardNameKey = GlobalKey<FormFieldState<String>>();
      final GlobalKey<FormFieldState<String>> _gstNameKey = GlobalKey<FormFieldState<String>>();
      final GlobalKey<FormFieldState<String>> _tanNameKey = GlobalKey<FormFieldState<String>>();
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
  final FocusNode _tanCardNameFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllRequesterBloc>(context)
        .add(EditDetailHandler(widget.id));
  }

  String? fileUploadValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please upload a file.';
    }

    final validFileExtensions = ['pdf', 'jpeg', 'jpg', 'png'];
    final fileExtension = value.split('.').last.toLowerCase();

    if (!validFileExtensions.contains(fileExtension)) {
      return 'Invalid file type. Only pdf, jpeg, jpg, and png are allowed.';
    }

    return null; // Return null if validation passes
  }

  bool isPanFieldFocused = false;
  bool isPanCardFieldFocused = false;
  bool isGSTFieldFocused = false;
  bool isCancelledFieldFocused = false;
  bool isNameFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isContactFieldFocused = false;
  bool isAddressFieldFocused = false;
  bool isCompanyFieldFocused = false;
  bool isWhatsAppFieldFocused = false;
  bool isCompanyNameFieldFocused = false;

  void _updateButtonState() {
    setState(() {
      if (panName.text.isNotEmpty &&
          gstName.text.isNotEmpty &&
          cancelledName.text.isNotEmpty &&
          fileUploadValidator(panName.text) == null &&
          fileUploadValidator(gstName.text) == null &&
          fileUploadValidator(cancelledName.text) == null &&
          ValidatorUtils.isValidEmail(emailController.text) &&
          ValidatorUtils.isValidSimpleName(nameController.text) &&
          ValidatorUtils.isValidSimpleName(companyNameController.text)&&
          ValidatorUtils.isValidPhone(contactController.text)&&
          ValidatorUtils.isValidPhone(whatsAppController.text)
      &&
          ValidatorUtils.isValidAddress(addressController.text)   &&
          ValidatorUtils.isValidAddress(addressCompanyController.text)
          &&
          ValidatorUtils.isValidPincode(panCardController.text)
      
      ) {
        isButtonPartEnabled = true;
      } else {
        isButtonPartEnabled = false;
      }

      if (isNameFieldFocused == true) {
        _nameKey.currentState!.validate();
      }  if (isNameFieldFocused == true) {
        _companyNameKey.currentState!.validate();
      } if (isEmailFieldFocused == true) {
        _emailKey.currentState!.validate();
      } if (isContactFieldFocused == true) {
        _contactKey.currentState!.validate();
      }if (isWhatsAppFieldFocused == true) {
        _whatsAppKey.currentState!.validate();
      } if (isAddressFieldFocused == true) {
        _addressKey.currentState!.validate();
      } if (isCompanyFieldFocused == true) {
        _addressCompanyKey.currentState!.validate();
      } if (isEmailFieldFocused == true) {
        _emailKey.currentState!.validate();
      } if (isGSTFieldFocused == true) {
        _gstKey.currentState!.validate();
      }
      if (isPanFieldFocused == true) {
        _panKey.currentState!.validate();
      }
      if (isPanCardFieldFocused == true) {
        _panCardNameKey.currentState!.validate();
      }
      if (isCancelledFieldFocused == true) {
        _cancelledKey.currentState!.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Requisition',
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
      body: SingleChildScrollView(
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
                    style: FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Role", style: FTextStyle.preHeadingStyle),
                ),
                TextFormField(
                  controller: roleController,
                  key :_roleKey,
                  focusNode: _roleFocusNode,
                  readOnly: true,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,

                    hintText: "Vendor",hintStyle: FTextStyle.preHeadingStyle),
                  validator:ValidatorUtils.simpleNameValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=true;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Contact Person Name", style: FTextStyle.preHeadingStyle),
                ),
                TextFormField(
                  controller: nameController,
                  key :_nameKey,
                  keyboardType:TextInputType.name,
                  focusNode: _nameFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Enter Name",),
                  validator:ValidatorUtils.simpleNameValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=true;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Enter Email",),
                  inputFormatters: [NoSpaceFormatter()],
                  controller: emailController,
                  validator: ValidatorUtils.emailValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=true;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Contact No.",
                        style: FTextStyle.preHeadingStyle)),
                TextFormField(
                  controller: contactController,
                  key: _contactKey,
                  keyboardType:TextInputType.number,
                  focusNode: _contactFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                      fillColor: Colors.grey[100],
                      filled: true,
                      hintText: "Enter Contact",),
                  validator:ValidatorUtils.mobileNumberValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=true;
                    isAddressFieldFocused=false;
                  },
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Whatsapp No.",
                        style: FTextStyle.preHeadingStyle)),
                TextFormField(
                  controller: whatsAppController,
                  key: _whatsAppKey,
                  keyboardType:TextInputType.number,
                  focusNode: _whatsAppFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,

                    hintText: "Enter Whatsapp",),
                  validator:ValidatorUtils.mobileNumberValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isWhatsAppFieldFocused=true;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:
                    Text("Address", style: FTextStyle.preHeadingStyle)),
                TextFormField(
                  controller: addressController,
                  key: _addressKey,
                  keyboardType:TextInputType.streetAddress,
                  focusNode: _addressFocusNode,
                  maxLines: 4,
                  decoration: FormFieldStyle.defaultInputEditAddressDecoration.copyWith(),
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=true;
                  },
                  validator:ValidatorUtils.addressValidator,
                ),


                const SizedBox(height: 10),
                Text("Company Details:",
                    style: FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19)),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Company Name", style: FTextStyle.preHeadingStyle),
                ),
                TextFormField(
                  controller: companyNameController,
                  key :_companyNameKey,
                  keyboardType:TextInputType.name,
                  focusNode: _companyNameFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Enter Company Name",),
                  validator:ValidatorUtils.simpleNameValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=true;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                  },
                ),


                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:
                    Text("Company Address", style: FTextStyle.preHeadingStyle)),
                TextFormField(
                  controller: addressCompanyController,
                  key: _addressCompanyKey,
                  keyboardType:TextInputType.streetAddress,
                  focusNode: _addressCompanyFocusNode,
                  maxLines: 4,
                  decoration: FormFieldStyle.defaultInputEditAddressDecoration.copyWith(),
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=true;
                  },
                  validator:ValidatorUtils.addressValidator,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("PanCard", style: FTextStyle.preHeadingStyle),
                ),
                TextFormField(
                  controller: panCardController,
                  key :_panCardNameKey,
                  keyboardType:TextInputType.name,
                  focusNode: _panCardNameFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Enter Pan Name",),
                  validator:ValidatorUtils.panCardValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                    isPanCardFieldFocused=true;
                  },
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:
                    Text("PAN Upload (only pdf,jpeg,png,jpg|max:2 MB)", style: FTextStyle.preHeadingStyle)),

                const SizedBox(height: 10),
                TextFormField(
                  focusNode: _panFocusNode,
                  key: _panKey,

                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
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
                  validator: fileUploadValidator,
                  onTap: () {
                    setState(() {
                      isPanFieldFocused = true;
                      isGSTFieldFocused = false;
                      isCancelledFieldFocused = false;
                    });
                  },
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
                  key :_gstNameKey,
                  keyboardType:TextInputType.name,
                  focusNode: _panCardNameFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Enter GST",),
                  validator:ValidatorUtils.simpleNameValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                    isPanFieldFocused=true;
                  },
                ),


                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:
                    Text("GST Upload (only pdf,jpeg,png,jpg|max:2 MB)", style: FTextStyle.preHeadingStyle)),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: _gstFocusNode,
                  key: _gstKey,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
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
                  validator: fileUploadValidator,
                  onTap: () {
                    setState(() {
                      isPanFieldFocused = false;
                      isGSTFieldFocused = true;
                      isCancelledFieldFocused = false;
                    });
                  },
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
                  key :_tanNameKey,
                  keyboardType:TextInputType.name,
                  focusNode: _tanCardNameFocusNode,
                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Enter TAN",),
                  validator:ValidatorUtils.simpleNameValidator,
                  onTap: (){
                    isPanFieldFocused = false;
                    isGSTFieldFocused = false;
                    isCancelledFieldFocused = false;
                    isNameFieldFocused=false;
                    isEmailFieldFocused=false;
                    isContactFieldFocused=false;
                    isAddressFieldFocused=false;
                    isPanFieldFocused=true;
                  },
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:
                    Text("Cancelled Cheque (only pdf,jpeg,png,jpg|max:2 MB)", style: FTextStyle.preHeadingStyle)),

                const SizedBox(height: 10),
                TextFormField(
                  focusNode: _cancelledFocusNode,
                  key: _cancelledKey,

                  decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
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
                            imagesIdCancelled = File(result.files.single.path!);
                            cancelledName.text = cancelledNameFile!;
                          });
                          _updateButtonState(); // Update button state after selection
                        }
                      },
                    ),

                  ),
                  controller: cancelledName,
                  validator: fileUploadValidator,
                  onTap: () {
                    setState(() {
                      isPanFieldFocused = false;
                      isGSTFieldFocused = false;
                      isCancelledFieldFocused = true;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      isPanFieldFocused = false;
                      isGSTFieldFocused = false;
                      isCancelledFieldFocused = true;
                    });
                    _updateButtonState(); // Update button state on change
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
                              isLoading = true; // Start loading
                            });
                            // Your submission logic here
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
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.blue)
                            : Text("Update", style: FTextStyle.loginBtnStyle),
                      ),
                    ),
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
