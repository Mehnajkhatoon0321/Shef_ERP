import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/screen/master/master_list/user_edits.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shimmer/shimmer.dart';
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  Map<String, dynamic> errorServerMessage = {};
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
  int pageSize = 20;
  bool hasMoreData = true;
  List<dynamic> data = [


  ];
  final controller = ScrollController();

  bool isLoading = false;
  bool isInitialLoading = false;
  bool isLoadingEdit = false;
  String searchQuery = "";
  @override
  void dispose() {
    _controller.dispose();
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
          GetUserListHandler(searchQuery, pageNo, pageSize));
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
        .add(GetUserListHandler("", pageNo, pageSize));
    paginationCall();
  }

  void paginationCall() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (!isLoading && hasMoreData) {
          pageNo++;

          isInitialLoading = false;

          BlocProvider.of<AllRequesterBloc>(context)
              .add(GetUserListHandler(searchQuery, pageNo, pageSize));
        }
      }
    });
  }
  String? errorMessage;
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
            'User',
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  BlocProvider(
                    //     create: (context) => AllRequesterBloc(),
                    //     child:  UserEdits(
                    //
                    //       screenflag:"",
                    //       id:PrefUtils.getUserId().toString(),
                    //     ),
                    //   )),
                    // ).then((result) {
                    //   // Handle the result from the edit screen
                    //   if (result[0]) {
                    //     pageNo=1;
                    //     BlocProvider.of<AllRequesterBloc>(context)
                    //         .add(GetUserListHandler("", pageNo, pageSize));
                    //   }
                    // })

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  BlocProvider(
                        create: (context) => AllRequesterBloc(),
                        child:  UserEdits(

                          screenflag:"",
                          id:PrefUtils.getUserId().toString(),
                        ),
                      )),
                    ).then((result) {
                      // Handle the result from the edit screen
                      if (result[0]) {

                        data.clear();
                        pageNo = 1;
                        hasMoreData = true;
                        totalPages = 0;
                        BlocProvider.of<AllRequesterBloc>(context)
                            .add(GetUserListHandler("", pageNo, pageSize));
                      }
                    })



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
            if (state is UnitLoading) {
              setState(() {
                isInitialLoading = true;
              });
            } else if (state is GetUserListSuccess) {
              setState(() {
                var responseData = state.userResponse['list'];




                print(">>>>>>>>>>>ALLDATA$responseData");
                int totalItemCount = responseData["total"];
                totalPages = (totalItemCount / pageSize).ceil();

                if (pageNo == 1) {
                  data.clear();
                }

                data.addAll(responseData['data']);

                isInitialLoading = false;
                isLoading = false; // Reset loading state

                if (pageNo==totalPages) {
                  hasMoreData = false;
                }
              });
            } else if (state is GetUserListFailure) {
              setState(() {
                isInitialLoading = false;
              });
              errorMessage = state.failureMessage.toString();
            }  else if (state is UserDeleteLoading) {
              setState(() {
                DeletePopupManager.playLoader();
              });

            } else if (state is UserDeleteSuccess) {
              setState(() {
                DeletePopupManager.stopLoader();

                var deleteMessage = state.userDeleteList['message'];
                print(">>>>>>>>>>>ALLDATADelete$deleteMessage");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(deleteMessage),
                    backgroundColor: AppColors.primaryColour,
                  ),
                );
                data.clear();
                pageNo = 1;
                hasMoreData = true;
                totalPages = 0;
                BlocProvider.of<AllRequesterBloc>(context).add(GetUserListHandler("", pageNo, pageSize));


                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context);
                });
              });


            }
            else if (state is UserDeleteFailure) {

              var deleteMessage = state.deleteFailure['message'];

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
              print("error>> ${state.deleteFailure}");
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
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\n')), // Deny new lines
                      LengthLimitingTextInputFormatter(200), // Limit to 250 characters
                    ],
                    decoration: InputDecoration(
                      hintText: 'Search user name',
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
                    onChanged:_onSearchChanged,
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
                    errorMessage ?? errorMessage.toString(),
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
                  controller: controller,
                  itemCount: data.length +1,
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
                                              Text("${index+1}", style: FTextStyle.listTitleSub).animateOnPageLoad(
                                                  animationsMap['imageOnPageLoadAnimation2']!),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Name: ", style: FTextStyle.listTitle),
                                              Expanded(child: Text("${item["name"]}", style: FTextStyle.listTitleSub,maxLines: 1,)).animateOnPageLoad(
                                                  animationsMap['imageOnPageLoadAnimation2']!),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Email: ", style: FTextStyle.listTitle),
                                              Expanded(child: Text("${item["email"]}", style: FTextStyle.listTitleSub,maxLines: 2,)).animateOnPageLoad(
                                                  animationsMap['imageOnPageLoadAnimation2']!),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Role: ", style: FTextStyle.listTitle),
                                              Expanded(
                                                child: Text(
                                                  "${item['roles'].map((role) => role['name']).join(', ')}",
                                                  style: FTextStyle.listTitleSub,
                                                  maxLines: 2,
                                                ).animateOnPageLoad(
                                                    animationsMap['imageOnPageLoadAnimation2']!),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.black),
                                                onPressed: () => {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  BlocProvider(
                                                      create: (context) => AllRequesterBloc(),
                                                      child:  UserEdits(
                                                        screenflag:"Edit",
                                                        id:item["id"].toString(),

                                                      ),
                                                    )),
                                                  ).then((result) {
                                                    // Handle the result from the edit screen
                                                    if (result[0]) {

                                                      data.clear();
                                                      pageNo = 1;
                                                      hasMoreData = true;
                                                      totalPages = 0;
                                                      BlocProvider.of<AllRequesterBloc>(context)
                                                          .add(GetUserListHandler("", pageNo, pageSize));
                                                    }
                                                  })

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
      BlocProvider.of<AllRequesterBloc>(context).add(
          GetUserListHandler(
              "", pageNo, pageSize));
    });
  }

}