import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';

import 'package:shef_erp/utils/colours.dart';

import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';

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
  GlobalKey<FormFieldState<String>> _panKey = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> _gstKey = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> _cancelledKey = GlobalKey<FormFieldState<String>>();
  final FocusNode _gstFocusNode = FocusNode();
  final FocusNode _panFocusNode = FocusNode();
  final FocusNode _cancelledFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllRequesterBloc>(context).add(EditDetailHandler(widget.id));
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
  bool isGSTFieldFocused = false;
  bool isCancelledFieldFocused = false;
  void _updateButtonState() {
    setState(() {
 if  (panName.text.isNotEmpty &&
          gstName.text.isNotEmpty &&
          cancelledName.text.isNotEmpty &&
          fileUploadValidator(panName.text) == null &&
          fileUploadValidator(gstName.text) == null &&
          fileUploadValidator(cancelledName.text) == null)

   {



     isButtonPartEnabled =true;
   }
 else{

   isButtonPartEnabled =false;
 }

 if (isGSTFieldFocused == true) {
   _gstKey.currentState!.validate();
 }
 if (isPanFieldFocused == true) {
   _panKey.currentState!.validate();
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
                Text("PAN Upload (only pdf,jpeg,png,jpg|max:2 MB)", style: FTextStyle.formLabelTxtStyle),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: _panFocusNode,

                  key: _panKey,
                  decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                    fillColor: Colors.white,
                    hintText: "PAN File Upload",

                    suffixIcon: IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom, // Specify custom file types
                          allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'], // Allowed extensions
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
                Text("GST Upload (only pdf,jpeg,png,jpg|max:2 MB)", style: FTextStyle.formLabelTxtStyle),
                const SizedBox(height: 10),
                TextFormField(

                  focusNode: _gstFocusNode,
                  key:_gstKey ,
                  decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                    fillColor: Colors.white,
                    hintText: "Upload GST",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom, // Specify custom file types
                          allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'], // Allowed extensions
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
                Text("Cancelled Cheque (only pdf,jpeg,png,jpg|max:2 MB)", style: FTextStyle.formLabelTxtStyle),
                const SizedBox(height: 10),
                TextFormField(

                  focusNode: _cancelledFocusNode,
                  key: _cancelledKey,
                  decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                    fillColor: Colors.white,
                    hintText: "Upload Cancelled",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom, // Specify custom file types
                          allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'], // Allowed extensions
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
                          backgroundColor: isButtonPartEnabled ? AppColors.primaryColourDark : AppColors.disableButtonColor,
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




