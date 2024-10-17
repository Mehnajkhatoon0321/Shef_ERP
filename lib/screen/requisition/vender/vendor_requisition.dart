import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/vender/vendor_details.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
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
          } else if (state is RejectLoading) {
            setState(() {
              isLoadingApprove = true;
            });
          } else if (state is RejectSuccess) {

            isLoadingApprove = false;
            setState(() {
              Navigator.of(context).pop();
            });
          } else if (state is RejectFailure) {
            setState(() {
              isLoading = false;
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
                  decoration: InputDecoration(
                    hintText: 'Search Requisition',
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
                  onChanged: (value) {
                    setState(() {
                      _isTextEmpty = value.isEmpty;
                      searchQuery = value;
                      BlocProvider.of<AllRequesterBloc>(context).add(
                          AddCartDetailHandler(
                              searchQuery, pageNo, pageSize));
                    });
                  },
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
                                child: Text("No more data.",
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VendorDetails(
                                                      requestDate:
                                                          item["requestDate"],
                                                      product: item["product"],
                                                      specification:
                                                          item["specification"],
                                                      quantity:
                                                          item["quantity"],
                                                      delivery:
                                                          item["delivery"],
                                                      image: item["image"],
                                                    )));
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
                                  }

                                  // If there's no more data to load, show a message
                                  return const Center(
                                      child: Text("No more data.",
                                          style: FTextStyle.listTitle));
                                },
                              )),
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
      BlocProvider.of<AllRequesterBloc>(context)
          .add(AddCartDetailHandler(searchQuery, pageNo, pageSize));
    });
  }
}
