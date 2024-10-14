import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/product_service_edit.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shimmer/shimmer.dart';

class ProductService extends StatefulWidget {
  const ProductService({super.key});

  @override
  State<ProductService> createState() => _ProductServiceState();
}

class _ProductServiceState extends State<ProductService> {
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;
  bool hasMoreData = true;
  List<dynamic> data = [

  ];
  String searchQuery = "";
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;
  bool isInitialLoading = false;

  TextEditingController _editController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  Map<String, dynamic> errorServerMessage = {};
  String? errorMessage;

  @override
  void dispose() {
    controllerI.removeListener(paginationCall);
    controllerI.dispose();
    super.dispose();
  }

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
  Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });

    _editController = TextEditingController();
    BlocProvider.of<AllRequesterBloc>(context)
        .add(MasterServiceHandler("", pageNo, pageSize));
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
              .add(MasterServiceHandler("", pageNo, pageSize));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType
        .toString()
        .split('.')
        .last;
    return Scaffold(
      backgroundColor: AppColors.formFieldBorderColour,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Services',
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
                          builder: (context) =>
                              BlocProvider(
                                create: (context) => AllRequesterBloc(),
                                child: ProductServiceEdit(
                                  screenflag: "",
                                  id: PrefUtils.getUserId().toString(),
                                ),
                              )),
                    );
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
          if (state is ServiceLoading) {
            setState(() {
              isInitialLoading = true;
            });
          } else if (state is ServiceSuccess) {
            setState(() {
              var responseData = state.serviceList['list'];
              print(">>>>>>>>>>>ALLDATA$responseData");
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
          } else if (state is ServiceCategoryFailure) {
            setState(() {
              isInitialLoading = false;
            });
            errorMessage = state.serviceCategoryFailure['message'];

            print("messageErrorFailure$errorMessage");

          } else if (state is ServerFailure) {
            setState(() {
              isLoading = false;
            });
            errorServerMessage = state.serverFailure;

            print("messageErrorServer$errorServerMessage");
          }
          //Delete Services
          else if (state is DeleteServiceLoading) {
            DeletePopupManager.playLoader();
          } else if (state is DeleteServiceSuccess) {
            DeletePopupManager.stopLoader();

            var deleteMessage = state.deleteServiceList['message'];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(deleteMessage),
                backgroundColor: AppColors.primaryColour,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          } else if (state is DeleteEventServiceFailure) {
            DeletePopupManager.stopLoader();

            var deleteMessage = state.deleteEventServiceFailure['message'];
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

          // TODO: implement listener
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
                    hintText: 'Search ',
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
                          MasterServiceHandler(
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
              ):
              ListView.builder(

                controller: controllerI,
                itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index < data.length) {
                      final item = data[index];
                      return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03,
                                vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Colors.white
                                          : Colors.white,
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
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Sr. No: ",
                                                style:
                                                FTextStyle.listTitle),
                                            Text("${index + 1}",
                                                style: FTextStyle
                                                    .listTitleSub),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            const Text("Category: ",
                                                style:
                                                FTextStyle.listTitle),
                                            Expanded(
                                                child: Text(
                                                    "${item["cate_name"]}",
                                                    style: FTextStyle
                                                        .listTitleSub)),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            const Text("Name: ",
                                                style:
                                                FTextStyle.listTitle),
                                            Text("${item["name"]}",
                                                style: FTextStyle
                                                    .listTitleSub),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Specification: ",
                                                style:
                                                FTextStyle.listTitle),
                                            Text(
                                                "${item["specification"]}",
                                                style: FTextStyle
                                                    .listTitleSub),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Status: ",
                                                style:
                                                FTextStyle.listTitle),
                                            GestureDetector(
                                              onTap: () {
                                                _showStatusDialog(
                                                  BlocProvider.of<
                                                      AllRequesterBloc>(
                                                      context),
                                                  context,
                                                  item,
                                                  item["id"]
                                                      .toString(), // Pass the id here
                                                );
                                              },
                                              child: Text(
                                                item["status"] == 0
                                                    ? "Active"
                                                    : item["status"] == 4
                                                    ? "Inactive"
                                                    : "${item["status"]}",
                                                style: (item["status"] == 0
                                                    ? FTextStyle.listTitleSub
                                                    .copyWith(
                                                    color: Colors.green)
                                                    : item["status"] == 4
                                                    ? FTextStyle.listTitleSub
                                                    .copyWith(color: Colors.red)
                                                    : FTextStyle.listTitleSub),
                                              ),
                                            ),

                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.black),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                AllRequesterBloc(),
                                                            child:
                                                            ProductServiceEdit(
                                                              screenflag:
                                                              "Edit",
                                                              id: item["id"]
                                                                  .toString(),
                                                            ),
                                                          )),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () =>
                                              {
                                                CommonPopups
                                                    .showDeleteCustomPopup(
                                                  context,
                                                  "Are you sure you want to delete?",
                                                      () {
                                                    BlocProvider.of<
                                                        AllRequesterBloc>(
                                                        context)
                                                        .add(
                                                        DeleteMasterServiceHandlers(
                                                            data[index]
                                                            ['id']));
                                                  },
                                                )
                                              },
                                            ),
                                          ],
                                        ).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation2']!),
                                        // const SizedBox(height: 5),

                                        // const SizedBox(height: 5),
                                      ],
                                    ).animateOnPageLoad(animationsMap[
                                    'imageOnPageLoadAnimation2']!),
                                  ),
                                ),
                              ],
                            ),
                          ));
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
      BlocProvider.of<AllRequesterBloc>(context).add(
          MasterServiceHandler(
              "", pageNo, pageSize));
    });
  }

  Future<void> _showStatusDialog(AllRequesterBloc of,
      BuildContext context,
      Map<String, dynamic> item,
      String id // New parameter for id
      ) {
    String? selectedStatus = item["status"] == 0
        ? "Active"
        : "Inactive"; // Default value
    bool isLoading = false; // Start with not loading

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: of, // Use the existing Bloc instance
          child: AlertDialog(
            title: const Text('Change Status'),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedStatus,
                  items: [
                    _buildDropdownItem("Active"),
                    _buildDropdownItem("Inactive"),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedStatus = newValue;
                    }
                  },
                  isExpanded: true,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            actions: [
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryColourDark,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextButton(
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ).animateOnPageLoad(
                    animationsMap['imageOnPageLoadAnimation2']!),
              ),
              BlocListener<AllRequesterBloc, AllRequesterState>(
                listener: (context, state) {
                  if (state is StatusChangeLoading) {
                    setState(() {
                      isLoading = true; // Set loading state
                    });
                  } else if (state is StatusChangeSuccess) {
                    setState(() {
                      isLoading = false; // Reset loading state
                      Navigator.of(context).pop(); // Close dialog
                      var successMessage = state.statusChangeList['message'];
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(successMessage),
                          backgroundColor: AppColors.primaryColour,
                        ),
                      );
                    });
                  } else if (state is StatusChangeFailure) {
                    setState(() {
                      isLoading = false; // Reset loading state
                      var errorMessage = state.statusChangeFailure['message'];
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: AppColors.primaryColour,
                        ),
                      );
                    });
                    if (kDebugMode) {
                      print("error>> ${state.statusChangeFailure}");
                    }
                  } else if (state is CheckNetworkConnection) {
                    CommonPopups.showCustomPopup(
                      context,
                      'Internet is not connected.',
                    );
                  }
                },
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColourDark,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text("OK", style: TextStyle(color: Colors
                        .white)),
                    onPressed: () {
                      if (!isLoading) { // Prevent multiple presses
                        String newStatus = selectedStatus == "Active"
                            ? '0'
                            : '4'; // Convert to String

                        // Update the item's status here based on the selected value
                        of.add(ProductStatusChangeHandler(
                          userID: PrefUtils.getUserId().toString(),
                          status: newStatus, // Pass the status as a String
                          id: id, // Pass the id here
                        ));
                      }
                    },
                  ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Helper method to create a dropdown item with padding
  DropdownMenuItem<String> _buildDropdownItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(value),
      ),
    );
  }
}