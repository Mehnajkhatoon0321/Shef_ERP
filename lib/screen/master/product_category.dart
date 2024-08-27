import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shef_erp/screen/master/add_product_category.dart';
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
    { "category": "12000","name": "4544200","status": "Success","specification":"NA",},
    { "category": "12000","name": "4544200","status": "Success","specification":"NA",},
    { "category": "12000","name": "4544200","status": "Pending","specification":"NA",},
    { "category": "12000","name": "4544200","status": "Success","specification":"NA",},
    { "category": "12000","name": "4544200","status": "Success","specification":"NA",},

  ];

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
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
    _editController = TextEditingController();
  }
  Set<int> selectedIndices = {};

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
        title: Text('Category', style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,),
        backgroundColor: AppColors.primaryColour,
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
                        builder: (context) =>  const AddProductCategory(),
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
                    style: FTextStyle.loginBtnStyle.copyWith(color:AppColors.primaryColour),
                  )

                // isLoading? CircularProgressIndicator(color: Colors.white,):Text(
                //   Constants.loginBtnTxt,
                //   style: FTextStyle.loginBtnStyle,
                // )
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
                  hintText: 'Search ',
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
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                final item = listData[index];
                return GestureDetector(
                    onTap: (){



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
                                      spreadRadius:4,
                                      blurRadius: 0.5,
                                      offset: const Offset(0,1)
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
                                          const Text("Sr. No: ", style: FTextStyle.listTitle),
                                          Text("${index+1}", style: FTextStyle.listTitleSub),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text("Category: ", style: FTextStyle.listTitle),
                                          Expanded(child: Text("${item["category"]}", style: FTextStyle.listTitleSub)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text("Name: ", style: FTextStyle.listTitle),
                                          Text("${item["name"]}", style: FTextStyle.listTitleSub),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Specification: ", style: FTextStyle.listTitle),
                                          Text("${item["specification"]}", style: FTextStyle.listTitleSub),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Row(
                                            children: [
                                              const Text("Status: ", style: FTextStyle.listTitle),
                                              Text("${item["status"]}", style:item['status']=='Pending' ?FTextStyle.listTitleSub.copyWith(color: Colors.red):FTextStyle.listTitleSub.copyWith(color: Colors.green)),
                                            ],
                                          ),
                                          Row(

                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.black),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductCategory(






                                                  )));
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _showDeleteDialog(index),
                                              ),
                                            ],
                                          ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),                                      ],
                                      ),
                                      // const SizedBox(height: 5),

                                      // const SizedBox(height: 5),
                                    ],
                                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

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
                color: index % 2 == 0 ? AppColors.yellow : AppColors.primaryColour!,
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
}

