import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shimmer/shimmer.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  bool isLoadingCreate = false;
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

  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;
  bool hasMoreData = true;
  List<dynamic> data = [

  ];
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;
  bool isLoadingEdit = false;
  bool isInitialLoading = false;

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
        .add(EventListHandler("", pageNo, pageSize));
    paginationCall();
  }

  void paginationCall() {
    controller.addListener(() {
      // Check if we've scrolled to the bottom
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        // Only proceed if we're not already loading and there's more data
        if (!isLoading && hasMoreData) {
          // Increment the page number and set loading states
          pageNo++;
          isInitialLoading = false;
          isLoading = true;

          // Dispatch the event to fetch more data
          BlocProvider.of<AllRequesterBloc>(context)
              .add(EventListHandler(searchQuery, pageNo, pageSize));
        }
      } else {
        // Hide loader and "no more data" when not at max scroll extent
        isLoading = false;
        // Optionally, reset the no more data state if you want
        // hasMoreData = true; // Uncomment if you want to reset when scrolling up
      }
    });
  }


  Map<String, dynamic> errorServerMessage = {};
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
            'Event',
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
                  onPressed: () => _showCategoryDialog(
                      BlocProvider.of<AllRequesterBloc>(context), context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Add +",
                    style: FTextStyle.loginBtnStyle
                        .copyWith(color: AppColors.primaryColourDark),
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
            if (state is EventListLoading) {
              setState(() {
                isInitialLoading = true;
              });
            } else if (state is EventListSuccess) {
              setState(() {
                var responseData = state.eventList['list'];
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
            } else if (state is EventListFailure) {
              setState(() {
                isLoading = false;
                isInitialLoading = false;
              });
              errorMessage = state.eventFailure['message'];

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage.toString()),
                  backgroundColor: AppColors.primaryColour,
                ),
              );

              if (kDebugMode) {
                print("error>> ${state.eventFailure}");
              }
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            } else if (state is EventDeleteLoading) {
              DeletePopupManager.playLoader();
            } else if (state is EventDeleteSuccess) {
              DeletePopupManager.stopLoader();

              var deleteMessage = state.deleteEventList['message'];
              BlocProvider.of<AllRequesterBloc>(context)
                  .add(EventListHandler(searchQuery, pageNo, pageSize));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(deleteMessage),
                  backgroundColor: AppColors.primaryColour,
                ),
              );

              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            } else if (state is EventDeleteFailure) {
              DeletePopupManager.stopLoader();

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
                      hintText: 'Search',
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
                            EventListHandler(
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

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(height: 10, color: Colors.grey),
                                    const SizedBox(height: 5),
                                    Container(height: 10, color: Colors.grey),
                                    const SizedBox(height: 5),
                                    Container(height: 10, color: Colors.grey),

                                 ]
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
                  child: Text("No data  available.", style: FTextStyle.listTitle),
                )
                    : ListView.builder(
                  controller: controller,
                    itemCount: data.length +1,// Loader condition
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
                                    boxShadow: [
                                      const BoxShadow(
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
                                            children: [
                                              const Text("ID: ", style: FTextStyle.listTitle),
                                              Text("${item["id"]}", style: FTextStyle.listTitleSub).animateOnPageLoad(
                                                  animationsMap['imageOnPageLoadAnimation2']!),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Name: ", style: FTextStyle.listTitle),
                                              Expanded(child: Text("${item["name"]}", style: FTextStyle.listTitleSub)).animateOnPageLoad(
                                                  animationsMap['imageOnPageLoadAnimation2']!),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.black),
                                                onPressed: () => _showCategoryDialog(
                                                    BlocProvider.of<AllRequesterBloc>(context),
                                                    context,
                                                    isEditing: true,
                                                    index: index),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () {
                                                  CommonPopups.showDeleteCustomPopup(
                                                    context,
                                                    "Are you sure you want to delete?",
                                                        () {
                                                      BlocProvider.of<AllRequesterBloc>(context)
                                                          .add(DeleteEventHandlers(data[index]['id']));
                                                    },
                                                  );
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
                              // // If there's no more data to load, show a message
                              // return const Center(
                              //     child: Text("No more data.",
                              //         style: FTextStyle.listTitle));
                            },

                          ),
                        ),
                     ] )

                  ),
                ),
    );



  }

  void _clearText() {
    _controller.clear();
    setState(() {
      BlocProvider.of<AllRequesterBloc>(context).add(
          EventListHandler(
              "", pageNo, pageSize));
      _isTextEmpty = true;
    });
  }

  Future<bool?> _showCategoryDialog(AllRequesterBloc of, BuildContext context,
      {bool isEditing = false, int? index}) async {
    final _formKey = GlobalKey<FormState>();
    final _editController =
    TextEditingController(text: isEditing ? data[index!]["name"] : '');
    bool isButtonEnabled = isEditing ? true : false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            _editController.addListener(() {
              setState(() {
                isButtonEnabled = _editController.text.isNotEmpty;
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
                    isEditing ? "Edit Event" : "Create Event",
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
                          Text("Event Name", style: FTextStyle.preHeadingStyle),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _editController,
                              decoration: InputDecoration(
                                hintText: "Enter Event",
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
                                  return 'Please enter a event';
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
                      child: BlocListener<AllRequesterBloc, AllRequesterState>(
                        listener: (context, state) {
                          if (state is EventCreateLoading) {
                            setState(() {
                              isLoadingCreate = true;
                            });
                          } else if (state is EventCreateSuccess) {

                            isLoadingCreate = false;
                            BlocProvider.of<AllRequesterBloc>(context)
                                .add(EventListHandler(searchQuery, pageNo, pageSize));
                            if (state.createResponse.containsKey('message')) {
                              var deleteMessage =
                              state.createResponse['message'];
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(deleteMessage),
                                  backgroundColor: AppColors.primaryColour,
                                ),
                              );
                            }

                            Future.delayed(const Duration(milliseconds: 500),
                                    () {
                                  Navigator.pop(context);
                                });
                          } else if (state is EventCreateFailure) {
                            var deleteMessage = state.failureMessage;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(deleteMessage['message']),
                                backgroundColor: AppColors.primaryColour,
                              ),
                            );

                            Future.delayed(const Duration(milliseconds: 500),
                                    () {
                                  Navigator.pop(context);
                                });
                            setState(() {
                              isLoadingCreate = false;
                            });
                            print("error>> ${state.failureMessage}");
                          } else if (state is UpdateEventsLoading) {
                            setState(() {
                              isLoadingCreate = true;
                            });
                          } else if (state is UpdateEventsSuccess) {
                            isLoadingCreate = false;
                            BlocProvider.of<AllRequesterBloc>(context)
                                .add(EventListHandler(searchQuery, pageNo, pageSize));
                            var update = state.updateResponse['message'];

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(update),
                                backgroundColor: AppColors.primaryColour,
                              ),
                            );

                            Future.delayed(const Duration(milliseconds: 500),
                                    () {
                                  Navigator.pop(context);
                                });
                          } else if (state is UpdateEventsFailure) {
                            var deleteMessage = state.failureUpdateMessage['message'];

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(deleteMessage),
                                backgroundColor: AppColors.primaryColour,
                              ),
                            );

                            Future.delayed(const Duration(milliseconds: 500),
                                    () {
                                  Navigator.pop(context);
                                });
                            setState(() {
                              isLoadingCreate = false;
                            });
                            print("error>> ${state.failureUpdateMessage}");
                          }
                          // TODO: implement listener
                        },
                        child: TextButton(

                          child: isLoadingCreate
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                            isEditing ? "Save" : "Add",
                            style: TextStyle(color: Colors.white),
                          ),

                          onPressed: isButtonEnabled
                              ? () {
                            if (_formKey.currentState?.validate() ??
                                false) {
                              if (mounted) {
                                // Check if the widget is still mounted
                                if (isEditing) {
                                  of.add(UpdateEventHandler(
                                    name: _editController.text,

                                    id: data[index!]["id"],
                                  ));
                                } else {
                                  of.add(CreateEventHandler(
                                      category: _editController.text));
                                }
                              }
                            }
                          }
                              : null,

                        ),
                      ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation2']!),
                    ),
                  ],
                ).animateOnPageLoad(
                    animationsMap['columnOnPageLoadAnimation1']!));
          },
        );
      },
    );
  }
}
