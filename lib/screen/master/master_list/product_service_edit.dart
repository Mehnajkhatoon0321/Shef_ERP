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
import 'package:shef_erp/utils/pref_utils.dart';
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
  bool isButtonEnabled = true;
  bool isLoadingEdit = false;
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
      // editController.text = widget.name;
      // descriptionController.text = widget.billingAddress;
      // addressController.text = widget.address;
    }
    else{
      BlocProvider.of<AllRequesterBloc>(context)
          .add(ProductListUserHandler(widget.id));
      // editController.text = widget.name;
      // descriptionController.text = widget.billingAddress;
      // addressController.text = widget.address;


    }
  }

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    return Scaffold(
      backgroundColor: AppColors.formFieldBorderColour,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.screenflag.isNotEmpty ?   "Edit Product / Service"
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
              isLoadingEdit = true;
            });
          }else if (state is CreateProductLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          }else if (state is UpdateProductLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          }


          else if (state is ProductEditSuccess) {
            setState(() {
              isLoadingEdit = false;

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
                  selectedUnitId = unit['id'].toString(); // Set the ID directly if the unit is found
                } else {
                  selectedUnitItem = null;
                  selectedUnitId = null; // Ensure ID is also null if no unit is found
                }
              }
            });
          }
          else if (state is ProductEditFailure) {
            setState(() {
              isLoadingEdit = false;
            });
            if (kDebugMode) {
              print("error>> ${state.deleteEditFailure}");
            }
          }

          if (state is ProductEditListLoading) {
            setState(() {
              isLoadingEdit = true;
            });
          }


          else if (state is ProductEditListSuccess) {
            setState(() {
              isLoadingEdit = false;

              responseData = state.userEditDeleteList;


              listData = state.userEditDeleteList['list'];



              // If screenflag is empty, fallback to previous logic or data
              UnitNames = listData
                  .map<String>((item) => item['cate_name'] as String)
                  .toList();


            });
          }
          else if (state is ProductEditListFailure) {
            setState(() {
              isLoadingEdit = false;
            });
            if (kDebugMode) {
              print("error>> ${state.deleteEditFailure}");
            }
          }
          else if (state is CreateProductSuccess) {
            setState(() {
              isLoadingEdit = false;

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AllRequesterBloc(),
                      child: const ProductService(),
                    )),
              );
            });
          }
          else if (state is CreateProductFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.createFailure.toString());
          }
          else if (state is CheckNetworkConnection) {
            CommonPopups.showCustomPopup(
              context,
              'Internet is not connected.',
            );
          }
          else if (state is UpdateProductSuccess) {
            setState(() {
              isLoadingEdit = false;

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AllRequesterBloc(),
                      child: const ProductService(),
                    )),
              );
            });
          }
          else if (state is UpdateProductFailure) {
            setState(() {
              isLoadingEdit = false;
            });

            CommonPopups.showCustomPopup(context, state.updateFailure.toString());
          }
          //create product



        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
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
                    border: Border.all(color: AppColors.formFieldHintColour, width: 1.3),
                    color: AppColors.formFieldBackColour,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      key: _unitNameKey,
                      focusNode: _unitNameNode,
                      isExpanded: true,
                      value: selectedUnitItem, // Reflect the current user's unit
                      hint: const Text(
                        "Select Unit",
                        style: FTextStyle.formhintTxtStyle,
                      ),
                      onChanged: (String? eventValue) {
                        setState(() {
                          selectedUnitItem = eventValue; // Update the selected unit

                          // Update the selectedUnitId based on the selected unit
                          selectedUnitId = listData.firstWhere(
                                (unit) => unit['cate_name'] == eventValue,
                            orElse: () => {'id': '', 'cate_name': ''},
                          )['id'].toString(); // Ensure we safely cast to String

                          // Update button enabled state
                          isButtonEnabled = eventValue != null && eventValue.isNotEmpty;
                        });
                      },
                      items: UnitNames.map<DropdownMenuItem<String>>((String unitName) {
                        return DropdownMenuItem<String>(
                          value: unitName, // Use the unit name as the value
                          child: Text(unitName),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Product Name",
                        style: FTextStyle.preHeadingStyle)),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Enter Product Name",
                    hintStyle: FTextStyle.formhintTxtStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      borderSide: const BorderSide(
                          color: AppColors.formFieldHintColour, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      borderSide: const BorderSide(
                          color: AppColors.formFieldHintColour, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColourDark, width: 1.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 18.0),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name .';
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Specification", style: FTextStyle.preHeadingStyle)),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Enter Specification",
                    hintStyle: FTextStyle.formhintTxtStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      borderSide: const BorderSide(
                          color: AppColors.formFieldHintColour, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      borderSide: const BorderSide(
                          color: AppColors.formFieldHintColour, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColourDark, width: 1.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 18.0),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: (displayType == 'desktop' ||
                            displayType == 'tablet')
                            ? 70
                            : 40,
                        child: ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () async {
                              setState(() {
                                isLoadingEdit = true;
                              });
                              if (widget.screenflag.isNotEmpty) {
                                BlocProvider.of<AllRequesterBloc>(context)
                                    .add(
                                  ProductCreateEventHandler(cateName: selectedUnitId.toString(), name: descriptionController.text.toString(), user_id: PrefUtils.getUserId().toString(), specification: addressController.text.toString()

                                  ),
                                );
                              } else {
                                BlocProvider.of<AllRequesterBloc>(context)
                                    .add(
                                  ProductUpdateEventHandler(cateName: selectedUnitId.toString(), name: descriptionController.text.toString(), user_id: PrefUtils.getUserId().toString(), specification: addressController.text.toString()

                                  ),
                                );
                              }
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
                            child: isLoadingEdit
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Save",
                              style: FTextStyle.loginBtnStyle,
                            )),
                      )),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
