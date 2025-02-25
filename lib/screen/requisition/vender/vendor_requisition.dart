import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/vender/vendor_details.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/colour_status.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shimmer/shimmer.dart';

class VenderRequisition extends StatefulWidget {
  const VenderRequisition({super.key});

  @override
  State<VenderRequisition> createState() => _VenderRequisitionState();
}

class _VenderRequisitionState extends State<VenderRequisition> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  bool isLoading = false;
  String searchQuery = "";
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
  int? selectedId;
  int? selectedBillingId;
  List<String> selectedIds = [];
  Map<String, String>? selectedItemForEditing;
  Map<String, int> productMap = {};
  Map<String, int> billingMap = {};
  late final TextEditingController vendorName = TextEditingController();
  late final TextEditingController billingName = TextEditingController();

  String? selectedItem;
  String? selectedBilling;
  bool isButtonPartEnabled = false;
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;
  bool hasMoreData = true;
  List<dynamic> data = [];

  final controllerI = ScrollController();

  bool isLoadingApprove = false;
  List<dynamic> list = [];
  List<dynamic> billing = [];

  // Map<String , dynamic> errorMessage={};
  Map<String, dynamic> errorServerMessage = {};
  String? errorMessage;
  @override
  void dispose() {
    controllerI.removeListener(paginationCall);
    controllerI.dispose();
    _debounce?.cancel();
    super.dispose();
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

  Set<int> selectedIndices = {};
  List<String> productNames = [];
  List<String> billingNames = [];
  bool isInitialLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          actions: const [],
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
                list = state.addCartDetails['list']['vendors'];
                print("allRequisitionData$responseData");
                productNames = list
                    .map<String>((item) => item['company_name'] as String)
                    .toList();

                productMap = {
                  for (var item in list)
                    item['company_name'] as String: item['id'] as int
                };

                billing = state.addCartDetails['list']['billings'];

                billingNames = billing
                    .map<String>((item) => item['billing_name'] as String)
                    .toList();

                billingMap = {
                  for (var item in billing)
                    item['billing_name'] as String: item['id'] as int
                };

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
                isInitialLoading = false;
              });
              errorServerMessage = state.serverFailure;

              print("messageErrorServer$errorServerMessage");
            } else if (state is DeleteLoading) {
              DeletePopupManager.playLoader();
            } else if (state is DeleteSuccess) {
              DeletePopupManager.stopLoader();

              var deleteMessage = state.deleteList['message'];
              setState(() {
                data.clear();
                pageNo = 1;
                hasMoreData = true;
                totalPages = 0;

                BlocProvider.of<AllRequesterBloc>(context)
                    .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
              });

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
                    onChanged: _onSearchChanged
                  ),
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
                                  itemCount: data.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < data.length) {
                                      final item = data[index];

                                      return GestureDetector(
                                        onTap: () {
                                          // Handle item tap
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.02,
                                              vertical: 0.5),
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              color: index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color:
                                                      AppColors.primaryColourDark,
                                                  spreadRadius: 1.5,
                                                  blurRadius: 0.4,
                                                  offset: Offset(0, 0.9),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    children: [
                                                      const Text(
                                                          "Product/Service: ",
                                                          style: FTextStyle
                                                              .listTitle),
                                                      Expanded(
                                                          child: Text(
                                                              "${item["product"]}",
                                                              style: FTextStyle
                                                                  .listTitleSub)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                          "Specification: ",
                                                          style: FTextStyle
                                                              .listTitle),
                                                      Text(
                                                          "${item["specification"]}",
                                                          style: FTextStyle
                                                              .listTitleSub),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text("Event: ",
                                                              style: FTextStyle
                                                                  .listTitle),
                                                          Text("${item["unit"]}",
                                                              style: FTextStyle
                                                                  .listTitleSub),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text("Quantity: ",
                                                              style: FTextStyle
                                                                  .listTitle),
                                                          Text(
                                                              "${item["quantity"]}",
                                                              style: FTextStyle
                                                                  .listTitleSub),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              "Request Date: ",
                                                              style: FTextStyle
                                                                  .listTitle),
                                                          Text(
                                                              "${item["requestDate"]}",
                                                              style: FTextStyle
                                                                  .listTitleSub),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              "Delivery Status: ",
                                                              style: FTextStyle
                                                                  .listTitle),
                                                          Text(
                                                            "${item["delivery"]}",
                                                            style: item["delivery"] ==
                                                                    'Pending'
                                                                ? FTextStyle
                                                                    .listTitleSubBig
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .red)
                                                                : FTextStyle
                                                                    .listTitleSubBig
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .green),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons
                                                                    .remove_red_eye,
                                                                color:
                                                                    Colors.grey,
                                                                size: 26),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              VendorDetails(
                                                                                requestDate: item["requestDate"],
                                                                                product: item["product"],
                                                                                specification: item["specification"],
                                                                                quantity: item["quantity"],
                                                                                delivery: item["delivery"],
                                                                                image: item["image"],
                                                                              )));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (hasMoreData && index == data.length) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (data.length > 7 &&
                                        index == data.length) {
                                      // Show the "No more data." text if we are at the end and there are more than 10 items
                                      return const Center(
                                        child: Text("No more data.",
                                            style: FTextStyle.listTitle),
                                      );
                                    }
                                    // If there's no more data to load, show a message
                                    // return const Center(
                                    //     child: Text("No more data.",
                                    //         style: FTextStyle.listTitle));
                                  },
                                )),
            ],
          ),
        ),
      ),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["vaddress"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),

                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Company : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["company"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vendor Adreess : ',style: FTextStyle.listTitle,),
                        Expanded(child: Text(item["vaddress"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
                      ],
                    ),

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
                        Expanded(child: Text(item["product_name"] ?? 'N/A',style: FTextStyle.listTitleSub,maxLines: 2,)),
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
}
