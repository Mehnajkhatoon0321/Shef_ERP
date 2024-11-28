import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/product_service.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shef_erp/utils/validator_utils.dart';

class ProductServiceEdit extends StatefulWidget {
  String screenflag;
  String id;

  ProductServiceEdit({required this.screenflag, required this.id, super.key});

  @override
  State<ProductServiceEdit> createState() => _ProductServiceEditState();
}

class _ProductServiceEditState extends State<ProductServiceEdit> {
  late final GlobalKey<FormFieldState<String>> _unitNameKey =
      GlobalKey<FormFieldState<String>>();
  String? selectedUnitItem;
  String? selectedUnitId;
  bool isAnyChanges =false;
  List<dynamic> listData = [];
  List<dynamic> UnitsDataList = [];
  late final FocusNode _unitNameNode = FocusNode();
  @override
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
  bool isButtonEnabled = false;
  bool isLoadingEdit = false;
  bool _hasPressedSaveButton = false;
  bool isEditDetails = false;
  Map<String, dynamic> responseData = {};
  String? selectedRoleItem;
  final formKey = GlobalKey<FormState>();
  late final TextEditingController editController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  List<String> UnitNames = [];

  void initState() {
    super.initState();
    if (widget.screenflag.isNotEmpty && widget.screenflag == "Edit") {
      BlocProvider.of<AllRequesterBloc>(context)
          .add(ProductEditDetailUserHandler(widget.id));
    } else {
      BlocProvider.of<AllRequesterBloc>(context)
          .add(ProductListUserHandler(widget.id));
    }
  }

  final GlobalKey<FormFieldState<String>> _nameKey =
  GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _specificationKey =
  GlobalKey<FormFieldState<String>>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _specificationFocusNode = FocusNode();

  bool isNameFieldFocused = false;
  bool isSpecificationFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: AppColors.formFieldBackColour,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            widget.screenflag.isNotEmpty
                ? "Edit Product / Service"
                : "Create Product / Service",
            style: FTextStyle.HeadingTxtWhiteStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.primaryColourDark,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
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
            if (state is ProductEditDetailsLoading) {
              setState(() {
                isEditDetails = true;
              });
            } else if (state is CreateProductLoading) {
              setState(() {
                isLoadingEdit = true;
              });
            } else if (state is UpdateProductLoading) {
              setState(() {
                isLoadingEdit = true;
              });
            } else if (state is ProductEditSuccess) {
              setState(() {
                isLoadingEdit = false;
                isEditDetails = false;

                responseData = state.userList;

                var user = state.userList['product'] ?? {};
                listData = state.userList['cates'];

                UnitNames = listData
                    .map<String>((item) => item['cate_name'] as String)
                    .toList();

                if (user.isNotEmpty && widget.screenflag.isNotEmpty) {
                  // Set user details
                  descriptionController.text = user["name"] ?? '';
                  addressController.text = user["specification"] ?? '';

                  String userCatId = user['cat_id']?.toString() ?? '';
                  var unit = listData.firstWhere(
                    (u) => u['id'].toString() == userCatId,
                    orElse: () => null,
                  );

                  if (unit != null) {
                    selectedUnitItem = unit['cate_name'];
                    selectedUnitId = unit['id']
                        .toString(); // Set the ID directly if the unit is found
                  } else {
                    selectedUnitItem = null;
                    selectedUnitId =
                        null; // Ensure ID is also null if no unit is found
                  }
                }
              });
            } else if (state is ProductEditFailure) {
              setState(() {
                isLoadingEdit = false;
                isEditDetails = false;
              });
              if (kDebugMode) {
                print("error>> ${state.deleteEditFailure}");
              }
            } else if (state is ProductEditListLoading) {
              setState(() {
                isLoadingEdit = true;
                isEditDetails = false;
              });
            } else if (state is ProductEditListSuccess) {
              setState(() {
                isLoadingEdit = false;
                isEditDetails = false;

                responseData = state.userEditDeleteList;





                listData = state.userEditDeleteList['list'];

                // If screenflag is empty, fallback to previous logic or data
                UnitNames = listData
                    .map<String>((item) => item['cate_name'] as String)
                    .toList();


              });
            }

