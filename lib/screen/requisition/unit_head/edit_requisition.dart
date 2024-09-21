import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/requester/requisition_requester.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';
class EditRequisition extends StatefulWidget {
String id;

   EditRequisition({ required this.id, super.key});

  @override
  State<EditRequisition> createState() => _EditRequisitionState();
}




class _EditRequisitionState extends State<EditRequisition> {
  bool isButtonPartEnabled = false;
  int? selectedProductId;
  int? requisitionID;
  int? requisitionProductID;
  List<dynamic>   ProductList=[];
  List<dynamic>   RequisitionList=[];
  bool isSpecificationFieldFocused = false;
  bool isProductFieldFocused = false;
  bool isQuantityFocused = false;
  bool isRemarkFocused = false;
  bool isUploadFocused = false;
  bool isImageUploaded = false;
  String? fileName1;
  File? imagesId;
  List<dynamic> list = ['Female', 'data', 'items'];
  List<String> productNames = [];
  Map<String, int> productMap={};
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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AllRequesterBloc>(context).add(EditDetailHandler(widget.id));
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
      body: BlocListener<AllRequesterBloc,AllRequesterState>(



  listener: (context, state) {
    if (state is EditLoading) {
      setState(() {
        isLoading = true;
      });
    } else if (state is EditSuccess) {
      setState((){
        var editDetailsList = state.editList;
        print("AllDataEdit>>>>${editDetailsList}");

        ProductList = state.editList['products'];
        RequisitionList = state.editList['req'];

        if (RequisitionList.isNotEmpty) {
          var firstReq = RequisitionList[0];
          requisitionID = firstReq['id'];
          requisitionProductID = firstReq['product_id'];


          quantityName.text = firstReq['quantity'].toString();
          remarkName.text = firstReq['staff_remarks'] ?? ''; // Handle null case
          specificationName.text = firstReq['specification'];
          uploadName.text = firstReq['image'];

          var matchedProduct = ProductList.firstWhere(
                (item) => item['id'] == requisitionProductID,
            orElse: () => null, // Return null if no match is found
          );

          if (matchedProduct != null) {

            selectedItem = matchedProduct['name'];
            selectedProductId = matchedProduct['id']; // Store the product ID if needed
          }
        }

        print("ALLProductDat>>>>>>>>>>>>>>>>>a$ProductList");
        productNames = ProductList.map<String>((item) => item['name'] as String).toList();

        productMap = {
          for (var item in ProductList) item['name'] as String: item['id'] as int
        };

        // Additional logic can go here, if needed
      }



      );
    }
    else if (state is UpdateLoading) {
      isLoading = true;
    } else if (state is UpdateSuccess) {
      isLoading = false;

      var deleteMessage = state.updateList['message'];


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(deleteMessage),
          backgroundColor: AppColors.primaryColour,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(
        create: (context) => AllRequesterBloc(),
        child: RequisitionRequester(),
      )));

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    }




    else if (state is AddCartFailure) {
      setState(() {
        isLoading = false;
      });
      print("error>> ${state.addCartDetailFailure}");
    }
    // TODO: implement listener
  },
  child:

  SingleChildScrollView(
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
                      child: DropdownButton<String?>(
                        key: _productNameKey,
                        focusNode: _productNameNode,
                        value: selectedItem,
                        hint: const Text(
                          "Select Product/Service",
                          style: FTextStyle.formhintTxtStyle,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue;
                            selectedProductId = newValue != null ? productMap[newValue] : null;

                            isButtonPartEnabled = newValue != null &&
                                newValue.isNotEmpty &&
                                ValidatorUtils.isValidCommon(specificationName.text);

                            // Uncomment if you want to trigger an event when a product is selected
                            // if (selectedProductId != null) {
                            //   BlocProvider.of<AllRequesterBloc>(context)
                            //       .add(SepListHandler(selectedProductId.toString()));
                            // }
                          });
                        },
                        items: productNames.isNotEmpty
                            ? productNames.map<DropdownMenuItem<String?>>((String data) {
                          return DropdownMenuItem<String?>(
                            value: data,
                            child: Text(data),
                          );
                        }).toList()
                            : [
                          DropdownMenuItem<String?>(
                            value: null,
                            child: Text(''),
                          ),
                        ],
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
                              // BlocProvider.of<AllRequesterBloc>(context).add(
                              //   UpdateRequisitionEventHandler(
                              //     date: dateFrom.text.toString(),
                              //     unit: unitFromList.toString(),  // Add your value here
                              //     nextDate: nextFromList.toString(),
                              //     time: timeFromList.toString(),  // Add your value here
                              //     userId:userId.toString(),  // Add your value here
                              //     requisitionList: itemList,
                              //   ),
                              // );
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
                            child:isLoading? Text(
                              "Update",
                              style: FTextStyle.loginBtnStyle,
                            ):CircularProgressIndicator(color: Colors.blue,),
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
    );
  }
}
