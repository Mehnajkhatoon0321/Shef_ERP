import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  List<Map<String, dynamic>> listData = [
    { "name": "Mahi", },
    { "name": "Alias", },
    { "name": "Alias", },
    { "name": "Alias", },
    { "name": "Alias", },
    { "name": "Alias", },
    { "name": "Alias", },
    // ... additional data
  ];

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

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          'Category',
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColour,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 43,
              child: ElevatedButton(
                onPressed: () => _showCategoryDialog(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "Add +",
                  style: FTextStyle.loginBtnStyle.copyWith(color: AppColors.primaryColour),
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
      body: Column(
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
                    borderSide: const BorderSide(color: AppColors.primaryColour, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColour, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    borderSide: const BorderSide(color: AppColors.primaryColour, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 18.0),
                  suffixIcon: _isTextEmpty
                      ? const Icon(Icons.search, color: AppColors.primaryColour)
                      : IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.primaryColour),
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
            child: listData.isEmpty
                ? Center(child: Text("No categories available.", style: FTextStyle.listTitleSub))
                : ListView.builder(
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                final item = listData[index];
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
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.white : Colors.white!,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: index % 2 == 0 ? AppColors.yellow : AppColors.primaryColour!,
                                  spreadRadius: 4,
                                  blurRadius: 0.5,
                                  offset: const Offset(0, 1),
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
                                        Text("${index + 1}", style: FTextStyle.listTitleSub),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Name: ", style: FTextStyle.listTitle),
                                            Text("${item["name"]}", style: FTextStyle.listTitleSub),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.black),
                                              onPressed: () => _showCategoryDialog(isEditing: true, index: index),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () => _showDeleteDialog(index),
                                            ),
                                          ],
                                        ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                                      ],
                                    ),
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
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _clearText() {
    _controller.clear();
    setState(() {
      _isTextEmpty = true;
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text("Are you sure you want to delete?", style: FTextStyle.preHeadingStyle),
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColour!,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextButton(
                child: const Text("OK", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    listData.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
            ),
          ],
        ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
      },
    );
  }

  void _showCategoryDialog({bool isEditing = false, int? index}) {
    final _formKey = GlobalKey<FormState>();
    final _editController = TextEditingController(text: isEditing ? listData[index!]["name"] : '');
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

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              title: Text(
                isEditing ? "Edit Product / Service Category" : "Create Product / Service Category",
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
                      Text("Category Name", style: FTextStyle.preHeadingStyle),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _editController,
                          decoration: InputDecoration(
                            hintText: "Enter Category",
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
                    child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: isButtonEnabled ? AppColors.primaryColour! : AppColors.formFieldBorderColour,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    child: Text(
                      isEditing ? "Save" : "Add",
                      style: TextStyle(color: isButtonEnabled ? Colors.white : Colors.white),
                    ),
                    onPressed: isButtonEnabled ? () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          if (isEditing) {
                            listData[index!] = {"name": _editController.text};
                          } else {
                            listData.add({"name": _editController.text});
                          }
                        });
                        Navigator.of(context).pop();
                      }
                    } : null,
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                ),
              ],
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!);
          },
        );
      },
    );
  }
}


