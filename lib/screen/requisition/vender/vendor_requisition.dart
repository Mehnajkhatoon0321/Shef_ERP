import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shef_erp/screen/requisition/vender/vendor_details.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class VenderRequisition extends StatefulWidget {
  const VenderRequisition({super.key});

  @override
  State<VenderRequisition> createState() => _VenderRequisitionState();
}

class _VenderRequisitionState extends State<VenderRequisition> {
  List<Map<String, dynamic>> listData = [
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi", "image":"assets/images/requisition.png"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi", "image":"assets/images/requisition.png"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi", "image":"assets/images/requisition.png"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi", "image":"assets/images/requisition.png"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi", "image":""},

  ];
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
        title: Text('Requisition', style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,),
        backgroundColor: AppColors.primaryColourDark,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     height:
          //     (displayType == 'desktop' || displayType == 'tablet')
          //         ? 70
          //         : 43,
          //     child: ElevatedButton(
          //         onPressed: () async {
          //           // setState(() {
          //           //   isLoading = true;
          //           // });
          //
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) =>  AddRequisition(),
          //             ),
          //           );
          //
          //           // );
          //         },
          //
          //         style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(26),
          //             ),
          //             backgroundColor:Colors.white
          //
          //         ),
          //         child:
          //         Text(
          //           "Add +",
          //           style: FTextStyle.loginBtnStyle.copyWith(color:AppColors.primaryColourDark),
          //         )
          //
          //       // isLoading? CircularProgressIndicator(color: Colors.white,):Text(
          //       //   Constants.loginBtnTxt,
          //       //   style: FTextStyle.loginBtnStyle,
          //       // )
          //     ),
          //   ),
          // )
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
          Expanded(
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                final item = listData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorDetails(
                      requestDate:item["requestDate"],
                      product:item["product"],
                      specification:item["specification"],
                      quantity:item["quantity"],
                      delivery:item["delivery"],
                      image:item["image"],







                    )));
                    // Handle item tap
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 5),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: index % 2 == 0 ? AppColors.yellow : AppColors.primaryColourDark!,
                            spreadRadius: 4,
                            blurRadius: 0.5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              const Text("Product/Service: ", style: FTextStyle.listTitle),
                              Expanded(child: Text("${item["product"]}", style: FTextStyle.listTitleSub)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text("Specification: ", style: FTextStyle.listTitle),
                              Text("${item["specification"]}", style: FTextStyle.listTitleSub),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("Event: ", style: FTextStyle.listTitle),
                                  Text("${item["unit"]}", style: FTextStyle.listTitleSub),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Quantity: ", style: FTextStyle.listTitle),
                                  Text("${item["quantity"]}", style: FTextStyle.listTitleSub),
                                ],
                              ),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("Request Date: ", style: FTextStyle.listTitle),
                                  Text("${item["requestDate"]}", style: FTextStyle.listTitleSub),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text("Delivery Status: ", style: FTextStyle.listTitle),
                                  Text("${item["delivery"]}", style:item["delivery"] == 'Pending'
                                      ? FTextStyle.listTitleSubBig.copyWith(color: Colors.red)
                                      : FTextStyle.listTitleSubBig.copyWith(color: Colors.green),),
                                ],
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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

}