            else if (state is ProductEditServerListFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                context,
                state.deleteEditServerFailure['error'].toString(),
              );
            }else if (state is ProductEditListFailure) {
              setState(() {
                isLoadingEdit = false;
              });
              if (kDebugMode) {
                print("error>> ${state.deleteEditFailure}");
              }
            } else if (state is CheckNetworkConnection) {
              CommonPopups.showCustomPopup(
                context,
                'Internet is not connected.',
              );
            }

            else if (state is CreateProductSuccess) {
              setState(() {
                isLoadingEdit = false;
                isAnyChanges = true;
                var     messageSuccess=state.createList['message'];

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(messageSuccess),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
                //
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context, [true]); // Pass the changes status back
                });






              });
            }
            else if (state is CreateProductFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                  context, state.createFailure['message'].toString());
            } else if (state is UpdateProductSuccess) {
              setState(() {
                isLoadingEdit = false;


                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context,[true]);
                });

              });
            }
            else if (state is ProductEditServerListFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                context,
                state.deleteEditServerFailure['error'].toString(),
              );
            }else if (state is UpdateProductFailure) {
              setState(() {
                isLoadingEdit = false;
              });

              CommonPopups.showCustomPopup(
                  context, state.updateFailure['message'].toString());
            }
            //create product
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,

              onChanged: _updateButtonState,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Product/Service Category",
                        style: FTextStyle.preHeadingStyle,
                      ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation2']!,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.0),
                        border: Border.all(
                            color: AppColors.formFieldHintColour, width: 1.3),
                        color: AppColors.formFieldBackColour,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          key: _unitNameKey,
                          focusNode: _unitNameNode,
                          isExpanded: true,
                          value: selectedUnitItem,
                          // Reflect the current user's unit
                          hint: const Text(
                            "Select Unit",
                            style: FTextStyle.formhintTxtStyle,
                          ),
                          onChanged: (String? eventValue) {
                            setState(() {
                              selectedUnitItem =
                                  eventValue; // Update the selected unit

                              // Update the selectedUnitId based on the selected unit
                              selectedUnitId = listData
                                  .firstWhere(
                                    (unit) => unit['cate_name'] == eventValue,
                                    orElse: () => {'id': '', 'cate_name': ''},
                                  )['id']
                                  .toString(); // Ensure we safely cast to String

                              // Update button enabled state
                              isButtonEnabled =
                                  eventValue != null && eventValue.isNotEmpty;
                            });
                          },
                          items: UnitNames.map<DropdownMenuItem<String>>(
                              (String unitName) {
                            return DropdownMenuItem<String>(
                              value: unitName, // Use the unit name as the value
                              child: Text(unitName),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    if (_hasPressedSaveButton && selectedUnitItem == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 6),
                        child: Text(
                          "Please select a Category",
                          style: FTextStyle.formErrorTxtStyle,
                        ),
                      ),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Product Name",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      key: _nameKey,
                      focusNode: _nameFocusNode,
                      controller: descriptionController,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Product Name",
                      ),
                      onTap: (){
                        // isNameFieldFocused=true;
                        // isSpecificationFieldFocused=false;


                      },
                      // validator: ValidatorUtils.productNameValidator
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Specification",
                            style: FTextStyle.preHeadingStyle)),
                    TextFormField(
                      key: _specificationKey,
                      focusNode:_specificationFocusNode ,
                      controller: addressController,
                      decoration:
                          FormFieldStyle.defaultInputEditDecoration.copyWith(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "Enter Specification",
                      ),
                      onTap: (){
                        // isNameFieldFocused=false;
                        // isSpecificationFieldFocused=true;


                      },
                      // validator: ValidatorUtils.specificationProductValidator
                    ),
                    const SizedBox(height: 40),


                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _hasPressedSaveButton = true; // Set the flag to true

                              });
                              if (formKey.currentState!.validate()) {
                                // All fields are valid, proceed with submission
                                setState(() {
                                  isLoadingEdit = true; // Start loading
                                });

                                // Determine whether to update or create a vendor
                                if (widget.screenflag.isNotEmpty) {
                                  BlocProvider.of<AllRequesterBloc>(context)
                                      .add(
                                    ProductUpdateEventHandler(
                                        cateName: selectedUnitId.toString(),
                                        name: descriptionController.text
                                            .toString(),
                                        user_id: PrefUtils.getUserId()
                                            .toString(),
                                        specification: addressController
                                            .text
                                            .toString(), id: widget.id),
                                  );

                                } else {
                                  BlocProvider.of<AllRequesterBloc>(context)
                                      .add(
                                    ProductCreateEventHandler(
                                        cateName: selectedUnitId.toString(),
                                        name: descriptionController.text
                                            .toString(),
                                        user_id: PrefUtils.getUserId()
                                            .toString(),
                                        specification: addressController
                                            .text
                                            .toString()),
                                  );
                                }
                              } else {
                                // If any field is invalid, trigger validation error display
                                formKey.currentState!.validate();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                              backgroundColor: isButtonEnabled
                                  ? AppColors.primaryColourDark
                                  : AppColors.formFieldBorderColour,
                            ),
                            child: isLoadingEdit
                                ? CircularProgressIndicator(color: Colors.blue)
                                : Text("Save", style: FTextStyle.loginBtnStyle),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _updateButtonState() {
    setState(() {
      isButtonEnabled = ValidatorUtils.isValidProductName(descriptionController.text) ;


      if (isNameFieldFocused == true) {
        _nameKey.currentState!.validate();
      }
      // if (isSpecificationFieldFocused == true) {
      //   _specificationKey.currentState!.validate();
      // }
    });
  }
}
