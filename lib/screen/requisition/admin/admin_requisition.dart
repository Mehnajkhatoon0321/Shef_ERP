import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
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

String? fileUploadValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please upload a file.';
  }

  final validFileExtensions = ['pdf', 'jpeg', 'jpg', 'png'];
  final fileExtension = value.split('.').last.toLowerCase();

  if (!validFileExtensions.contains(fileExtension)) {
    return 'Invalid file type. Only pdf, jpeg, jpg, and png are allowed.';
  }

  return null; // Return null if validation passes
}

class _AdminRequisitionState extends State<AdminRequisition> {
  int? selectedId;
  int? selectedBillingId;
  int? selectedProductId;
  File? imagesIdCancelled;
  List<String> selectedIds = [];
  Map<String, String>? selectedItemForEditing;
  Map<String, int> productMap = {};
  Map<String, int> billingMap = {};
  late final TextEditingController vendorName = TextEditingController();
  late final TextEditingController billingName = TextEditingController();
  final FocusNode _cancelledFocusNode = FocusNode();
  final FocusNode _remarkFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  String? selectedItem;
  String? selectedBilling;
  bool isButtonPartEnabled = false;
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 20;
  int index=0;
  bool hasMoreData = true;
  List<dynamic> data = [];
  final TextEditingController controller = TextEditingController();
  String? cancelledNameFile;
  final GlobalKey<FormFieldState<String>> _cancelledKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _remarkKey =
      GlobalKey<FormFieldState<String>>();
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
  final TextEditingController editController = TextEditingController();
  String searchQuery = "";
  bool isInitialLoading = false;
  late final TextEditingController cancelledName = TextEditingController();

  // Map<String , dynamic> errorMessage={};
  Map<String, dynamic> errorServerMessage = {};
  String? errorMessage;

  bool isCancelledFieldFocused = false;
  bool isRemarkFieldFocused = false;
  bool isShowMarkEnabled = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        _isTextEmpty = controller.text.isEmpty;
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
  void _refreshVendorList() {
    setState(() {
      pageNo=1;
      BlocProvider.of<AllRequesterBloc>(context)
          .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
    });
  }

