import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:shef_erp/utils/director_program.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shef_erp/utils/unit_head_status.dart';
import 'package:shimmer/shimmer.dart';

class RequisitionScreen extends StatefulWidget {
  const RequisitionScreen({super.key});

  @override
  State<RequisitionScreen> createState() => _RequisitionScreenState();
}

class _RequisitionScreenState extends State<RequisitionScreen> {
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;
  bool hasMoreData = true;
  List<dynamic> data = [];
  List<String> selectedIds = [];
  final controller = ScrollController();
  final controllerI = ScrollController();
  TextEditingController _editController = TextEditingController();

  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  bool isLoading = false;
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
  Map<String, dynamic> errorServerMessage = {};
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });

    BlocProvider.of<AllRequesterBloc>(context)
        .add(AddCartDetailHandler("", pageNo, pageSize));
    paginationCall();
  }
  @override
  void dispose() {
    controllerI.removeListener(paginationCall);
    controllerI.dispose();
    _debounce?.cancel();
    super.dispose();
  }
  void paginationCall() {
    controllerI.addListener(() {
      if (controllerI.position.pixels == controllerI.position.maxScrollExtent) {
        if (!isLoading && hasMoreData) {
          pageNo++;

          isInitialLoading = false;
          isLoading = true;

          BlocProvider.of<AllRequesterBloc>(context)
              .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
        }
      }
    });
  }
  Timer? _debounce;
  void _onSearchChanged(String value) {
    setState(() {
      _isTextEmpty = value.isEmpty;
      searchQuery = value;
    });

    // Cancel the previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      pageNo=1;
      // Call the API only after the user has stopped typing for 500 milliseconds
      BlocProvider.of<AllRequesterBloc>(context).add(
          AddCartDetailHandler(searchQuery, pageNo, pageSize));
    });
  }

  void _refreshVendorList() {
    setState(() {
      pageNo=1;
      BlocProvider.of<AllRequesterBloc>(context)
          .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
    });
  }
  Set<int> selectedIndices = {};
  String searchQuery = "";
  bool isInitialLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: AppColors.formFieldBorderColour,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Requisition',
            style: FTextStyle.HeadingTxtWhiteStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.primaryColourDark,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: (displayType == 'desktop' || displayType == 'tablet')
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
                          builder: (context) => BlocProvider(
                            create: (context) => AllRequesterBloc(),
                            child: AddRequisition(
                              flag: "",
                            ),
                          ),
                        ),
                      ).then((result) {
                        // Handle the result from the edit screen
                        if (result[0]) {
                          data.clear();
                          pageNo = 1;
                          hasMoreData = true;
                          totalPages = 0;
                          BlocProvider.of<AllRequesterBloc>(context)
                              .add(AddCartDetailHandler("", pageNo, pageSize));
                        }
                      });

                      // );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        backgroundColor: Colors.white),
                    child: Text(
                      "Add +",
                      style: FTextStyle.loginBtnStyle
                          .copyWith(color: AppColors.primaryColourDark),
                    )),
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
          ), // You can set this to any color you prefer
        ),
        body: BlocListener<AllRequesterBloc, AllRequesterState>(
          listener: (context, state) {
            if (state is AddCartLoading) {
              setState(() {
                isInitialLoading = true;
              });
            } else if (state is AddCartSuccess) {
              setState(() {
                var responseData = state.addCartDetails['list']['requisitions'];
                int totalItemCount = responseData["total"];
                totalPages = (totalItemCount / pageSize).ceil();

                if (pageNo == 1) {
                  data.clear();
                }

                data.addAll(responseData['data']);

                isInitialLoading = false;
                isLoading = false; // Reset loading state

                if (pageNo == totalPages) {
                  hasMoreData = false;
                }
              });


            } else if (state is AddCartFailure) {
              setState(() {
                isInitialLoading = false;
              });
              errorMessage = state.addCartDetailFailure['message'];

              print("messageErrorFailure$errorMessage");
            } else if (state is ServerFailure) {
              setState(() {
                isLoading = false;
              });
              errorServerMessage = state.serverFailure;

              print("messageErrorServer$errorServerMessage");
            }else if (state is DeleteLoading) {
              DeletePopupManager.playLoader();
            }
            else if (state is DeleteSuccess)
            {
              DeletePopupManager.stopLoader();

              var deleteMessage = state.deleteList['message'];
              data.clear();
              pageNo = 1;
              hasMoreData = true;
              totalPages = 0;
              BlocProvider.of<AllRequesterBloc>(context)
                  .add(AddCartDetailHandler("", pageNo, pageSize));
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

          else  if (state is VendorAssignLoading) {
              setState(() {
                isLoading = true; // Set loading state
              });
            }
          else if (state is UnitAssignSuccess) {
              setState(() {
                isLoading = false;
                selectedIndices.clear();
                selectedIds.clear();// Reset loading state
                // Navigator.of(context).pop(); // Close dialog
                var successMessage = state.UnitList['message'];
                data.clear();
                pageNo = 1;
                hasMoreData = true;
                totalPages = 0;

                BlocProvider.of<AllRequesterBloc>(context)
                    .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(successMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
              });
            }
          else if (state is UnitAssignFailure) {
              setState(() {
                isLoading = false; // Reset loading state
                var errorMessage = state.vendorFailure['message'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
              });
              if (kDebugMode) {
                print("error>> ${state.vendorFailure}");
              }
            }
          else if (state is CheckNetworkConnection) {
              CommonPopups.showCustomPopup(
                context,
                'Internet is not connected.',
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 10),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\n')), // Deny new lines
                      LengthLimitingTextInputFormatter(200), // Limit to 250 characters
                    ],
                    decoration: InputDecoration(
                      hintText: 'Search unit',
                      hintStyle: FTextStyle.formhintTxtStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColourDark, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 18.0),
                      suffixIcon: _isTextEmpty
                          ? const Icon(Icons.search,
                              color: AppColors.primaryColourDark)
                          : IconButton(
                              icon: const Icon(Icons.clear,
                                  color: AppColors.primaryColourDark),
                              onPressed: _clearText,
                            ),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    onChanged:_onSearchChanged
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Existing Accepted button
                    Expanded(
                      child: SizedBox(
                        height:
                            (displayType == 'desktop' || displayType == 'tablet')
                                ? 70
                                : 38,
                        child: ElevatedButton(
                          onPressed: () async {

                            if (selectedIds.isEmpty) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No items selected. Please select at least one item.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {

                              BlocProvider.of<AllRequesterBloc>(context).add(UnitActionHandler(
                                userID: PrefUtils.getUserId().toString(),
                                btnAssign: 'approve',
                                userRole: PrefUtils.getRole(),
                                count: selectedIds, // Count of selected IDs
                              ));
                            }





                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          child: Text("Approve", style: FTextStyle.emailProfile),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Existing Rejected button
                    Expanded(
                      child: SizedBox(
                        height:
                            (displayType == 'desktop' || displayType == 'tablet')
                                ? 70
                                : 38,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedIds.isEmpty) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No items selected. Please select at least one item.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              // Proceed to show the reject dialog

                              _showRejectDialog(
                                  BlocProvider.of<AllRequesterBloc>(context),
                                  context,
                                  selectedIds,_refreshVendorList);
                            }


                            // Rejected button functionality
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            backgroundColor: AppColors.errorColor,
                          ),
                          child: Text("Reject", style: FTextStyle.emailProfile),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isInitialLoading && data.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          itemCount: 10, // Number of shimmer placeholders
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03, vertical: 5),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 10, color: Colors.grey),
                                          const SizedBox(height: 5),
                                          Container(
                                              height: 10, color: Colors.grey),
                                          const SizedBox(height: 5),
                                          Container(
                                              height: 10, color: Colors.grey),
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
                    : (errorMessage != null || errorServerMessage.isNotEmpty)
                        ? Center(
                            child: Text(
                              errorMessage ?? errorServerMessage.toString(),
                              style: FTextStyle.listTitle,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : (data.isEmpty)
                            ? const Center(
                                child: Text("No data available.",
                                    style: FTextStyle.listTitle),
                              )
                            : ListView.builder(
                                controller: controllerI,
                                itemCount: data.length +1,
                                // Add one for the loading indicator
                                itemBuilder: (context, index) {
                                  if (index < data.length) {
                                    final item = data[index];

                                    // Handle case where item might be null
                                    if (item == null) {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10.0),
                                        child: Text("No data available",
                                            style: FTextStyle.listTitle),
                                      );
                                    }

                                    return GestureDetector(
                                      onTap: () {

                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.03,
                                            vertical: 5),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.h),
                                              child: Transform.scale(
                                                scale: 1.2,
                                                child: Checkbox(
                                                  value: selectedIndices
                                                      .contains(index),
                                                  activeColor:
                                                  AppColors.primaryColourDark,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      if (value == true) {
                                                        selectedIndices
                                                            .add(index);
                                                        selectedIds.add(item['id']
                                                            .toString()); // Add ID when checked
                                                      } else {
                                                        selectedIndices
                                                            .remove(index);
                                                        selectedIds.remove(item[
                                                        'id']
                                                            .toString()); // Remove ID when unchecked
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding: const EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  color: index % 2 == 0
                                                      ? Colors.white
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors
                                                          .primaryColourDark,
                                                      spreadRadius: 1.5,
                                                      blurRadius: 0.4,
                                                      offset:
                                                          const Offset(0, 0.9),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text("Requisition No. : ", style: FTextStyle.listTitle),
                                                            Expanded(
                                                              child: GestureDetector(
                                                                onTap: () => _showRequisitionDetails(context,item),
                                                                child: Text(
                                                                  "${item["req_no"] ?? 'N/A'}",
                                                                  style: FTextStyle.listTitleSub.copyWith(color: Colors.blue),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis, // Handle overflow
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),


                                                        SizedBox(height: 2,),
                                                        Row(
                                                          children: [
                                                            const Text("PO No.: ", style: FTextStyle.listTitle),
                                                            Expanded(
                                                              child: GestureDetector(
                                                                onTap: () => _showPODetails(context,item),
                                                                child: Text(
                                                                  "${item["po_no"] ?? 'N/A'}",
                                                                  style: FTextStyle.listTitleSub.copyWith(color: Colors.blue),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis, // Handle overflow
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),



                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                "Request Date: ",
                                                                style: FTextStyle
                                                                    .listTitle),
                                                            Text(
                                                              "${item["req_date"] ?? 'N/A'}",
                                                              style: FTextStyle
                                                                  .listTitleSub,
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text("Unit: ",
                                                                style: FTextStyle
                                                                    .listTitle),
                                                            Expanded(
                                                                child: Text(
                                                              "${item["unit"] ?? 'N/A'}",
                                                              style: FTextStyle
                                                                  .listTitleSub,
                                                              maxLines: 1,
                                                            )),
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: DeliveryStatus(
                                                                    dlStatus: item[
                                                                            "dl_status"]
                                                                        .toString())),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: UnitHeadStatus(
                                                                    unitStatus: item[
                                                                            "uh_status"]
                                                                        .toString())),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: PurchaseManager(
                                                                    pmStatus: item[
                                                                            "pm_status"]
                                                                        .toString())),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: ProgramDirector(
                                                                    pdStatus: item[
                                                                    "pd_status"]
                                                                        .toString())),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons.remove_red_eye,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 26),
                                                                  onPressed: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ViewDetails(
                                                                              requisition:
                                                                              item["requisitionNo"] ??
                                                                                  "N/A",
                                                                              poNumber:
                                                                              item["poNumber"] ??
                                                                                  "N/A",
                                                                              requestDate:
                                                                              item["req_date"] ??
                                                                                  "N/A",
                                                                              unit: item["unit"] ?? "N/A",
                                                                              product:
                                                                              item["product_name"] ??
                                                                                  "N/A",
                                                                              specification:
                                                                              item["specification"] ??
                                                                                  "N/A",
                                                                              quantity: item["quantity"]
                                                                                  .toString() ??
                                                                                  "N/A",
                                                                              unitHead:
                                                                              item["unitHead"] ??
                                                                                  "N/A",
                                                                              purchase:
                                                                              item["purchase"] ??
                                                                                  "N/A",
                                                                              delivery: item["dl_status"]
                                                                                  .toString() ??
                                                                                  "N/A",
                                                                              vender:
                                                                              item["company"] ?? "N/A",
                                                                              image: item["image"]
                                                                                  .toString(),

                                                                              // delivery: item["dl_status"].toString(),
                                                                              // image: item["image"].toString(),
                                                                            )));

                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            if (item["uh_status"] ==
                                                                0)
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                // IconButton(
                                                                //   icon: const Icon(Icons.edit, color: Colors.black),
                                                                //   onPressed: () {
                                                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(
                                                                //       create: (context) => AllRequesterBloc(),
                                                                //       child: EditRequisition(
                                                                //         id: item["id"].toString()?? 'N/A',
                                                                //       ),
                                                                //     )));
                                                                //   },
                                                                // ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons.delete,
                                                                      color:
                                                                          Colors.red),
                                                                  onPressed: () {
                                                                    CommonPopups
                                                                        .showDeleteCustomPopup(
                                                                      context,
                                                                      "Are you sure you want to delete?",
                                                                      () {
                                                                        BlocProvider.of<
                                                                                    AllRequesterBloc>(
                                                                                context)
                                                                            .add(DeleteHandlers(data[index]
                                                                                    [
                                                                                    'id'] ??
                                                                                'N/A'));
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ).animateOnPageLoad(
                                                                animationsMap[
                                                                    'imageOnPageLoadAnimation2']!),
                                                          ],
                                                        ),
                                                        // const SizedBox(height: 5),
                                                      ],
                                                    ).animateOnPageLoad(animationsMap[
                                                        'imageOnPageLoadAnimation2']!),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  if (hasMoreData && index == data.length) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  else if (data.length > 7 && index == data.length) {
                                    // Show the "No more data." text if we are at the end and there are more than 10 items
                                    return const Center(
                                      child: Text("No more data.", style: FTextStyle.listTitle),
                                    );
                                  }

                                  // If there's no more data to load, show a message
                                  // return const Center(
                                  //     child: Text("No more data.",
                                  //         style: FTextStyle.listTitle));
                                },
                              ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _clearText() {
    _controller.clear();
    setState(() {
      _isTextEmpty = true;
      searchQuery = '';
      pageNo=1;
      BlocProvider.of<AllRequesterBloc>(context)
          .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
    });
  }

  void _showRejectDialog(
      AllRequesterBloc of, BuildContext context, List<String> selectedIds,Function refreshCallback)
  {
    final formKey = GlobalKey<FormState>();
    final TextEditingController editController = TextEditingController();
    bool isButtonEnabled = false; // Initialize button state

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Add listener to the TextEditingController to monitor text changes
            editController.addListener(() {
              setState(() {
                isButtonEnabled = editController.text.isNotEmpty;
              });
            });

            return BlocProvider.value(
                value: of, // Use the existing Bloc instance
                child: AlertDialog(
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
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Unit Head Remark",
                            style: FTextStyle.preHeadingStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: editController,
                              decoration: InputDecoration(
                                hintText: "Enter Unit Head Remark",
                                hintStyle: FTextStyle.formhintTxtStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: const BorderSide(
                                      color: AppColors.formFieldHintColour,
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: const BorderSide(
                                      color: AppColors.formFieldHintColour,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColourDark,
                                      width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 18.0),
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
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation2']!),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: isButtonEnabled
                            ? AppColors.primaryColourDark
                            : AppColors.formFieldBorderColour,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child:
                      BlocListener<AllRequesterBloc, AllRequesterState>(
                        listener: (context, state) {
                          if (state is UnitRejectLoading) {
                            setState(() {
                              isLoading = true; // Set loading state
                            });
                          } else if (state is UnitRejectSuccess) {




                            setState(() {


                              BlocProvider.of<AllRequesterBloc>(context)
                                  .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));


                              selectedIndices.clear();
                              selectedIds.clear();
                              var successMessage = state.unitList['message'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(successMessage),
                                  backgroundColor: AppColors.primaryColour,
                                ),
                              );

                              refreshCallback();
                              Navigator.pop(context);
                            });


                          } else if (state is UnitRejectFailure) {
                            setState(() {
                              isLoading = false; // Reset loading state
                              var errorMessage =
                              state.vendorFailure['message'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor: AppColors.primaryColour,
                                ),
                              );
                            });
                            if (kDebugMode) {
                              print("error>> ${state.vendorFailure}");
                            }
                          } else if (state is CheckNetworkConnection) {
                            CommonPopups.showCustomPopup(
                              context,
                              'Internet is not connected.',
                            );
                          }
                        },
                        child: TextButton(
                          onPressed: isButtonEnabled
                              ? () {
                            if (formKey.currentState?.validate() ??
                                false) {
                              of.add(UnitRejectHandler(
                                user_id:
                                PrefUtils.getUserId().toString(),
                                btnReject: 'reject',
                                pmremark:editController.text.toString(),
                                unitCount: selectedIds,

                              ));

                            }
                          }
                              : null,
                          child:

                          isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              :  Text("Reject",
                              style: TextStyle(
                                  color: isButtonEnabled
                                      ? Colors.white
                                      : Colors.white)),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation2']!),
                    ),
                  ],
                ))
                .animateOnPageLoad(
                animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );
  }

  void _showPODetails(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PO Details", style: FTextStyle.preHeadingStyle),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Container(
            width:MediaQuery.of(context).size.width *0.9,// Set your desired width here
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 200.0, // Adjust as necessary
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Divider(height: 10, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unit Name : ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["unit"] ?? 'N/A', style: FTextStyle.listTitleSub)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address : ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["vaddress"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PO Number : ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["po_no"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Requisition No : ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["req_no"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Request Date : ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["req_date"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    DeliveryStatus(dlStatus: item["dl_status"]?.toString() ?? 'N/A'),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product/Service: ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["product"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity: ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["quantity"].toString() ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 1)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Specification: ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["specification"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Remarks: ', style: FTextStyle.listTitle),
                        Expanded(child: Text(item["staff_remarks"] ?? 'N/A', style: FTextStyle.listTitleSub, maxLines: 2)),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showRequisitionDetails(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Requisition Details", style: FTextStyle.preHeadingStyle),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width:MediaQuery.of(context).size.width *0.9,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 200.0, // Adjust as necessary
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Divider(height: 10, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Requisition No : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["req_no"] ?? 'N/A',style: FTextStyle.listTitleSub,)),
                      ],
                    ), Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unit Name : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["unit"] ?? 'N/A',style: FTextStyle.listTitleSub,)),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Address : ',style: FTextStyle.listTitle,),
                    //     Expanded(child: Text(item["vaddress"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                    //   ],
                    // ),

                    const Divider(color: Colors.grey),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Requisition No : ',style: FTextStyle.listTitle,),
                    //     Expanded(child: Text(item["requisitionNo"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Billing Name : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["requisitionNo"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Billing Number : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["bill_no"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Request Date : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["req_date"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),
                    // DeliveryStatus(dlStatus: item["dl_status"]?.toString() ?? 'N/A'),



                    const Divider(color: Colors.grey),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product/Service: ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["product"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity: ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["quantity"].toString() ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 1,)),
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Specification: ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["specification"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Remarks: ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["staff_remarks"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),



                    const Divider(color: Colors.grey),

                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
