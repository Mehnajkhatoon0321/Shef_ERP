import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/requisition/unit_head/add_requisition.dart';
import 'package:shef_erp/screen/requisition/unit_head/edit_requisition.dart';
import 'package:shef_erp/screen/requisition/unit_head/view_details.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shimmer/shimmer.dart';
class RequisitionScreen extends StatefulWidget {
  const RequisitionScreen({super.key});

  @override
  State<RequisitionScreen> createState() => _RequisitionScreenState();
}

class _RequisitionScreenState extends State<RequisitionScreen> {

  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 5;
  bool hasMoreData = true;
  List<dynamic> data = [];
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
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
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
                        builder: (context) =>  BlocProvider(
  create: (context) => AllRequesterBloc(),
  child: AddRequisition(flag: "",),
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
              children: [
                SizedBox(
                  height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 38,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (selectedIndices.length == data.length) {
                          selectedIndices.clear(); // Deselect all if all are selected
                        } else {
                          selectedIndices = Set.from(List.generate(data.length, (index) => index)); // Select all
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      backgroundColor: Colors.blue, // Change color as needed
                    ),
                    child: Text(
                      selectedIndices.length == data.length ? "Deselect All" : "Select All",
                      style: FTextStyle.emailProfile,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                // Existing Accepted button
                Expanded(
                  child: SizedBox(
                    height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 38,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Accepted button functionality
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
                const SizedBox(width: 10,),
                // Existing Rejected button
                Expanded(
                  child: SizedBox(
                    height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 38,
                    child: ElevatedButton(
                      onPressed: () async {
                        _showEditDialog();
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

                  // Handle case where item might be null
                  if (item == null) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("No data available", style: FTextStyle.listTitle),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDetails(
                        requisition: item["requisitionNo"] ?? "N/A",
                        poNumber: item["poNumber"] ?? "N/A",
                        requestDate: item["req_date"] ?? "N/A",
                        unit: item["unit"] ?? "N/A",
                        product: item["product_name"] ?? "N/A",
                        specification: item["specification"] ?? "N/A",
                        quantity: item["quantity"].toString() ?? "N/A",
                        unitHead: item["unitHead"] ?? "N/A",
                        purchase: item["purchase"] ?? "N/A",
                        delivery: item["dl_status"].toString() ?? "N/A",
                        vender: item["vender"] ?? "N/A",
                        image: item["image"].toString(),

                        // delivery: item["dl_status"].toString(),
                        // image: item["image"].toString(),


                      )));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 5),
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
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ? Colors.white : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: index % 2 == 0 ? AppColors.yellow : AppColors.primaryColourDark,

                                    spreadRadius: 1.5,
                                    blurRadius: 0.4,
                                    offset: const Offset(0, 0.9),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Requisition No: ", style: FTextStyle.listTitle),
                                          Expanded(child: Text("${item["req_no"] ?? 'N/A'}", style: FTextStyle.listTitleSub, maxLines: 1,)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("PO No. : ", style: FTextStyle.listTitle),
                                          Expanded(child: Text("${item["po_no"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Request Date: ", style: FTextStyle.listTitle),
                                          Text("${item["req_date"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Unit: ", style: FTextStyle.listTitle),
                                              Text("${item["unit"] ?? 'N/A'}", style: FTextStyle.listTitleSub,maxLines: 1,),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.black),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(
                                                    create: (context) => AllRequesterBloc(),
                                                    child: EditRequisition(
                                                      id: item["id"] ?? 'N/A',
                                                    ),
                                                  )));
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () {
                                                  CommonPopups.showDeleteCustomPopup(
                                                    context,
                                                    "Are you sure you want to delete?",
                                                        () {
                                                      BlocProvider.of<AllRequesterBloc>(context).add(DeleteHandlers(data[index]['id'] ?? 'N/A'));
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                                        ],
                                      ),
                                      // const SizedBox(height: 5),
                                    ],
                                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                                ],
                              ),
                            ),
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
    });
  }


  void _showEditDialog() {



    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          title: Text(
           "Unit Head Remark",
            style: FTextStyle.preHeadingStyle,
          ),
          content: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _editController,
                  decoration: InputDecoration(
                    hintText:  " Enter Unit Head Remark",
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
                      borderSide: const BorderSide(color: AppColors.primaryColour, width: 1.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
              ],
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
            const SizedBox(width: 10), // Add spacing between buttons
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColour,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextButton(
                child: const Text("OK", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (_editController.text.isNotEmpty) {
                    setState(() {

                        // listData[index]["brand_name"] = _editController.text;

                    });
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Brand name cannot be empty.")),
                    );
                  }
                },
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
            ),
          ],
        ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
      },
    );
  }

}