  @override
  void dispose() {
    controllerI.removeListener(paginationCall);
    controllerI.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Set<int> selectedIndices = {};
  List<String> productNames = [];
  List<String> billingNames = [];
  final TextEditingController uploadName = TextEditingController();
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return Scaffold(
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


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AllRequesterBloc(),
                          child: AddRequisition(
                            flag: "unit",
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
              isLoading = false;
            });
            errorServerMessage = state.serverFailure;

            print("messageErrorServer$errorServerMessage");
          } else if (state is DeleteLoading) {
            DeletePopupManager.playLoader();
          } else if (state is DeleteSuccess) {
            setState(() {
              data.clear();
              pageNo = 1;
              hasMoreData = true;
              totalPages = 0;

              BlocProvider.of<AllRequesterBloc>(context)
                  .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
            });
            DeletePopupManager.stopLoader();

            var deleteMessage = state.deleteList['message'];

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
                child:
                TextFormField(
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
                  onChanged: _onSearchChanged,
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
                        if (selectedIds.isEmpty) {
                          // Show Snackbar if selectedIds is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No items selected. Please select at least one item.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Proceed to show the reject dialog
                          _showBrandDialog(
                            BlocProvider.of<AllRequesterBloc>(context),
                            context,
                            selectedIds,
                            _refreshVendorList,  // Pass the callback function here
                          );


                        }

                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      child: Text("Approve & Assign Vendor",
                          style: FTextStyle.loginBtnStyle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 38,
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
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          backgroundColor: AppColors.errorColor,
                        ),
                        child: Text("Reject", style: FTextStyle.loginBtnStyle),
                      ),
                    ),
                  )


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
                          :
              ListView.builder(
                              controller: controllerI,
                              itemCount: data.length + 1,
                              itemBuilder: (context, index)
                              {
                                if (index < data.length) {
                                  final item = data[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.01,
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
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: AppColors
                                                      .primaryColourDark,
                                                  spreadRadius: 1.6,
                                                  blurRadius: 0.6,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
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
                                                SizedBox(height: 2,),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                        "Request Date: ",
                                                        style: FTextStyle
                                                            .listTitle),
                                                    Expanded(
                                                        child: Text(
                                                            "${item["req_date"] ?? 'N/A'}",
                                                            style: FTextStyle
                                                                .listTitleSub,
                                                            maxLines: 1)),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                            maxLines: 1)),
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
                                                VendorStatus(
                                                  role: PrefUtils.getRole(),
                                                  deliveryStatus:
                                                      item["dl_status"],
                                                  companyName:
                                                      item['company'] ?? "NA",
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                              item["req_no"] ?? "N/A",
                                                              poNumber: item["po_no"] ?? "N/A",
                                                              requestDate:
                                                              item["req_date"] ?? "N/A",
                                                              unit: item["unit"] ?? "N/A",
                                                              product:
                                                              item["product_name"] ?? "N/A",
                                                              specification:
                                                              item["specification"] ?? "N/A",
                                                              quantity:
                                                              item["quantity"].toString(),
                                                              unitHead:
                                                              item["unitHead"].toString(),
                                                              purchase:
                                                              item["purchase"].toString() ??
                                                                  "N/A",
                                                              delivery:
                                                              item["dl_status"].toString() ??
                                                                  "N/A",
                                                              vender: item["company"] ?? "N/A",
                                                              image: item["image"].toString(),
                                                            ),
                                                          ),
                                                        );

                                                      },
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      children: [

                                                        Column(
                                                          children: [


                                                            if (PrefUtils
                                                                    .getRole() ==
                                                                "Purchase Manager")
                                                              Visibility(
                                                                visible: item[
                                                                        'dl_status'] ==
                                                                    1,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      _showMarkDeliveryDialog(
                                                                          BlocProvider.of<AllRequesterBloc>(context),
                                                                          context,
                                                                          item['id']);
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                26),
                                                                      ),
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .yellow,
                                                                      minimumSize:
                                                                          const Size(
                                                                              80,
                                                                              32),
                                                                    ),
                                                                    child: Text(
                                                                      "Mark Delivery",
                                                                      style: FTextStyle
                                                                          .emailProfile,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        if (item["uh_status"] ==
                                                            0)
                                                          // &&
                                                          // item['pm_status'] ==
                                                          //     0)
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons.delete,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 26),
                                                                onPressed: () {
                                                                  CommonPopups
                                                                      .showDeleteCustomPopup(
                                                                    context,
                                                                    "Are you sure you want to delete?",
                                                                    () {
                                                                      BlocProvider.of<AllRequesterBloc>(
                                                                              context)
                                                                          .add(DeleteHandlers(data[index]['id'] ??
                                                                              'N/A'));
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
                                              ],
                                            ),
                                          ).animateOnPageLoad(animationsMap[
                                              'imageOnPageLoadAnimation2']!),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                if (hasMoreData && index == data.length) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                // If there's no more data to load, show a message
                                else if (data.length > 7 && index == data.length) {
                                  // Show the "No more data." text if we are at the end and there are more than 10 items
                                  return const Center(
                                    child: Text("No more data.", style: FTextStyle.listTitle),
                                  );
                                }
                              },
                            ),
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
      searchQuery = '';
      pageNo=1;
      BlocProvider.of<AllRequesterBloc>(context)
          .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
    });
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





  Future<bool?> _showBrandDialog(
      AllRequesterBloc of, BuildContext context, List<String> selectedIds, Function refreshCallback)
  {
    final formKey = GlobalKey<FormState>();
    String? selectedItem; // Initialize with null
    String? selectedBilling; // Initialize with null
    bool isButtonPartEnabled = false; // Initialize button state

    return showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                void updateButtonState() {
                  setState(() {
                    isButtonPartEnabled = (selectedItem != null && selectedItem!.isNotEmpty) &&
                        (selectedBilling != null && selectedBilling!.isNotEmpty);
                  });
                }

                return BlocProvider.value(
                  value: of, // Use the existing Bloc instance
                  child: AlertDialog(
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
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Vendor selection
                            Text("Select Vendor", style: FTextStyle.preHeadingStyle),
                            // Vendor dropdown
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28.0),
                                  border: Border.all(color: AppColors.boarderColour),
                                  color: AppColors.formFieldBackColour,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                             value:        productNames.contains(selectedItem) ? selectedItem : null,
                                    // value: selectedItem,
                                    hint: const Text("Select Vendor", style: FTextStyle.formhintTxtStyle),
                                    onChanged: (String? eventValue) {
                                      setState(() {
                                        selectedItem = eventValue;
                                        selectedProductId = productMap[eventValue];
                                        updateButtonState();
                                      });
                                    },
                                    items: productNames.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(value: value, child: Text(value));
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            // Billing name selection
                            Text("Select Billing Name", style: FTextStyle.preHeadingStyle),
                            // Billing dropdown
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28.0),
                                  border: Border.all(color: AppColors.boarderColour),
                                  color: AppColors.formFieldBackColour,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value:        billingNames.contains(selectedBilling) ? selectedBilling : null,

                                    hint: const Text("Select Billing Name", style: FTextStyle.formhintTxtStyle),
                                    onChanged: (String? eventValue) {
                                      setState(() {
                                        selectedBilling = eventValue;
                                        selectedBillingId = billingMap[eventValue];
                                        updateButtonState();
                                      });
                                    },
                                    items: billingNames.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(value: value, child: Text(value));
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
                      TextButton(
                        child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).pop(false); // Return false
                        },
                      ),
                      const SizedBox(width: 10),
                      BlocListener<AllRequesterBloc, AllRequesterState>(
                        listener: (context, state) {
                          if (state is VendorAssignLoading) {
                            setState(() {
                              isLoading = true; // Set loading state
                            });
                          } else if (state is VendorAssignSuccess) {
                            setState(() {
                              isLoading = false; // Set loading state
                              selectedIndices.clear();
                              selectedIds.clear();
                              var successMessage = state.vendorList['message'];
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(successMessage),
                                backgroundColor: AppColors.primaryColour,
                              ));
                              refreshCallback(); // Call the refresh callback here
                              Navigator.pop(context);
                            });
                          } else if (state is VendorAssignFailure) {
                            setState(() {
                              isLoading = false; // Reset loading state
                              var errorMessage = state.vendorFailure['message'];
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: AppColors.primaryColour,
                              ));
                            });
                          } else if (state is CheckNetworkConnection) {
                            CommonPopups.showCustomPopup(context, 'Internet is not connected.');
                          }
                        },
                        child: TextButton(
                          onPressed: isButtonPartEnabled
                              ? () {
                            of.add(VendorActionHandler(
                              userID: PrefUtils.getUserId().toString(),
                              btnAssign: 'assign',
                              vendor: selectedProductId.toString() ?? '2',
                              userRole: PrefUtils.getRole(),
                              allCount: selectedIds,
                              billing: selectedBillingId.toString() ?? '2',
                              count: selectedIds.length.toString(),
                            ));
                          }
                              : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                isButtonPartEnabled ? AppColors.primaryColourDark : AppColors.dividerColor),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
                          ),
                          child: const Text("OK", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }





  void _showRejectDialog(
      AllRequesterBloc of, BuildContext context, List<String> selectedIds, Function refreshCallback)
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
                                "Purchase Manager Remark",
                                style: FTextStyle.preHeadingStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: editController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Purchase Manager Remark",
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
                              if (state is VendorAssignLoading) {
                                setState(() {
                                  isLoading = true; // Set loading state
                                });
                              } else if (state is VendorRejectSuccess) {




                                  setState(() {
                                    BlocProvider.of<AllRequesterBloc>(context)
                                        .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
                                    selectedIndices.clear();
                                    selectedIds.clear();


                                    var successMessage = state.vendorList['message'];
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(successMessage),
                                        backgroundColor: AppColors.primaryColour,
                                      ),
                                    );
                                    refreshCallback();
                                 Navigator.pop(context);
                                  });
                                  // BlocProvider.of<AllRequesterBloc>(context)
                                  //     .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));

                                  // Future.delayed(const Duration(milliseconds: 500), () {
                                  //   Navigator.pop(context);
                                  // });

                              } else if (state is VendorAssignFailure) {
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
                                        of.add(VendorRejectHandler(
                                          user_id:
                                              PrefUtils.getUserId().toString(),
                                            btnReject: 'reject',
                                            pmremark:editController.text.toString(),
                                            pmCount: selectedIds,

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

  //markDelivery

  Future<bool?> _showMarkDeliveryDialog(AllRequesterBloc of, BuildContext context, int? index) {
    final formKey = GlobalKey<FormState>();

    bool isShowMarkEnabled = true;
    bool isMarkedLoading = false;
    bool _hasPressedSaveButton = false;

    // New variables for dropdown
    String? selectedStatus;
    final statusOptions = {
      "Delivered": 8,
      "Canceled": 9,
    };

    void _resetForm() {
      uploadName.clear();
      editController.clear();
      cancelledName.clear();
      selectedStatus = null;
      isShowMarkEnabled = true;
      _hasPressedSaveButton = false;
    }

    void updateState() {
      setState(() {
        // Validate fields
        bool isCancelledFieldValid = cancelledName.text.isNotEmpty && fileUploadValidator(cancelledName.text) == null;
        bool isRemarkFieldValid = ValidatorUtils.isValidRemarkName(editController.text);

        // Update button state based on validations
        isShowMarkEnabled = isCancelledFieldValid && isRemarkFieldValid && selectedStatus != null;

        // Validate fields if focused
        if (isCancelledFieldFocused) {
          _cancelledKey.currentState!.validate();
        }
        if (isRemarkFieldFocused) {
          _remarkKey.currentState!.validate();
        }
      });
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        _resetForm();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BlocProvider.value(
              value: of,
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                title: Text("Mark Delivery", style: FTextStyle.preHeading16BoldStyle.copyWith(fontSize: 20)),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    key: formKey,
                    // onChanged: updateState,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dropdown for status selection
                        Text("Status", style: FTextStyle.preHeading16BoldStyle),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.0),
                              border: Border.all(color: AppColors.formFieldHintColour, width: 1),
                              color: Colors.grey[100],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedStatus,
                                hint: const Text("Select Status", style: FTextStyle.formhintTxtStyle),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStatus = newValue;
                                  });
                                //  updateState(); // Update button state on dropdown change
                                },
                                items: statusOptions.keys.map<DropdownMenuItem<String>>((String status) {
                                  return DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(status),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        // if (_hasPressedSaveButton && selectedStatus == null)
                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6),
                        //     child: Text("Please select a status", style: FTextStyle.formErrorTxtStyle),
                        //   ),
                        // Other form fields
                        Text("Upload", style: FTextStyle.formLabelTxtStyle),
                        const SizedBox(height: 10),
                        TextFormField(
                          focusNode: _cancelledFocusNode,
                          key: _cancelledKey,
                          decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Upload Cancelled",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.attach_file),
                              onPressed: () async {
                                final result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'],
                                );
                                if (result != null && result.files.isNotEmpty) {
                                  setState(() {
                                    cancelledNameFile = result.files.single.name;
                                    imagesIdCancelled = File(result.files.single.path!);
                                    cancelledName.text = cancelledNameFile!;
                                  });
                               //   updateState(); // Update button state after selection
                                }
                              },
                            ),
                          ),
                          controller: cancelledName,
                        //  validator: fileUploadValidator,
                          onChanged: (value) {
                            setState(() {
                              isCancelledFieldFocused = true;
                              isRemarkFieldFocused = false;
                            });
                           // updateState(); // Update button state on change
                          },
                        ),
                        const SizedBox(height: 10),
                        Text("Delivery Remark", style: FTextStyle.preHeading16BoldStyle),
                        const SizedBox(height: 10),
                        TextFormField(
                          focusNode: _remarkFocusNode,
                          key: _remarkKey,
                          controller: editController,
                          decoration: FormFieldStyle.defaultInputEditDecoration.copyWith(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Enter Purchase Manager Remark",
                          ),
                          onChanged: (value) {
                            setState(() {
                              isCancelledFieldFocused = false;
                              isRemarkFieldFocused = true;
                            });
                            updateState(); // Update button state on change
                          },
                          //validator: ValidatorUtils.remarkMarkValidator,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColourDark),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  BlocListener<AllRequesterBloc, AllRequesterState>(
                    listener: (context, state) {
                      if (state is MarkDeliveryLoading) {
                        setState(() {
                          isMarkedLoading = true;
                        });
                      } else if (state is MarkDeliverySuccess) {
                        setState(() {
                          isMarkedLoading = false;
                          BlocProvider.of<AllRequesterBloc>(context)
                              .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
                        });

                        var deleteMessage = state.markList['message'];
                        print("ErrorMessage>>>>$deleteMessage");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(deleteMessage),
                            backgroundColor: AppColors.primaryColour,
                          ),
                        );

                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.pop(context);
                        })

                        ;
                      } else if (state is MarkDeliveryFailure) {
                        setState(() {
                          isMarkedLoading = false;
                        });
                        print("error>> ${state.markFailure}");
                        CommonPopups.showCustomPopup(context, state.markFailure.toString());
                      }
                    },
                    child: ElevatedButton(
                      onPressed: isShowMarkEnabled ? () {
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _hasPressedSaveButton = true;
                          });
                          of.add(
                            MarkRequisitionEventHandler(
                              status: selectedStatus != null ? statusOptions[selectedStatus].toString() : '',
                              reqID: index.toString(),
                              remark: editController.text,
                              userid: PrefUtils.getUserId().toString(),
                              Image: imagesIdCancelled,
                            ),
                          );
                        } else {
                          formKey.currentState!.validate(); // Trigger validation errors
                        }
                      } : null, // Disable button if not valid
                      style: ElevatedButton.styleFrom(
                          backgroundColor: isShowMarkEnabled ? AppColors.primaryColourDark : AppColors.formFieldBorderColour),
                      child: isMarkedLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Save", style: FTextStyle.loginBtnStyle.copyWith(color: isShowMarkEnabled ? Colors.white : AppColors.formFieldBorderColour)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



}
