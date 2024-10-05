import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/vendor_edit.dart';
import 'package:shef_erp/screen/master/master_list/vendor_view.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shimmer/shimmer.dart';
class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {

  TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;

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

  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 5;
  bool hasMoreData = true;
  List<dynamic> data = [


  ];
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;
  bool isLoadingEdit = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        .add(GetUserListHandler("", pageNo, pageSize));
    paginationCall();
  }

  void paginationCall() {
    controllerI.addListener(() {
      if (controllerI.position.pixels == controllerI.position.maxScrollExtent) {
        if (pageNo < totalPages && !isLoading) {
          if (hasMoreData) {
            pageNo++;
            BlocProvider.of<AllRequesterBloc>(context)
                .add(GetUserListHandler("", pageNo, pageSize));
          }
        }
      }
    });
  }
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
          'Vendor',
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColourDark,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 43,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  BlocProvider(
                      create: (context) => AllRequesterBloc(),
                      child:  VendorEdit(

                        screenFlag:"",
                        id:"",
                      ),
                    )),
                  )

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "Add +",
                  style: FTextStyle.loginBtnStyle.copyWith(color: AppColors.primaryColourDark),
                ),
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: BlocListener<AllRequesterBloc, AllRequesterState>(
        listener: (context, state) {
          if (state is VendorListLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is VendorListSuccess) {
            setState(() {
              var responseData = state.eventList['list'];




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
          } else if (state is VendorListFailure) {
            setState(() {
              isLoading = false;
            });
            print("error>> ${state.eventFailure}");
            var serverFail = state.eventFailure['message'];
            print(">>>>>>>>>>>ALLDATADelete$serverFail");
            BlocProvider.of<AllRequesterBloc>(context)
                .add(GetUnitHandler("", pageNo, pageSize));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(serverFail),
                backgroundColor: AppColors.primaryColour,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          }
          else if (state is GetUserListFailure) {
            setState(() {
              isLoading = false;
            });
            var serverFail = state.failureMessage;
            print(">>>>>>>>>>>ALLDATADelete$serverFail");
            BlocProvider.of<AllRequesterBloc>(context)
                .add(GetUnitHandler("", pageNo, pageSize));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(serverFail),
                backgroundColor: AppColors.primaryColour,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          }




          else if (state is UserDeleteLoading) {
            DeletePopupManager.playLoader();
          } else if (state is VendorDeleteSuccess) {
            DeletePopupManager.stopLoader();

            var deleteMessage = state.deleteEventList['message'];
            print(">>>>>>>>>>>ALLDATADelete$deleteMessage");
            BlocProvider.of<AllRequesterBloc>(context)
                .add(GetUnitHandler("", pageNo, pageSize));
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
          else if (state is VendorDeleteFailure) {

            var deleteMessage = state.deleteEventFailure['message'];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(deleteMessage),
                backgroundColor: AppColors.primaryColour,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
            setState(() {
              isLoading = false;
            });
            print("error>> ${state.deleteEventFailure}");
          }



          // TODO: implement listener
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
                    hintText: 'Search',
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
                  :  ListView.builder(
                controller: controllerI,
                itemCount: data.length + (hasMoreData ? 1 : 0),
                // Add one for the loading indicator
                itemBuilder: (context, index) {
                  if (index < data.length) {
                    final item = data[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle tap event if needed
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: index % 2 == 0 ? Colors.white : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.primaryColourDark,

                                      spreadRadius: 1.5,
                                      blurRadius: 0.4,
                                      offset: Offset(0, 0.9),
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
                                            const Text("ID: ", style: FTextStyle.listTitle),
                                            Text("${index + 1}", style: FTextStyle.listTitleSub),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Name: ", style: FTextStyle.listTitle),
                                            Expanded(child: Text("${item["name"]}", style: FTextStyle.listTitleSub,maxLines: 1,)),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Email: ", style: FTextStyle.listTitle),
                                            Expanded(child: Text("${item["email"]}", style: FTextStyle.listTitleSub,maxLines: 2,)),
                                          ],
                                        ),



                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Contact No. : ", style: FTextStyle.listTitle),
                                            Expanded(
                                              child: Text(
                                                  "${item["contact"]}",
                                                style: FTextStyle.listTitleSub,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Address : ", style: FTextStyle.listTitle),
                                            Expanded(
                                              child: Text(
                                                "${item["address"]}",
                                                style: FTextStyle.listTitleSub,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove_red_eye, color: Colors.black),
                                              onPressed: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) =>  BlocProvider(
                                                    create: (context) => AllRequesterBloc(),
                                                    child:  VendorView(
                                                      id:item["id"].toString(),

                                                    ),
                                                  )),
                                                )
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.black),
                                              onPressed: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) =>  BlocProvider(
                                                    create: (context) => AllRequesterBloc(),
                                                    child:  VendorEdit(
                                                      screenFlag:"Edit",
                                                      id:item["id"].toString(),

                                                    ),
                                                  )),
                                                )
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () => {
                                                CommonPopups
                                                    .showDeleteCustomPopup(
                                                  context,
                                                  "Are you sure you want to delete?",
                                                      () {
                                                    BlocProvider.of<
                                                        AllRequesterBloc>(
                                                        context)
                                                        .add(DeleteUserIDHandlers(
                                                        data[index][
                                                        'id']));
                                                  },
                                                )
                                              },
                                            ),
                                          ],
                                        ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
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

}
