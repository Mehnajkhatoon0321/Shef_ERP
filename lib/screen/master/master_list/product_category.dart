import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/utils/DeletePopupManager.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/common_popups.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:shimmer/shimmer.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  int pageNo = 1;
  int totalPages = 0;
  int pageSize = 10;
  bool hasMoreData = true;
  List<dynamic> data = [];
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;
  bool isInitialLoading = false;
  bool isLoadingCreate = false;
  String searchQuery = "";
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
        .add(GetProductCategoryHandler("", pageNo, pageSize));
    paginationCall();
  }
  void _refreshVendorList() {
    setState(() {

      BlocProvider.of<AllRequesterBloc>(context)
          .add(GetProductCategoryHandler(searchQuery, pageNo, pageSize));
    });
  }

  void paginationCall() {
    controllerI.addListener(() {
      if (controllerI.position.pixels == controllerI.position.maxScrollExtent) {
        if (!isLoading && hasMoreData) {
          pageNo++;

          isInitialLoading = false;
          isLoading = true;

          BlocProvider.of<AllRequesterBloc>(context)
              .add(GetProductCategoryHandler(searchQuery, pageNo, pageSize));
        }
      }
    });
  }
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
          GetProductCategoryHandler(searchQuery, pageNo, pageSize));
    });
  }
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
            'Category',
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
            if (state is ServiceCategoryLoading) {
              setState(() {
                isInitialLoading = true;
              });
            }
            else if (state is ServiceCategorySuccess) {
              setState(() {
                var responseData = state.serviceCategoryList['list'];
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
            }
            else if (state is EventFailure) {
              setState(() {
                isLoading = false;
                isInitialLoading = false;
              });
              errorMessage = state.eventFailure['message'];

            }
            else if (state is DeleteServiceCategoryLoading) {setState(() {
              DeletePopupManager.playLoader();
            });

            }
            else if (state is DeleteServiceCategorySuccess) {
              setState(() {

              DeletePopupManager.stopLoader();

              var deleteMessage = state.deleteEventCategoryList['message'];

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
              BlocProvider.of<AllRequesterBloc>(context)
                  .add(GetProductCategoryHandler("", pageNo, pageSize));

              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            });


            }
            else if (state is DeleteEventCategoryFailure) {
              DeletePopupManager.stopLoader();

              var deleteMessage = state.deleteEventCategoryFailure['message'];

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    deleteMessage,
                    style: FTextStyle.loginBtnStyle,
                  ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\n')), // Deny new lines
                        LengthLimitingTextInputFormatter(200), // Limit to 250 characters
                      ],
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(6, (index) => // Generate placeholders
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 10,
                                color: Colors.grey,
                              ),
                            ),
                            ),
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
                  child: Text("No data available.", style: FTextStyle.listTitle),
                )
                    : ListView.builder(
                  itemCount: data.length + 1,
                  controller: controllerI,
                  itemBuilder: (context, index) {
                    if (index < data.length) {
                      final item = data[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle tap event if needed
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03, vertical: 5),
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColourDark,
                                  spreadRadius: 1.5,
                                  blurRadius: 0.4,
                                  offset: const Offset(0, 0.9),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("ID: ", style: FTextStyle.listTitle),
                                    Text("${index+1}", style: FTextStyle.listTitleSub),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Name: ", style: FTextStyle.listTitle),
                                        Text("${item["cate_name"]}", style: FTextStyle.listTitleSub),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.black),
                                          onPressed: () => _showCategoryDialog(
                                              BlocProvider.of<AllRequesterBloc>(context),
                                              context,
                                              isEditing: true,
                                              index: index
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            final localContext = context; // Capture context
                                            CommonPopups.showDeleteCustomPopup(
                                              localContext,
                                              "Are you sure you want to delete?",
                                                  () async {
                                                await Future.delayed(const Duration(seconds: 1));
                                                if (!mounted) return; // Check if still mounted
                                                BlocProvider.of<AllRequesterBloc>(localContext).add(
                                                  DeleteMasterCategoryHandlers(data[index]['id']),
                                                );
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
                          ),
                        ),
                      );
                    }
                    if (hasMoreData && index == data.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if (data.length > 7 && index == data.length) {
                      // Show the "No more data." text if we are at the end and there are more than 10 items
                      return const Center(
                        child: Text("No more data.", style: FTextStyle.listTitle),
                      );
                    }
                  },
                ),
              )

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
      data.clear();
      BlocProvider.of<AllRequesterBloc>(context)
          .add(GetProductCategoryHandler("", 1, pageSize));
    });
  }

  Future<bool?> _showCategoryDialog(AllRequesterBloc of, BuildContext context,
      {bool isEditing = false, int? index}) async
  {
    final _formKey = GlobalKey<FormState>();
    final _editController =
    TextEditingController(text: isEditing ? data[index!]["cate_name"] : '');
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
                  isEditing
                      ? "Edit Product / Service Category"
                      : "Create Product / Service Category",
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
                        Text("Category Name",
                            style: FTextStyle.preHeadingStyle),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _editController,
                            decoration: InputDecoration(
                              hintText: "Enter Category",
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
                                return 'Please enter a category';
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
                  BlocListener<AllRequesterBloc, AllRequesterState>(
                    listener: (context, state) {
                      if (state is CreateCategoryLoading) {
                        setState(() {
                          isLoadingCreate = true;
                        });
                      }
                      else if (state is CreateCategorySuccess) {
                        setState(() {
                          isLoadingCreate = false;
                          var deleteMessage = state.createResponse['message'];
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
                          BlocProvider.of<AllRequesterBloc>(context)
                              .add(GetProductCategoryHandler("", pageNo, pageSize));
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pop(context);
                          });

                        });


                      }

                      else if (state is ServerProductCategoryFailure) {
                        var deleteMessage = state.failureServerMessage;

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
                          isLoadingCreate = false;
                        });
                        print("error>> ${state.failureServerMessage}");
                      }  else if (state is CreateCategoryFailure) {
                        var deleteMessage = state.failureMessage['message'].toString();

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
                          isLoadingCreate = false;
                        });
                        print("error>> ${state.failureMessage}");
                      } else if (state is UpdateCategoryLoading) {
                        setState(() {
                          isLoadingCreate = true;
                        });
                      } else if (state is UpdateCategorySuccess){


                        setState(() {
                          isLoadingCreate = false;

                          var update = state.updateResponse['message'];


                          // var responseData = state.updateResponse['list'];
                          // print("responce data${responseData}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(update),
                              backgroundColor: AppColors.primaryColour,
                            ),
                          );
                          data.clear();
                          pageNo = 1;
                          hasMoreData = true;
                          totalPages = 0;
                          BlocProvider.of<AllRequesterBloc>(context)
                              .add(GetProductCategoryHandler("", pageNo, pageSize));
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pop(context);
                          });
                        });



                      } else if (state is UpdateCategoryFailure) {
                        var deleteMessage = state.failureMessage['message'];

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
                          isLoadingCreate = false;
                        });
                        print("error>> ${state.failureMessage}");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isButtonEnabled
                            ? AppColors.primaryColourDark
                            : AppColors.formFieldBorderColour,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextButton(
                        child: isLoadingCreate
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          isEditing ? "Save" : "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: isButtonEnabled
                            ? () {

                          if (_formKey.currentState?.validate() ?? false) {
                            if (mounted) {
                              if (isEditing) {
                                of.add(CategoryUpdateEventHandler(
                                  category: _editController.text,
                                  userId: PrefUtils.getUserId(),
                                  id: data[index!]["id"],
                                ));
                              } else {
                                of.add(CategoryCreateEventHandler(
                                  category: _editController.text,
                                ));
                              }
                            }
                          }
                        }
                            : null, // Disable button if not enabled
                      ),
                    ),
                  ),
                ],
              ),
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );

  }
}