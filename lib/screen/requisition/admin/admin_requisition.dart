import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';

import 'package:shef_erp/screen/requisition/unit_head/add_requisition.dart';
import 'package:shef_erp/screen/requisition/unit_head/view_details.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/asign_vector.dart';
import 'package:shef_erp/utils/colour_status.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shef_erp/utils/unit_head_status.dart';
import 'package:shef_erp/utils/validator_utils.dart';
import 'package:shef_erp/utils/vender_name.dart';
import 'package:shimmer/shimmer.dart';

class AdminRequisition extends StatefulWidget {
  const AdminRequisition({super.key});

  @override
  State<AdminRequisition> createState() => _AdminRequisitionState();
}

class _AdminRequisitionState extends State<AdminRequisition> {
  int? selectedId;
  int? selectedBillingId;
  Map<String, String>? selectedItemForEditing;
  Map<String, int> productMap = {};
  Map<String, int> billingMap = {};
  late final GlobalKey<FormFieldState<String>> _vendorNameKey =
  GlobalKey<FormFieldState<String>>();
  late final GlobalKey<FormFieldState<String>> _billingNameKey =
  GlobalKey<FormFieldState<String>>();
  late final TextEditingController vendorName = TextEditingController();
  late final TextEditingController billingName = TextEditingController();
  late final FocusNode _vendorNameNode = FocusNode();
  late final FocusNode _billingNameNode = FocusNode();
  TextEditingController _editController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  String? selectedItem;
  String? selectedBilling;
  bool isButtonPartEnabled = false;
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 5;
  bool hasMoreData = true;
  List<dynamic> data = [];
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;
  bool isLoadingApprove = false;
  List<dynamic> list = [];
  List<dynamic> billing = [];
  List<dynamic> listBilling = ['Demo', 'data', 'items'];
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

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
    _editController = TextEditingController();
    BlocProvider.of<AllRequesterBloc>(context).add(AddCartDetailHandler("", pageNo, pageSize));
    paginationCall();
  }

  void paginationCall() {
    controllerI.addListener(() {
      if (controllerI.position.pixels == controllerI.position.maxScrollExtent) {
        if (pageNo < totalPages && !isLoading) {
          if (hasMoreData) {
            pageNo++;
            BlocProvider.of<AllRequesterBloc>(context).add(AddCartDetailHandler("", pageNo, pageSize));
          }
        }
      }
    });
  }


  Set<int> selectedIndices = {};
  List<String> productNames = [];
  List<String> billingNames = [];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return Scaffold(
      backgroundColor: AppColors.formFieldBorderColour,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Requisition', style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,),
        backgroundColor: AppColors.primaryColourDark,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height:
              (displayType == 'desktop' || displayType == 'tablet')
                  ? 70
                  : 43,
              child: ElevatedButton(
                  onPressed: () async {
                    // setState(() {
                    //   isLoading = true;
                    // });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>   BlocProvider(
  create: (context) => AllRequesterBloc(),
  child: AddRequisition( flag: "unit",),
),
                      ),
                    );

                    // );
                  },

                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      backgroundColor:Colors.white

                  ),
                  child:
                  Text(
                    "Add +",
                    style: FTextStyle.loginBtnStyle.copyWith(color:AppColors.primaryColourDark),
                  )

              ),
            ),
          )
        ],
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

      body: BlocListener<AllRequesterBloc, AllRequesterState>(
        listener: (context, state) {
          if (state is AddCartLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is AddCartSuccess) {
            setState(() {
              var responseData = state.addCartDetails['list']['requisitions'];
              list = state.addCartDetails['list']['vendors'];

              productNames =
                  list.map<String>((item) => item['company_name'] as String)
                      .toList();

              productMap = {
                for (var item in list)
                  item['company_name'] as String: item['id'] as int
              };

              billing = state.addCartDetails['list']['billings'];

              billingNames =
                  billing.map<String>((item) => item['billing_name'] as String)
                      .toList();


              billingMap = {
                for (var item in billing)
                  item['billing_name'] as String: item['id'] as int
              };

              if (kDebugMode) {
                print(">>>>>>>>>>>ALLDATA$responseData");
              }
              totalPages = responseData["total"];

              if (pageNo == 1) {
                data.clear();
              }

              data.addAll(responseData['data']);

              setState(() {
                isLoading = false;
                if (pageNo == totalPages) {
                  hasMoreData = false;
                }
              });
            });
          } else if (state is AddCartFailure) {
            setState(() {
              isLoading = false;
            });
            print("error>> ${state.addCartDetailFailure}");
          } else if (state is DeleteLoading) {
            DeletePopupManager.playLoader();
          } else if (state is DeleteSuccess) {
            DeletePopupManager.stopLoader();

            var deleteMessage = state.deleteList['message'];

            BlocProvider.of<AllRequesterBloc>(context).add(AddCartDetailHandler("", pageNo, pageSize));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(deleteMessage),
                backgroundColor: AppColors.primaryColour,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          }else  if (state is RejectLoading) {
            setState(() {
              isLoadingApprove = true;
            });
          } else if (state is RejectSuccess) {
            isLoadingApprove=false;
            setState(() {
              var responseData = state.rejectList;
              Navigator.of(context).pop();

            });

            print("RejectSuccess>>>");
          } else if (state is RejectFailure) {
            setState(() {
              isLoading = false;
            });
            print("error>> ${state.rejectFailure}");
          }

        },
         child: Column(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search Requisition',
                  hintStyle: FTextStyle.formhintTxtStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
                  suffixIcon: _isTextEmpty
                      ? const Icon(Icons.search, color: AppColors.primaryColourDark)
                      : IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.primaryColourDark),
                    onPressed: _clearText,
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _isTextEmpty = value.isEmpty;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [


                SizedBox(
                  height:
                  (displayType == 'desktop' || displayType == 'tablet')
                      ? 70
                      : 38,
                  child: ElevatedButton(
                      onPressed: () async {
                        _showBrandDialog(-1);
                      },

                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          backgroundColor: Colors.green

                      ),
                      child:
                      Text(
                        "Approve & Assign Vendor",
                        style: FTextStyle.loginBtnStyle,
                      )


                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height:
                  (displayType == 'desktop' || displayType == 'tablet')
                      ? 70
                      : 38,
                  child: ElevatedButton(
                      onPressed: () async {
                        _showRejectDialog(-1);

                      },

                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          backgroundColor: AppColors.errorColor

                      ),
                      child:
                      Text(
                        "Reject",
                        style: FTextStyle.loginBtnStyle,
                      )


                  ),
                ),

              ],),
          ),

          Expanded(
            child: isLoading && data.isEmpty
                ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 10, // Number of shimmer placeholders
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 5),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
                : data.isEmpty?Center(
              child: isLoading
                  ? const CircularProgressIndicator() // Show circular progress indicator
                  : const Text("No more data .", style: FTextStyle.listTitle),
            ): ListView.builder(
              controller: controllerI,
              itemCount: data.length + (hasMoreData ? 1 : 0), // Add one for the loading indicator
              itemBuilder: (context, index) {
                if (index < data.length) {
                  final item = data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDetails(
                        requisition: item["req_no"] ?? "N/A",
                        poNumber: item["po_no"] ?? "N/A",
                        requestDate: item["req_date"] ?? "N/A",
                        unit: item["unit"] ?? "N/A",
                        product: item["product_name"] ?? "N/A",
                        specification: item["specification"] ?? "N/A",
                        quantity: item["quantity"].toString() ?? "N/A",
                        unitHead: item["unitHead"].toString() ?? "N/A",
                        purchase: item["purchase"].toString() ?? "N/A",
                        delivery: item["dl_status"].toString() ?? "N/A",
                        vender: item["vender"] ?? "N/A",
                        image: item["image"].toString(),

                      )));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Transform.scale(
                              scale: 1.2,
                              
                              child: Checkbox(
                                value: selectedIndices.contains(index),
                                activeColor: AppColors.primaryColourDark,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedIndices.add(index);
                                    } else {
                                      selectedIndices.remove(index);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(  // Wrap Container with Expanded
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ? Colors.white : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color:  AppColors.primaryColourDark,
                                    spreadRadius: 1.6,
                                    blurRadius: 0.6,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                                children: [
                                  Row(
                                    children: [
                                      const Text("Requisition No: ", style: FTextStyle.listTitle),
                                      Expanded(child: Text("${item["req_no"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,)),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      const Text("PO No. : ", style: FTextStyle.listTitle),
                                      Expanded(
                                        child: Text("${item["po_no"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Request Date: ", style: FTextStyle.listTitle),
                                      Expanded(child: Text("${item["req_date"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,)),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Unit: ", style: FTextStyle.listTitle),
                                      Expanded(child: Text("${item["unit"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: DeliveryStatus(dlStatus: item["dl_status"].toString())),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: UnitHeadStatus(unitStatus: item["uh_status"].toString())),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: PurchaseManager(pmStatus: item["pm_status"].toString())),
                                    ],
                                  ),
                                  VendorStatus(
                                    role: PrefUtils.getRole(), // Example role
                                    deliveryStatus:  item["dl_status"], // Example delivery status
                                    companyName: item['company']??"NA", // Example company name
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [


                                        Column(
                                          children: [
                                            if (PrefUtils.getRole() == "Purchase Manager")
                                            Visibility(
                                              visible: item['dl_status'] == 1,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    _showMarkDeliveryDialog(-1);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(26),
                                                    ),
                                                    backgroundColor: AppColors.yellow,
                                                    minimumSize: const Size(80, 32),
                                                  ),
                                                  child: Text(
                                                    "Mark Delivery",
                                                    style: FTextStyle.emailProfile,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (item["uh_status"] == 1 && item['pm_status'] == 1) // Display edit and delete buttons if uh_status is 0
                                        Row(
                                          children: [
                                            // IconButton(
                                            //   icon: const Icon(Icons.edit, color: Colors.black),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //         builder: (context) => BlocProvider(
                                            //           create: (context) => AllRequesterBloc(),
                                            //           child: EditRequisition(id: item["id"].toString() ?? 'N/A'),
                                            //         ),
                                            //       ),
                                            //     );
                                            //   },
                                            // ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red,size: 26,),
                                              onPressed: () {
                                                CommonPopups.showDeleteCustomPopup(
                                                  context,
                                                  "Are you sure you want to delete?",
                                                      () {
                                                    BlocProvider.of<AllRequesterBloc>(context)
                                                        .add(DeleteHandlers(data[index]['id'] ?? 'N/A'));
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),

                                    ],
                                  ),




                                ],
                              ),
                            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // This is the loading indicator
                  return Center(
                    child: isLoading
                        ? const CircularProgressIndicator() // Show circular progress indicator
                        : const Text("No more data.", style: FTextStyle.listTitle),
                  );
                }
              },
            )

          ),

          const SizedBox(height: 20),
        ],
      ),
       ),
    );
  }

  void _clearText() {
    _controller.clear();
    setState(() {
      _isTextEmpty = true;
    });
  }

  void _showBrandDialog(int index) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _editController = TextEditingController();
    String? selectedItem; // Initialize with null
    String? selectedBilling; // Initialize with null
    bool isButtonPartEnabled = false; // Initialize button state

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Helper function to check if the button should be enabled
            void _updateButtonState() {
              setState(() {
                isButtonPartEnabled = (selectedItem != null && selectedItem!.isNotEmpty) &&
                    (selectedBilling != null && selectedBilling!.isNotEmpty);
              });
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.0),
              ),
              title: Text(
                "Vendor Assign",
                style: FTextStyle.preHeading16BoldStyle,
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.98,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Select Vendor",
                        style: FTextStyle.preHeadingStyle,
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
                              key: _vendorNameKey,
                              focusNode: _vendorNameNode,
                              isExpanded: true,
                              // Make the DropdownButton expand to fill the width of the container
                              value: selectedItem,
                              hint: const Text(
                                "Select Vendor",
                                style:
                                FTextStyle.formhintTxtStyle,
                              ),
                              onChanged: (String? eventValue) {
                                setState(() {
                                  selectedItem =
                                      eventValue;
                                  // Update button enable state
                                  isButtonPartEnabled =
                                      eventValue != null &&
                                          eventValue
                                              .isNotEmpty;
                                });
                              },
                              items: productNames.map<
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


                      Text(
                        "Select Billing Name",
                        style: FTextStyle.preHeadingStyle,
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
                              key: _billingNameKey,
                              focusNode: _billingNameNode,
                              isExpanded: true,
                              // Make the DropdownButton expand to fill the width of the container
                              value: selectedBilling,
                              hint: const Text(
                                "Select Billing Name",
                                style:
                                FTextStyle.formhintTxtStyle,
                              ),
                              onChanged: (String? eventValue) {
                                setState(() {
                                  selectedBilling =
                                      eventValue;
                                  // Update button enable state
                                  isButtonPartEnabled =
                                      eventValue != null &&
                                          eventValue
                                              .isNotEmpty;
                                });
                              },
                              items: billingNames.map<
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
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.formFieldBackColour,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
                const SizedBox(width: 10),
                Container(
                  width: isButtonPartEnabled ? 100 : 80, // Dynamic width based on button state
                  height: 50, // Fixed height or can be dynamic
                  decoration: BoxDecoration(
                    color: isButtonPartEnabled ? AppColors.primaryColourDark : AppColors.dividerColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    onPressed: isButtonPartEnabled ? () {
                      Navigator.of(context).pop();
                    } : null,
                    child: const Text("OK", style: TextStyle(color: Colors.white)),
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
              ],
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );
  }







  void _showRejectDialog(int index) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _editController = TextEditingController();
    bool isButtonEnabled = false; // Initialize button state

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Add listener to the TextEditingController to monitor text changes
            _editController.addListener(() {
              setState(() {
                isButtonEnabled = _editController.text.isNotEmpty;
              });
            });

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              title: Text(
                "Reject",
                style: FTextStyle.preHeading16BoldStyle,
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Purchase Manager Remark",
                        style: FTextStyle.preHeadingStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _editController,
                          decoration: InputDecoration(
                            hintText: "Enter Purchase Manager Remark",
                            hintStyle: FTextStyle.formhintTxtStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
                            fillColor: Colors.grey[100],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a remark';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.formFieldBackColour,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: isButtonEnabled ? AppColors.primaryColourDark : AppColors.formFieldBorderColour,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    onPressed: isButtonEnabled ? () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the reject action here
                        Navigator.of(context).pop();
                      }
                    } : null,
                    child:  Text("Reject", style: TextStyle(color:isButtonEnabled ? Colors.white:Colors.white)),
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
              ],
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );
  }
  void _showMarkDeliveryDialog(int index) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _editController = TextEditingController();
    bool isButtonEnabled = false; // Initialize button state
    late final GlobalKey<FormFieldState<String>> _uploadNameKey =
    GlobalKey<FormFieldState<String>>();
    late final TextEditingController uploadName = TextEditingController();
    late final FocusNode _uploadNameNode = FocusNode();
    bool isUploadFocused = false;
    bool isImageUploaded = false;
    String? fileName1;
    File? imagesId;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Add listener to the TextEditingController to monitor text changes
            _editController.addListener(() {
              setState(() {
                isButtonEnabled = _editController.text.isNotEmpty;
              });
            });

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              title: Text(
                "Mark Delivery",
                style: FTextStyle.preHeading16BoldStyle.copyWith(fontSize: 20),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Purchase Manager Remark",
                        style: FTextStyle.preHeading16BoldStyle,
                      ),
                      const SizedBox(height: 10),

                      TextFormField(
                        controller: _editController,
                        decoration: InputDecoration(
                          hintText: "Enter Purchase Manager Remark",
                          hintStyle: FTextStyle.formhintTxtStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: const BorderSide(color: AppColors.formFieldHintColour, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: const BorderSide(color: AppColors.primaryColourDark, width: 1.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
                          fillColor: Colors.grey[100],
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a remark';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

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
                          fillColor: AppColors.formFieldBackColour,
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
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColourDark,
                    textStyle: FTextStyle.loginBtnStyle,
                    // Adjusted button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    elevation: 1,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'Outfit-Regular',
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed:  isButtonEnabled ? () {
                    if (_formKey.currentState?.validate() ?? false) {

                      BlocProvider.of<AllRequesterBloc>(context)
                          .add(
                        RejectHandler(
                            _editController.text.toString()


                        ),
                      );

                      // Handle the reject action here

                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColourDark,
                    textStyle: FTextStyle.loginBtnStyle,
                    // Adjusted button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    elevation: 1,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: 'Outfit-Regular',
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                // Container(
                //   decoration: BoxDecoration(
                //     color: isButtonEnabled ? AppColors.primaryColourDark : AppColors.formFieldBorderColour,
                //     borderRadius: BorderRadius.circular(25.0),
                //   ),
                //   child: TextButton(
                //     onPressed: isButtonEnabled ? () {
                //       if (_formKey.currentState?.validate() ?? false) {
                //
                //         BlocProvider.of<AllRequesterBloc>(context)
                //             .add(
                //           RejectHandler(
                //               _editController.text.toString()
                //
                //
                //           ),
                //         );
                //
                //         // Handle the reject action here
                //
                //       }
                //     } : null,
                //     child:isLoadingApprove? CircularProgressIndicator(color: Colors.white,): Text("Reject", style: TextStyle(color:isButtonEnabled ? Colors.white:Colors.white)),
                //   ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                // ),
              ],
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );
  }





}
