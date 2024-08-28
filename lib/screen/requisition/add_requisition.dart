import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import 'package:shef_erp/screen/requisition/requisition.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';
class AddRequisition extends StatefulWidget {
  String flag;
   AddRequisition({ required this.flag,super.key});

  @override
  State<AddRequisition> createState() => _AddRequisitionState();
}

class _AddRequisitionState extends State<AddRequisition> {
  //Add Requisition
  bool isLoading = false;
  bool addVisibility =false;
  bool goneVisibility =true;
  String gender = "";
  bool isButtonEnabled = false;
  bool isEditMode = false;
  bool isImageUploaded = false;
  String? fileName1;
  File? imagesId;
  late final FocusNode _dateAppNode = FocusNode();

  late final TextEditingController dateFrom = TextEditingController();
  List<Map<String, String>> itemList = [];
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
  late final GlobalKey<FormFieldState<String>> dateKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _productNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _unitNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _categoryNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _eventNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _specificationNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _quantityNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _remarkNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _uploadNameKey =
  GlobalKey<FormFieldState<String>>();
  late final TextEditingController categoryProductName = TextEditingController();
  late final TextEditingController unitName = TextEditingController();
  late final TextEditingController eventName = TextEditingController();
  late final TextEditingController productName = TextEditingController();
  late final TextEditingController specificationName = TextEditingController();
  late final TextEditingController quantityName = TextEditingController();
  late final TextEditingController remarkName = TextEditingController();
  late final TextEditingController uploadName = TextEditingController();
  late final FocusNode _specificationNameNode = FocusNode();
  late final FocusNode _categoryNameNode = FocusNode();
  late final FocusNode _unitNameNode = FocusNode();
  late final FocusNode _eventNameNode = FocusNode();
  late final FocusNode _productNameNode = FocusNode();
  late final FocusNode _quantityNameNode = FocusNode();
  late final FocusNode _remarkNameNode = FocusNode();
  late final FocusNode _uploadNameNode = FocusNode();
  Map<String, String>? selectedItemForEditing;
bool isButtonPartEnabled = false;
bool isSpecificationFieldFocused = false;
bool isProductFieldFocused = false;
bool isEventFieldFocused = false;
bool isCategoryFieldFocused = false;
bool isQuantityFocused = false;
bool isUnitFocused = false;
bool isRemarkFocused = false;
bool isUploadFocused = false;
bool isDateFocused = false;


  void _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != currentDate) {
      // Format the date to dd-MM-yyyy
      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

      setState(() {
        dateFrom.text = formattedDate;
      });
    }
  }


List<dynamic> list = ['Female', 'data', 'items'];
List<dynamic> categoryList = ['categoryList', 'categoryList', 'categoryList'];
List<dynamic> eventList = ['eventList', 'eventList', 'eventList'];
List<dynamic> unitList = ['unitList', 'unitList', 'unitList'];
String? selectedItem; // Variable to keep track of selected item
String? selectedCategoryItem; // Variable to keep track of selected item
String? selectedEventItem; // Variable to keep track of selected item
String? selectedUnitItem; // Variable to keep track of selected item
  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Add Requisition', style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,),
        backgroundColor: AppColors.primaryColour,
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
        ),// You can set this to any color you prefer
      ),
