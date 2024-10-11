import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/requester/detailsRequisition.dart';
import 'package:shef_erp/screen/requisition/unit_head/add_requisition.dart';
import 'package:shef_erp/utils/asign_vector.dart';
import 'package:shef_erp/utils/colour_status.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/deletePopupManager.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/unit_head_status.dart';

import 'package:shimmer/shimmer.dart';

class RequisitionRequester extends StatefulWidget {
  const RequisitionRequester({super.key});

  @override
  State<RequisitionRequester> createState() => _RequisitionRequesterState();
}

class _RequisitionRequesterState extends State<RequisitionRequester> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 5;
  bool hasMoreData = true;
  List<dynamic> data = [];
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;
  String searchQuery = "";

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
        if (pageNo < totalPages && !isLoading) {
          if (hasMoreData) {
            pageNo++;
            BlocProvider.of<AllRequesterBloc>(context)
                .add(AddCartDetailHandler("", pageNo, pageSize));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
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
                              flag: "Requester",
                            ),
                          ),
                        ),
                      );

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
                child: isLoading && data.isEmpty
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
                    : data.isEmpty
                        ? Center(
                            child: isLoading
                                ? const CircularProgressIndicator() // Show circular progress indicator
                                : const Text("No more data .",
                                    style: FTextStyle.listTitle),
                          )
                        : ListView.builder(
                            controller: controllerI,
                            itemCount: data.length + (hasMoreData ? 1 : 0),
                            // Add one for the loading indicator
                            itemBuilder: (context, index) {
                              if (index < data.length) {
                                final item = data[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RequesterDetails(
                                          requestDate:
                                              item["req_date"].toString(),
                                          unit: item["unit"].toString(),
                                          product:
                                              item["product_name"].toString(),
                                          specification:
                                              item["specification"].toString(),
                                          quantity: item["quantity"].toString(),
                                          delivery:
                                              item["dl_status"].toString(),
                                          image: item["image"].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                        vertical: 5),
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? Colors.white
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:  AppColors.primaryColourDark,
                                            spreadRadius: 1.5,
                                            blurRadius: 0.4,
                                            offset: const Offset(0, 0.9),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Requisition No: ",
                                                  style: FTextStyle.listTitle),
                                              Expanded(
                                                  child: Text(
                                                      "${item["req_no"]}",
                                                      style: FTextStyle
                                                          .listTitleSub)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("PO No: ",
                                                  style: FTextStyle.listTitle),
                                              Expanded(
                                                  child: Text(
                                                      "${item["po_no"]}",
                                                      style: FTextStyle
                                                          .listTitleSub)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Product/Service: ",
                                                  style: FTextStyle.listTitle),
                                              Expanded(
                                                  child: Text(
                                                      "${item["product_name"]}",
                                                      style: FTextStyle
                                                          .listTitleSub)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: DeliveryStatus(
                                                      dlStatus:
                                                          item["dl_status"]
                                                              .toString())),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: UnitHeadStatus(
                                                      unitStatus:
                                                          item["uh_status"]
                                                              .toString())),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: PurchaseManager(
                                                      pmStatus:
                                                          item["pm_status"]
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
                                                          "${item["req_date"]}",
                                                          style: FTextStyle
                                                              .listTitleSub),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Visibility(
                                                visible: (item['roles'] ==
                                                        'Requester' &&
                                                    item["uh_status"] == 0),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red),
                                                      onPressed: () {
                                                        CommonPopups
                                                            .showDeleteCustomPopup(
                                                          context,
                                                          "Are you sure you want to delete?",
                                                          () {
                                                            BlocProvider.of<
                                                                        AllRequesterBloc>(
                                                                    context)
                                                                .add(DeleteHandlers(
                                                                    data[index][
                                                                        'id']));
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                // This is the loading indicator
                                return Center(
                                  child: isLoading
                                      ? const CircularProgressIndicator() // Show circular progress indicator
                                      : const Text("No more data.",
                                          style: FTextStyle.listTitle),
                                );
                              }
                            },
                          ),
              ),
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
      BlocProvider.of<AllRequesterBloc>(context)
          .add(AddCartDetailHandler("", pageNo, pageSize));
    });
  }
}
