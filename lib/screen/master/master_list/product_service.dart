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
  int pageSize = 5;
  bool hasMoreData = true;
  List<dynamic> data = [
    {
      "name": "Event1",
    },
    {
      "name": "Event2",
    },
    {
      "name": "Event3",
    },
    {
      "name": "Event4",
    },
    {
      "name": "Event5",
    },
  ];
  final controller = ScrollController();
  final controllerI = ScrollController();
  bool isLoading = false;

  TextEditingController _editController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
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
        if (pageNo < totalPages && !isLoading) {
          if (hasMoreData) {
            pageNo++;
            BlocProvider.of<AllRequesterBloc>(context)
                .add(MasterServiceHandler("", pageNo, pageSize));
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
      backgroundColor: AppColors.dividerColor,
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
                    _showCategoryDialog();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      backgroundColor: Colors.white),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => AllRequesterBloc(),
                                  child: ProductServiceEdit(
                                    screenflag: "",
                                    id: PrefUtils.getUserId().toString(),
                                  ),
                                )),
                      );
                    },
                    child: Text(
                      "Add +",
                      style: FTextStyle.loginBtnStyle
                          .copyWith(color: AppColors.primaryColourDark),
                    ),
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
              isLoading = true;
            });
          } else if (state is ServiceSuccess) {
            setState(() {
              var responseData = state.serviceList['list'];
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
          } else if (state is ServiceCategoryFailure) {
            setState(() {
              isLoading = false;
            });
            print("error>> ${state.serviceCategoryFailure}");
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
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
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
                                                      style: FTextStyle
                                                          .listTitle),
                                                  Text("${index + 1}",
                                                      style: FTextStyle
                                                          .listTitleSub),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  const Text("Category: ",
                                                      style: FTextStyle
                                                          .listTitle),
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
                                                      style: FTextStyle
                                                          .listTitle),
                                                  Text("${item["name"]}",
                                                      style: FTextStyle
                                                          .listTitleSub),
                                                ],
                                              ),
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
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text("Status: ",
                                                      style: FTextStyle
                                                          .listTitle),
                                                  GestureDetector(
                                                    onTap: () {

                                                    },
                                                    child: Text(
                                                      item["status"] == 0
                                                          ? "Active"
                                                          : item["status"] ==
                                                                  4
                                                              ? "Inactive"
                                                              : "${item["status"]}",
                                                      style: (item["status"] ==
                                                              0
                                                          ? FTextStyle
                                                              .listTitleSub
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green)
                                                          : item["status"] ==
                                                                  4
                                                              ? FTextStyle
                                                                  .listTitleSub
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .red)
                                                              : FTextStyle
                                                                  .listTitleSub),
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
                                                    icon: const Icon(
                                                        Icons.edit,
                                                        color:
                                                            Colors.black),
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
                                                                        id: item["id"].toString(),
                                                                      ),
                                                                    )),
                                                      );
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () => {
                                                      CommonPopups
                                                          .showDeleteCustomPopup(
                                                        context,
                                                        "Are you sure you want to delete?",
                                                        () {
                                                          BlocProvider.of<
                                                                      AllRequesterBloc>(
                                                                  context)
                                                              .add(DeleteMasterServiceHandlers(
                                                                  data[index]
                                                                      [
                                                                      'id']));
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

  void _showCategoryDialog({bool isEditing = false, int? index}) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _editController = TextEditingController(
      text: isEditing ? data[index!]["name"] : '',
    );
    final TextEditingController _descriptionController = TextEditingController(
      text: isEditing ? data[index!]["specification"] : '',
    );
    final TextEditingController _categoryController = TextEditingController(
      text: isEditing ? data[index!]["cate_name"] : '',
    );
    bool isButtonEnabled = isEditing;

    // Dummy values for demonstration; replace these with your actual data
    List<String> list = ['Category 1', 'Category 2', 'Category 3'];
    String? selectedItem;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Update button state when text changes
            _editController.addListener(() {
              setState(() {
                isButtonEnabled = _editController.text.isNotEmpty;
              });
            });

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              title: Text(
                isEditing
                    ? "Edit Product / Service"
                    : "Create Product / Service",
                style: FTextStyle.preHeading16BoldStyle,
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Product / Service Category",
                          style: FTextStyle.preHeadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.0),
                              border: Border.all(
                                  color: AppColors.primaryColourDark),
                              color: Colors.grey[100],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedItem,
                                hint: const Text("Select Category",
                                    style: FTextStyle.formhintTxtStyle),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedItem = newValue;
                                    isButtonEnabled =
                                        _categoryController.text.isNotEmpty &&
                                            selectedItem != null;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Product Name",
                          style: FTextStyle.preHeadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _editController,
                            decoration: InputDecoration(
                              hintText: "Enter Product Name",
                              hintStyle: FTextStyle.formhintTxtStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23.0),
                                borderSide: const BorderSide(
                                    color: AppColors.primaryColourDark,
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23.0),
                                borderSide: const BorderSide(
                                    color: AppColors.primaryColourDark,
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
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Product Specification",
                          style: FTextStyle.preHeadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            maxLines: 3,
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: "Enter description",
                              hintStyle: FTextStyle.formhintTxtStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23.0),
                                borderSide: const BorderSide(
                                    color: AppColors.primaryColourDark,
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23.0),
                                borderSide: const BorderSide(
                                    color: AppColors.primaryColourDark,
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
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                            // Add your other validators and controllers here
                          ),
                        ),
                      ],
                    ),
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
                    animationsMap['imageOnPageLoadAnimation2']!,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: isButtonEnabled
                        ? AppColors.primaryColourDark
                        : AppColors.formFieldBorderColour,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    onPressed: isButtonEnabled
                        ? () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Handle form submission
                              setState(() {
                                if (isEditing) {
                                  data[index!] = {
                                    "name": _editController.text,
                                    "category": selectedItem,
                                    "specification": _descriptionController.text
                                    // Add other fields as needed
                                  };
                                } else {
                                  data.add({
                                    "name": _editController.text,
                                    "category": selectedItem,
                                    "specification": _descriptionController.text
                                    // Add other fields as needed
                                  });
                                }
                              });
                              Navigator.of(context).pop();
                            }
                          }
                        : null,
                    child: Text(
                      isEditing ? "Save" : "Add",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ).animateOnPageLoad(
                    animationsMap['imageOnPageLoadAnimation2']!,
                  ),
                ),
              ],
            ).animateOnPageLoad(
              animationsMap['columnOnPageLoadAnimation1']!,
            );
          },
        );
      },
    );
  }
}