body: SingleChildScrollView(
  child: Form(

    onChanged: () {
      if (isButtonEnabled =ValidatorUtils.isValidDate(dateFrom.text) && itemList != null &&
          itemList!.isNotEmpty


      ) {
        setState(() {
          isButtonEnabled = true;
        });
      } else {
        setState(() {
          isButtonEnabled = false;
        });
      }
      if (isDateFocused == true) {
        dateKey.currentState!.validate();
      }

    },



    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date",
            style: FTextStyle.formLabelTxtStyle,
          ).animateOnPageLoad(
            animationsMap['imageOnPageLoadAnimation2']!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              key: dateKey,
              focusNode: _dateAppNode,
              keyboardType: TextInputType.text,
              decoration: FormFieldStyle.defaultAddressInputDecoration.copyWith(
                hintText: "dd-mm-yyyy",
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryColour,
                  ),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),
              inputFormatters: [NoSpaceFormatter()],
              controller: dateFrom,
              validator: ValidatorUtils.dateValidator,
              onTap: () {
                setState(() {

                  isDateFocused=true;
                });
              },
            ).animateOnPageLoad(
              animationsMap['imageOnPageLoadAnimation2']!,
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: widget.flag.isNotEmpty,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Unit Name",
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
                      border: Border.all(color: AppColors.formFieldBorderColour),
                      color: Colors.grey[100],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: _unitNameKey,
                        focusNode: _unitNameNode,
                        value: selectedUnitItem,
                        hint: const Text("Unit Name", style: FTextStyle.formhintTxtStyle),
                        onChanged: (String? value) {
                          setState(() {
                            selectedUnitItem = value;
                            // Update button enable state
                            isButtonPartEnabled = value != null && value.isNotEmpty && ValidatorUtils.isValidCommon(specificationName.text);
                          });
                        },
                        items: unitList.map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),
          Text(
            "Add Requisition Product",
            style: FTextStyle.formLabelTxtStyle,
          ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
          const SizedBox(height: 10),

          Visibility(
            visible: !addVisibility,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  addVisibility = !addVisibility;
                });
              },
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.gray_2,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12), top: Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Icon(Icons.add_box_rounded, color: AppColors.primaryColour, size: 50),
                    const SizedBox(height: 10),
                    Text("Add Requisition", style: FTextStyle.formLabelTxtStyle),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),



          Visibility(
            visible: addVisibility,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.formFieldBackColour,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    onChanged: () {
                      // Update button enable state based on field validity
                      setState(() {
                        isButtonPartEnabled = selectedItem != null &&
                            selectedItem!.isNotEmpty &&
                            ValidatorUtils.isValidCommon(specificationName.text)&&  ValidatorUtils.isValidCommon(quantityName.text)&&  ValidatorUtils.isValidCommon(remarkName.text);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [


                            IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.primaryColour),
                              onPressed: () {
                                setState(() {
                                  addVisibility = false;
                                  isEditMode = false; // Reset edit mode
                                  selectedItem = null;
                                  specificationName.clear();
                                  quantityName.clear();
                                  remarkName.clear();
                                  uploadName.clear();
                                  isButtonPartEnabled = false; // Ensure button is disabled
                                });
                              },
                            ),
                          ],
                        ),


                        Visibility(
                          visible: widget.flag.isNotEmpty,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Product/Category",
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
                                    border: Border.all(color: AppColors.primaryColour),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      key: _categoryNameKey,
                                      focusNode: _categoryNameNode,
                                      value: selectedCategoryItem,
                                      hint: const Text("Select Product/Category", style: FTextStyle.formhintTxtStyle),
                                      onChanged: (String? categoryValue) {
                                        setState(() {
                                          selectedCategoryItem = categoryValue;
                                          // Update button enable state
                                          isButtonPartEnabled = categoryValue != null && categoryValue.isNotEmpty && ValidatorUtils.isValidCommon(specificationName.text);
                                        });
                                      },
                                      items: categoryList.map<DropdownMenuItem<String>>((dynamic value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
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
                              border: Border.all(color: AppColors.primaryColour),
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
                        Visibility(
                          visible: widget.flag.isNotEmpty,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Event",
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
                                    border: Border.all(color: AppColors.primaryColour),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      key: _eventNameKey,
                                      focusNode: _eventNameNode,
                                      value: selectedEventItem,
                                      hint: const Text("Select Event", style: FTextStyle.formhintTxtStyle),
                                      onChanged: (String? eventValue) {
                                        setState(() {
                                          selectedEventItem = eventValue;
                                          // Update button enable state
                                          isButtonPartEnabled = eventValue != null && eventValue.isNotEmpty && ValidatorUtils.isValidCommon(specificationName.text);
                                        });
                                      },
                                      items: eventList.map<DropdownMenuItem<String>>((dynamic value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),

                            ],
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
                        // _buildFileUploadContainer(1, isImageUploaded,
                        //     fileName1), // Doctor ID Upload
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
                                  setState(() {
                                    if (isEditMode) {
                                      if (selectedItemForEditing != null) {
                                        final index = itemList.indexOf(selectedItemForEditing!);
                                        itemList[index] = {
                                          "model": selectedItem!,
                                          "product": selectedItem!,
                                          "specialisation": specificationName.text,
                                          'remark':remarkName.text,
                                          'quantity':quantityName.text,
                                          'remarkName': remarkName.text,
                                                                      'uploadName': uploadName.text,
                                        };
                                      }
                                    } else {
                                      itemList.add({
                                        "model": selectedItem!,
                                        "product": selectedItem!,
                                        "specialisation": specificationName.text,
                                        'remark':remarkName.text,
                                        'quantity':quantityName.text,
                                        'uploadName': uploadName.text,
                                      });
                                    }

                                    // Reset state
                                    addVisibility = false;
                                    isEditMode = false;
                                    selectedItem = null;
                                    specificationName.clear();
                                    remarkName.clear();
                                    quantityName.clear();
                                    uploadName.clear();
                                    isButtonPartEnabled = false;
                                    selectedItemForEditing = null; // Clear the editing item
                                  });
                                }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  backgroundColor: isButtonPartEnabled
                                      ? AppColors.primaryColour
                                      : AppColors.disableButtonColor,
                                ),
                                child: Text(
                                  isEditMode ? "Update" : "Add",
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
            ),
          ),




          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow[50],
                    border: Border.all(color: AppColors.yellow),
                  ),
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(item["model"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                      // const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "Product/Services: ",
                                style: FTextStyle.listTitleSub,
                                children: [
                                  TextSpan(text: item["product"] ?? "", style: FTextStyle.listTitle),
                                  const TextSpan(text: "\nSpecialization: ", style: FTextStyle.listTitleSub),
                                  TextSpan(text: item["specialisation"] ?? "", style: FTextStyle.listTitle),
                                  const TextSpan(text: "\nQuantity: ", style: FTextStyle.listTitleSub),
                                  TextSpan(text: item["quantity"] ?? "", style: FTextStyle.listTitle),
                                  const TextSpan(text: "\nRemark: ", style: FTextStyle.listTitleSub),
                                  TextSpan(text: item["remark"] ?? "", style: FTextStyle.listTitle),
                                  const TextSpan(text: "\n", style: FTextStyle.listTitleSub),
                                  TextSpan(text:item['uploadName'] ?? "", style: FTextStyle.listTitle),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: AppColors.primaryColour),
                            onPressed: () {
                              setState(() {
                                selectedItemForEditing = item;
                                selectedItem = item["model"];
                                specificationName.text = item["specialisation"] ?? "";
                                quantityName.text=item["quantity"]??"";
                                remarkName.text=item["remark"]??"";
                                uploadName.text = item['uploadName']!;
                                addVisibility = true;
                                isEditMode = true;
                              });
                            },
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: const Icon(Icons.delete_forever, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                itemList.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height:
              (displayType == 'desktop' || displayType == 'tablet')
                  ? 70
                  : 45,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () async {
                  setState(() {
                    isLoading = true;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const RequisitionScreen(),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  backgroundColor: isButtonEnabled
                      ? AppColors.primaryColour
                      : AppColors.disableButtonColor,
                ),
                child: Text(
                  "Submit",
                  style: FTextStyle.loginBtnStyle,
                ),
              ),
            ).animateOnPageLoad(
              animationsMap['imageOnPageLoadAnimation2']!,
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
