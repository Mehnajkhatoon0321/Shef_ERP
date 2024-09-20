import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/unit_head/requisition.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';
class EditRequisition extends StatefulWidget {

  String product;
  String specification;
  String quantity;
  String remark;
  String upload;
   EditRequisition({required this.product,required this.specification,required this.quantity, required this.remark , required this.upload ,super.key});

  @override
  State<EditRequisition> createState() => _EditRequisitionState();
}




class _EditRequisitionState extends State<EditRequisition> {
  bool isButtonPartEnabled = false;
  bool isSpecificationFieldFocused = false;
  bool isProductFieldFocused = false;
  bool isQuantityFocused = false;
  bool isRemarkFocused = false;
  bool isUploadFocused = false;
  bool isImageUploaded = false;
  String? fileName1;
  File? imagesId;
  List<dynamic> list = ['Female', 'data', 'items'];
  String? selectedItem;
  late final GlobalKey<FormFieldState<String>> _productNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _specificationNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _quantityNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _remarkNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _uploadNameKey =
  GlobalKey<FormFieldState<String>>();
  late final TextEditingController productName = TextEditingController();
  late final TextEditingController specificationName = TextEditingController();
  late final TextEditingController quantityName = TextEditingController();
  late final TextEditingController remarkName = TextEditingController();
  late final TextEditingController uploadName = TextEditingController();
  late final FocusNode _specificationNameNode = FocusNode();
  late final FocusNode _productNameNode = FocusNode();
  late final FocusNode _quantityNameNode = FocusNode();
  late final FocusNode _remarkNameNode = FocusNode();
  late final FocusNode _uploadNameNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedItem = widget.product; // Set initial value for productName
    quantityName.text = widget.quantity.toString();
    remarkName.text = widget.remark;
    specificationName.text = widget.specification;
    uploadName.text = widget.upload;

    // Set selectedItem to the initial value of productName if it's in the list
    selectedItem = list.contains(widget.product) ? widget.product : null;
  }

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
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
                onChanged: () {
                  setState(() {
                    isButtonPartEnabled = selectedItem != null &&
                        selectedItem!.isNotEmpty &&
                        ValidatorUtils.isValidCommon(specificationName.text);
                    if (isProductFieldFocused) {
                      _productNameKey.currentState?.validate();
                    }
                    if (isSpecificationFieldFocused) {
                      _specificationNameKey.currentState?.validate();
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product/Service",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.0),
                          border: Border.all(color: AppColors.primaryColourDark),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            key: _productNameKey,
                            focusNode: _productNameNode,
                            value: selectedItem,
                            hint: const Text("Select Product/Service", style: FTextStyle.formhintTxtStyle),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItem = newValue;
                                // Update button enable state
                                isButtonPartEnabled = newValue != null && newValue.isNotEmpty && ValidatorUtils.isValidCommon(specificationName.text);
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Specification",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        focusNode: _specificationNameNode,
                        key: _specificationNameKey,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                          hintText: "Enter Specification",
                          fillColor: Colors.white,
                        ),
                        inputFormatters: [NoSpaceFormatter()],
                        controller: specificationName,
                        validator: ValidatorUtils.model,
                      ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!,
                      ),
                    ),
                    Text(
                      "Quantity Demanded",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        focusNode: _quantityNameNode,
                        key: _quantityNameKey,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                          hintText: "Enter Quantity",
                          fillColor: Colors.white,
                        ),
                        inputFormatters: [NoSpaceFormatter()],
                        controller: quantityName,
                        validator: ValidatorUtils.model,
                      ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!,
                      ),
                    ),
                    Text(
                      "Remark",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        focusNode: _remarkNameNode,
                        key: _remarkNameKey,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                          hintText: "Enter Remark",
                          fillColor: Colors.white,
                        ),
                        inputFormatters: [NoSpaceFormatter()],
                        controller: remarkName,
                        validator: ValidatorUtils.model,
                      ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!,
                      ),
                    ),
                    Text(
                      "Upload",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      key: _uploadNameKey,
                      focusNode: _uploadNameNode,
                      decoration: FormFieldStyle.defaultInputDecoration.copyWith(
                        fillColor: Colors.white,
                        hintText: "Upload File",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles();
                            if (result != null && result.files.isNotEmpty) {
                              setState(() {
                                fileName1 = result.files.single.name;
                                imagesId = File(result.files.single.path!);
                                isImageUploaded = true;
                                uploadName.text = fileName1!;
                              });
                            }
                          },
                        ),
                      ),
                      controller: uploadName,
                      validator: ValidatorUtils.uploadValidator,
                      onChanged: (text) {
                        setState(() {
                          isButtonPartEnabled = selectedItem != null &&
                              selectedItem!.isNotEmpty &&
                              ValidatorUtils.isValidCommon(text);
                        });
                      },
                      onTap: () {
                        setState(() {
                          isUploadFocused = true;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          isUploadFocused = false;
                        });
                      },
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: (displayType == 'desktop' || displayType == 'tablet') ? 40 : 48,
                          child: ElevatedButton(
                            onPressed: isButtonPartEnabled
                                ? () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RequisitionScreen()));
                              setState(() {
                                // Clear the editing item
                              });
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                              backgroundColor: isButtonPartEnabled
                                  ? AppColors.primaryColourDark
                                  : AppColors.disableButtonColor,
                            ),
                            child: Text(
                              "Update",
                              style: FTextStyle.loginBtnStyle,
                            ),
                          ),
                        ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation2']!,
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
