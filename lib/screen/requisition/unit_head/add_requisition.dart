import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/admin/admin_requisition.dart';

import 'package:shef_erp/screen/requisition/requester/requisition_requester.dart';
import 'package:shef_erp/screen/requisition/unit_head/requisition.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';

import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class AddRequisition extends StatefulWidget {
  String flag;

  AddRequisition({required this.flag, super.key});

  @override
  State<AddRequisition> createState() => _AddRequisitionState();
}

class _AddRequisitionState extends State<AddRequisition> {
  bool isLoading = false;
  bool isAddLoading = false;
  bool addVisibility = false;
  bool goneVisibility = true;
  String gender = "";
  bool isButtonEnabled = true;
  bool isEditMode = false;
  bool isImageUploaded = false;
  String? fileName1;
  File? imagesId;
  late final FocusNode _dateAppNode = FocusNode();

  late final TextEditingController dateFrom = TextEditingController();
  List<Map<String, dynamic>> itemList = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AllRequesterBloc>(context).add(RequesterHandler());

    // Initialize the date controller with the current date formatted as dd-MM-yyyy
    dateFrom.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  int userId = PrefUtils.getUserId();
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
  late final TextEditingController categoryProductName =
      TextEditingController();
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
  Map<String, dynamic>? selectedItemForEditing;
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
  Map<String, dynamic> responseData = {};
  List<dynamic> ProductList = [];
  int? selectedCategoryId;
  int? selectedUnitId;
  int? selectedProductId;

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

  List<String> categoryNames = [];
  List<String> UnitNames = [];
  List<String> productNames = [];
  Map<String, int> categoryMap = {};
  Map<String, int> productMap = {};
  List<String> eventNames = [];

  List<dynamic> unitList = ['unitList1', 'unitList2', 'unitList3'];
  String? selectedItem; // Variable to keep track of selected item
  String? selectedCategoryItem; // Variable to keep track of selected item
  String? selectedProductItem; // Variable to keep track of selected item
  String? selectedEventItem; // Variable to keep track of selected item
  String? selectedUnitItem; // Variable to keep track of selected item

