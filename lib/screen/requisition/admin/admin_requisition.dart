import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';

import 'package:shef_erp/screen/requisition/unit_head/add_requisition.dart';
import 'package:shef_erp/screen/requisition/unit_head/edit_requisition.dart';
import 'package:shef_erp/screen/requisition/unit_head/view_details.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/asign_vector.dart';
import 'package:shef_erp/utils/colour_status.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shef_erp/utils/unit_head_status.dart';
import 'package:shef_erp/utils/vender_name.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/validator_utils.dart';
class AdminRequisition extends StatefulWidget {
  const AdminRequisition({super.key});

  @override
  State<AdminRequisition> createState() => _AdminRequisitionState();
}

class _AdminRequisitionState extends State<AdminRequisition> {


  Map<String, String>? selectedItemForEditing;
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
  List<dynamic> list = ['Female', 'data', 'items'];
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return Scaffold(
      backgroundColor: AppColors.dividerColor,
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
              print(">>>>>>>>>>>ALLDATA$responseData");
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
                  hintText: 'Search requisition',
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

                    // isLoading? CircularProgressIndicator(color: Colors.white,):Text(
                    //   Constants.loginBtnTxt,
                    //   style: FTextStyle.loginBtnStyle,
                    // )
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
                        requisition: item["req_no"],
                        poNumber: item["po_no"],
                        requestDate: item["req_date"],
                        unit: item["unit"],
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
                              scale: 1.3,
                              child: Checkbox(
                                value: selectedIndices.contains(index),
                                activeColor: index % 2 == 0 ? AppColors.yellow : AppColors.primaryColourDark,
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
                                boxShadow: [
                                  BoxShadow(
                                    color: index % 2 == 0 ? AppColors.yellow : AppColors.primaryColourDark,
                                    spreadRadius: 4,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 1),
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
                                    companyName: item['company'], // Example company name
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end, // Align children to the end (right)
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Check if the user is a Purchase Manager or pm_status is 1
                                      if (item['pm_status'] == 1 || PrefUtils.getRole() == "Purchase Manager")
                                        Visibility(
                                          visible: item['dl_status'] == 1, // Show button only if pm_status is 1
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                _showRejectDialog(-1);
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
                                        )
                                      else if (item["uh_status"] == 0) // Display edit and delete buttons if uh_status is 0
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.black),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => BlocProvider(
                                                      create: (context) => AllRequesterBloc(),
                                                      child: EditRequisition(id: item["id"].toString() ?? 'N/A'),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
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
                                      const SizedBox(width: 16), // Optional spacing
                                    ],
                                  )



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
                borderRadius: BorderRadius.circular(32.0),
              ),
              title: Text(
                "Vendor Assign",
                style: FTextStyle.preHeading16BoldStyle,
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.7,
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
                              value: selectedItem,
                              hint: const Text("Select Vendor", style: FTextStyle.formhintTxtStyle),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem = newValue;
                                  _updateButtonState(); // Update button state
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
                        "Select Billing Name",
                        style: FTextStyle.preHeadingStyle,
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
                              value: selectedBilling,
                              hint: const Text("Select Billing Name", style: FTextStyle.formhintTxtStyle),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedBilling = newValue;
                                  _updateButtonState(); // Update button state
                                });
                              },
                              items: listBilling.map<DropdownMenuItem<String>>((dynamic value) {
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
                    color: isButtonPartEnabled ? AppColors.primaryColourDark : AppColors.dividerColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    child: const Text("OK", style: TextStyle(color: Colors.white)),
                    onPressed: isButtonPartEnabled ? () {

                          Navigator.of(context).pop();


                    } : null,
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
              content: Container(
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
                    child:  Text("Reject", style: TextStyle(color:isButtonEnabled ? Colors.white:Colors.white)),
                    onPressed: isButtonEnabled ? () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the reject action here
                        Navigator.of(context).pop();
                      }
                    } : null,
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
              ],
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );
  }





}