  String? unitFromList;
  String? timeFromList;
  String? nextFromList;

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Add Requisition',
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
        ), // You can set this to any color you prefer
      ),
      body: BlocListener<AllRequesterBloc, AllRequesterState>(
        listener: (context, state) {
          if (state is ViewAddListLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is ViewAddListSuccess) {
            setState(() {
              var eventList = state.viewAddList['list']['events'];
              responseData = state.viewAddList['list'];
              timeFromList = state.viewAddList['list']['time'];
              unitFromList = state.viewAddList['list']['unit'];
              nextFromList = state.viewAddList['list']['nextDate'];

              print("AllData>>>>${responseData}");
              var categoryList = state.viewAddList['list']['category'];
              var UnitsDataList = state.viewAddList['list']['units'];

              categoryNames = categoryList
                  .map<String>((item) => item['cate_name'] as String)
                  .toList();
              UnitNames = UnitsDataList
                  .map<String>((item) => item['name'] as String)
                  .toList();

              categoryMap = {
                for (var item in categoryList)
                  item['cate_name'] as String: item['id'] as int
              };

              eventNames = eventList
                  .map<String>((item) => item['name'] as String)
                  .toList();
            });
          } else if (state is AddCartFailure) {
            setState(() {
              isLoading = false;
            });
            if (kDebugMode) {
              print("error>> ${state.addCartDetailFailure}");
            }
          }
          if (state is ProductListLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is ProductListSuccess) {
            setState(() {
              ProductList = state.productList['product_list'];
              print("ALLProductDat>>>>>>>>>>>>>>>>>a$ProductList");
              productNames =
                  ProductList.map<String>((item) => item['name'] as String)
                      .toList();

              productMap = {
                for (var item in ProductList)
                  item['name'] as String: item['id'] as int
              };
            });
          }

          if (state is SpecificationListLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is SpecificationListSuccess) {
            setState(() {
              var specDescription = state.specList['spec'];

              // Provide a default value if specDescription is null
              var displayText = specDescription ?? '';

              print(">>>>$displayText");
              specificationName.text = displayText;
            });
          }
          if (state is AddRequisitionLoading) {
            setState(() {
              isAddLoading = true;
            });
          } else if (state is AddRequisitionSuccess) {
            isAddLoading = false;
            setState(() {
              var Add = state.addRequisition;

           if  ( PrefUtils.getRole() == 'Unit Head'){
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => BlocProvider(
                   create: (context) => AllRequesterBloc(),
                   child: const RequisitionScreen(),
                 ),
               ),
             );
           }else if  ( PrefUtils.getRole() == 'Purchase Manager'){
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => BlocProvider(
                   create: (context) => AllRequesterBloc(),
                   child: const AdminRequisition(),
                 ),
               ),
             );
           }
           else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AllRequesterBloc(),
                    child: const RequisitionRequester(),
                  ),
                ),
              );}
              if (kDebugMode) {
                print(">>>>>AddSucess$Add");
              }
              // if (widget.flag=="unit") {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //       const AdminRequisition(),
              //     ),
              //   );
              // } else {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //       const RequisitionScreen(),
              //     ),
              //   );
              // }
            });
          }

          // TODO: implement listener
        },
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: PrefUtils.getRole() == 'Unit Head'||PrefUtils.getRole() == 'Purchase Manager',
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Date",
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
                                  color: AppColors.primaryColourDark,
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
                                isDateFocused = true;
                              });
                            },
                          ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!,
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 5),
                  Visibility(
                    visible: widget.flag.isNotEmpty && (responseData['roles'] == 'Requester' || PrefUtils.getRole() == 'Purchase Manager'),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0),
                          child: Container(
                            // Ensure the container width is constrained properly
                            width: double.infinity,
                            // Expand to full width of parent container
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(28.0),
                              border: Border.all(
                                  color: AppColors
                                      .boarderColour),
                              color: AppColors.formFieldBackColour,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                key: _unitNameKey,
                                focusNode: _unitNameNode,
                                isExpanded: true,
                                // Make the DropdownButton expand to fill the width of the container
                                value: selectedUnitItem,
                                hint: const Text(
                                  "Select Unit",
                                  style:
                                  FTextStyle.formhintTxtStyle,
                                ),
                                onChanged: (String? eventValue) {
                                  setState(() {
                                    selectedUnitItem =
                                        eventValue;
                                    // Update button enable state
                                    isButtonPartEnabled =
                                        eventValue != null &&
                                            eventValue
                                                .isNotEmpty &&
                                            ValidatorUtils
                                                .isValidCommon(
                                                specificationName
                                                    .text);
                                  });
                                },
                                items: UnitNames.map<
                                    DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
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
                  ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!),
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
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                              top: Radius.circular(12)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            const Icon(Icons.add_box_rounded,
                                color: AppColors.primaryColourDark, size: 50),
                            const SizedBox(height: 10),
                            Text("Add Requisition",
                                style: FTextStyle.formLabelTxtStyle),
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
                                    selectedCategoryItem != null &&
                                    selectedCategoryItem!.isNotEmpty &&
                                    ValidatorUtils.isValidCommon(
                                        quantityName.text);
                                if (isProductFieldFocused) {
                                  _productNameKey.currentState?.validate();
                                }
                                if (isSpecificationFieldFocused) {
                                  _specificationNameKey.currentState
                                      ?.validate();
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
                                      icon: const Icon(Icons.clear,
                                          color: AppColors.primaryColourDark),
                                      onPressed: () {
                                        setState(() {
                                          addVisibility = false;
                                          isEditMode = false; // Reset edit mode
                                          selectedItem = null;
                                          specificationName.clear();
                                          selectedEventItem = null;
                                          quantityName.clear();
                                          remarkName.clear();
                                          uploadName.clear();
                                          isButtonPartEnabled =
                                              false; // Ensure button is disabled
                                        });
                                      },
                                    ),
                                  ],
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Category",
                                      style: FTextStyle.formLabelTxtStyle,
                                    ).animateOnPageLoad(
                                      animationsMap[
                                          'imageOnPageLoadAnimation2']!,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                          border: Border.all(
                                              color: AppColors
                                                  .primaryColourDark),
                                          color: Colors.white,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String?>(
                                            key: _categoryNameKey,
                                            focusNode: _categoryNameNode,
                                            value: selectedCategoryItem,
                                            hint: const Text(
                                              "Select Product Category",
                                              style:
                                                  FTextStyle.formhintTxtStyle,
                                            ),
                                            onChanged:
                                                (String? categoryValue) {
                                              if (categoryValue != null) {
                                                setState(() {
                                                  selectedCategoryItem =
                                                      categoryValue;
                                                  selectedCategoryId =
                                                      categoryMap[
                                                          categoryValue]; // This can be null
                                                  selectedItem = null;
                                                  isButtonPartEnabled =
                                                      categoryValue
                                                              .isNotEmpty &&
                                                          ValidatorUtils
                                                              .isValidCommon(
                                                                  specificationName
                                                                      .text);

                                                  if (selectedCategoryId !=
                                                      null) {
                                                    BlocProvider.of<
                                                                AllRequesterBloc>(
                                                            context)
                                                        .add(ProductListHandler(
                                                            selectedCategoryId
                                                                .toString()));
                                                  }
                                                });
                                              } else {}
                                            },
                                            items: categoryNames.map<
                                                DropdownMenuItem<
                                                    String?>>((String value) {
                                              return DropdownMenuItem<
                                                  String?>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "Product/Service",
                                  style: FTextStyle.formLabelTxtStyle,
                                ).animateOnPageLoad(
                                  animationsMap['imageOnPageLoadAnimation2']!,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28.0),
                                      border: Border.all(
                                          color: AppColors.primaryColourDark),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String?>(
                                        key: _productNameKey,
                                        focusNode: _productNameNode,
                                        value: selectedItem,
                                        hint: const Text(
                                            "Select Product/Service",
                                            style: FTextStyle.formhintTxtStyle),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedItem = newValue;
                                              selectedProductId = productMap[
                                                  newValue]; // This can be null

                                              isButtonPartEnabled = newValue
                                                      .isNotEmpty &&
                                                  ValidatorUtils.isValidCommon(
                                                      specificationName.text);

                                              if (selectedProductId != null) {
                                                BlocProvider.of<
                                                            AllRequesterBloc>(
                                                        context)
                                                    .add(SepListHandler(
                                                        selectedProductId
                                                            .toString()));
                                              }
                                            });
                                          } else {}
                                          setState(() {
                                            selectedItem = newValue;
                                            // Update button enable state
                                            isButtonPartEnabled = newValue !=
                                                    null &&
                                                newValue.isNotEmpty &&
                                                ValidatorUtils.isValidCommon(
                                                    specificationName.text);
                                          });
                                        },
                                        items: productNames
                                            .map<DropdownMenuItem<String?>>(
                                                (String data) {
                                          return DropdownMenuItem<String?>(
                                            value: data,
                                            child: Text(data),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    focusNode: _specificationNameNode,
                                    key: _specificationNameKey,
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle
                                        .defaultInputDecoration
                                        .copyWith(
                                      hintText: "Enter Specification",
                                      fillColor: Colors.white,
                                    ),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    focusNode: _quantityNameNode,
                                    key: _quantityNameKey,
                                    keyboardType: TextInputType.number,
                                    decoration: FormFieldStyle
                                        .defaultInputDecoration
                                        .copyWith(
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    focusNode: _remarkNameNode,
                                    key: _remarkNameKey,
                                    keyboardType: TextInputType.name,
                                    decoration: FormFieldStyle
                                        .defaultInputDecoration
                                        .copyWith(
                                      hintText: "Enter Remark",
                                      fillColor: Colors.white,
                                    ),
                                    controller: remarkName,
                                    validator: ValidatorUtils.model,
                                  ).animateOnPageLoad(
                                    animationsMap['imageOnPageLoadAnimation2']!,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Event",
                                      style: FTextStyle.formLabelTxtStyle,
                                    ).animateOnPageLoad(
                                      animationsMap[
                                          'imageOnPageLoadAnimation2']!,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        // Ensure the container width is constrained properly
                                        width: double.infinity,
                                        // Expand to full width of parent container
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                          border: Border.all(
                                              color: AppColors
                                                  .primaryColourDark),
                                          color: Colors.white,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            key: _eventNameKey,
                                            focusNode: _eventNameNode,
                                            isExpanded: true,
                                            // Make the DropdownButton expand to fill the width of the container
                                            value: selectedEventItem,
                                            hint: const Text(
                                              "Select Event",
                                              style:
                                                  FTextStyle.formhintTxtStyle,
                                            ),
                                            onChanged: (String? eventValue) {
                                              setState(() {
                                                selectedEventItem =
                                                    eventValue;
                                                // Update button enable state
                                                isButtonPartEnabled =
                                                    eventValue != null &&
                                                        eventValue
                                                            .isNotEmpty &&
                                                        ValidatorUtils
                                                            .isValidCommon(
                                                                specificationName
                                                                    .text);
                                              });
                                            },
                                            items: eventNames.map<
                                                    DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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
                                  decoration: FormFieldStyle
                                      .defaultInputDecoration
                                      .copyWith(
                                    fillColor: Colors.white,
                                    hintText: "Upload File",
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.attach_file),
                                      onPressed: () async {
                                        final result = await FilePicker.platform
                                            .pickFiles();
                                        if (result != null &&
                                            result.files.isNotEmpty) {
                                          setState(() {
                                            fileName1 =
                                                result.files.single.name;
                                            imagesId =
                                                File(result.files.single.path!);
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
                                      isButtonPartEnabled = selectedItem !=
                                              null &&
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
                                      height: (displayType == 'desktop' ||
                                              displayType == 'tablet')
                                          ? 40
                                          : 48,
                                      child: ElevatedButton(
                                        onPressed: isButtonPartEnabled
                                            ? () {
                                                setState(() {
                                                  if (isEditMode) {
                                                    // Updating an existing item
                                                    if (selectedItemForEditing !=
                                                        null) {
                                                      final index =
                                                          itemList.indexOf(
                                                              selectedItemForEditing!);
                                                      itemList[index] = {
                                                        "product":
                                                            selectedProductId
                                                                .toString()!,
                                                        "productName":
                                                            selectedItem,
                                                        "event":
                                                            selectedEventItem!,
                                                        "specification":
                                                            specificationName
                                                                .text,
                                                        "quantity":
                                                            quantityName.text,
                                                        "image": imagesId,
                                                        "imageName":
                                                            uploadName.text,
                                                        "additional":
                                                            remarkName.text,
                                                        // Add your additional field here
                                                        "user_id":
                                                            userId.toString(),
                                                        // Replace with actual user_id if needed
                                                      };
                                                    }
                                                  } else {
                                                    // Adding a new item
                                                    itemList.add({
                                                      "product":
                                                          selectedProductId
                                                              .toString()!,
                                                      "productName":
                                                          selectedItem,
                                                      "event":
                                                          selectedEventItem,
                                                      "specification":
                                                          specificationName
                                                              .text,
                                                      "quantity":
                                                          quantityName.text,
                                                      "image": imagesId,
                                                      "imageName":
                                                          uploadName.text,
                                                      "additional":
                                                          remarkName.text,
                                                      // Add your additional field here
                                                      "user_id":
                                                          userId.toString(),
                                                      // Replace with actual user_id if needed
                                                    });
                                                  }

                                                  // Reset state after add/update
                                                  addVisibility = false;
                                                  isEditMode = false;
                                                  selectedItem = null;
                                                  specificationName.clear();
                                                  remarkName.clear();
                                                  quantityName.clear();
                                                  uploadName.clear();

                                                  // Enable the button for further actions if required
                                                  isButtonPartEnabled =
                                                      false; // Adjust this as needed
                                                  selectedItemForEditing =
                                                      null; // Clear the editing item
                                                });
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                          ),
                                          backgroundColor: isButtonPartEnabled
                                              ? AppColors.primaryColourDark
                                              : AppColors.disableButtonColor,
                                        ),
                                        child: Text(
                                          isEditMode ? "Update" : "Add",
                                          style: FTextStyle.loginBtnStyle,
                                        ),
                                      ).animateOnPageLoad(
                                        animationsMap[
                                            'imageOnPageLoadAnimation2']!,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        print(">>>ALLDATAITEMLOCAL$itemList");
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
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Product/Services: ",
                                        style: FTextStyle.listTitleSub,
                                        children: [
                                          TextSpan(
                                              text: item["productName"] ?? "--",
                                              style: FTextStyle.listTitle),
                                          const TextSpan(
                                              text: "\nSpecialization: ",
                                              style: FTextStyle.listTitleSub),
                                          TextSpan(
                                              text:
                                                  item["specification"] ?? "--",
                                              style: FTextStyle.listTitle),
                                          const TextSpan(
                                              text: "\nQuantity: ",
                                              style: FTextStyle.listTitleSub),
                                          TextSpan(
                                              text: item["quantity"] ?? "--",
                                              style: FTextStyle.listTitle),
                                          const TextSpan(
                                              text: "\nRemark: ",
                                              style: FTextStyle.listTitleSub),
                                          TextSpan(
                                              text: item["additional"] ?? "--",
                                              style: FTextStyle.listTitle),
                                          const TextSpan(
                                              text: "\nEvent: ",
                                              style: FTextStyle.listTitleSub),
                                          TextSpan(
                                              text: item["event"] ?? "--",
                                              style: FTextStyle.listTitle),
                                          const TextSpan(
                                              text: "\n",
                                              style: FTextStyle.listTitleSub),
                                          TextSpan(
                                              text: item["imageName"] ?? "--",
                                              // text: basename(item['image']!.path) ?? "--",
                                              style: FTextStyle.listTitle),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: AppColors.primaryColourDark),
                                    onPressed: () {
                                      setState(() {
                                        selectedItemForEditing = item;
                                        // selectedProductId = item["product"];
                                        specificationName.text =
                                            item["specification"] ?? "--";

                                        selectedEventItem=item["event"];
                                        selectedItem =item["productName"]??"--";
                                        quantityName.text =
                                            item["quantity"] ?? "--";
                                        remarkName.text =
                                            item["additional"] ?? "--";
                                        uploadName.text = item['imageName']!;
                                        addVisibility = true;
                                        isEditMode = true;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever,
                                        color: Colors.red),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height:
                          (displayType == 'desktop' || displayType == 'tablet')
                              ? 70
                              : 45,
                      child: ElevatedButton(
                          onPressed: isButtonEnabled
                              ? () async {
                            if(PrefUtils.getRole() == 'Purchase Manager') {
                                    BlocProvider.of<AllRequesterBloc>(context)
                                        .add(
                                      AddRequisitionHandler(
                                        date: dateFrom.text.toString(),
                                        unit: unitFromList.toString(),
                                        // Add your value here
                                        nextDate: selectedUnitItem.toString(),
                                        time: timeFromList.toString(),
                                        // Add your value here
                                        userId: userId.toString(),
                                        // Add your value here
                                        requisitionList: itemList,
                                      ),
                                    );
                                  }
                            else{
                              BlocProvider.of<AllRequesterBloc>(context)
                                  .add(
                                AddRequisitionHandler(
                                  date: dateFrom.text.toString(),
                                  unit: unitFromList.toString(),
                                  // Add your value here
                                  nextDate: nextFromList.toString(),
                                  time: timeFromList.toString(),
                                  // Add your value here
                                  userId: userId.toString(),
                                  // Add your value here
                                  requisitionList: itemList,
                                ),
                              );

                            }

                                  setState(() {
                                    isAddLoading = true;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            backgroundColor: isButtonEnabled
                                ? AppColors.primaryColourDark
                                : AppColors.disableButtonColor,
                          ),
                          child: isAddLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Submit",
                                  style: FTextStyle.loginBtnStyle,
                                )),
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
