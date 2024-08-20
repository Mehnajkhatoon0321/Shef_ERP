import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shef_erp/screen/requisition/edit_requisition.dart';
import 'package:shef_erp/screen/requisition/view_details.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class RequisitionScreen extends StatefulWidget {
  const RequisitionScreen({super.key});

  @override
  State<RequisitionScreen> createState() => _RequisitionScreenState();
}

class _RequisitionScreenState extends State<RequisitionScreen> {
  List<Map<String, dynamic>> listData = [
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Success","purchase":"Pending","delivery":"Success","vender":"Mahi"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Pending","purchase":"Pending","delivery":"Success","vender":"Mahi"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Pending","purchase":"Pending","delivery":"Success","vender":"Mahi"},
    { "requisitionNo": "12000","poNumber": "4544200","requestDate": "12-03-2003","unit": "TC-R3110","product": "copy","specification":"NA","quantity":"12","unitHead":"Pending","purchase":"Pending","delivery":"Success","vender":"Mahi"},

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.dividerColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Requisition', style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,),
        backgroundColor: AppColors.primaryColour,
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
          Row(children: [



          ],),
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


                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewDetails(
                        requisition:item["requisitionNo"],
                        poNumber:item["poNumber"],
                    requestDate:item["requestDate"],
                    unit:item["unit"],
                    product:item["product"],
                specification:item["specification"],
                      quantity:item["quantity"],
                unitHead:item["unitHead"],
                purchase:item["purchase"],
                delivery:item["delivery"],
                vender:item["vender"],






                    )));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 5),
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color:  index % 2 == 0 ? Colors.white : Colors.white!,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:  [
                          BoxShadow(
                            color:  index % 2 == 0 ? AppColors.yellow : AppColors.primaryColour!,
                            spreadRadius: 10,
                            blurRadius: 1,
                            offset: Offset(0, 9),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Container(
                                  height:MediaQuery.of(context).size.height/ 007,width: MediaQuery.of(context).size.height/007,
                                  // color: Colors.yellow,

                                  child: Image.asset("assets/images/onboarding2.png",fit: BoxFit.cover, )).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Requisition No: ", style: FTextStyle.listTitle),
                                        Text("${item["requisitionNo"]}", style: FTextStyle.listTitleSub),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text("PO No. : ", style: FTextStyle.listTitle),
                                        Expanded(child: Text("${item["poNumber"]}", style: FTextStyle.listTitleSub)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text("Request Date: ", style: FTextStyle.listTitle),
                                        Text("${item["requestDate"]}", style: FTextStyle.listTitleSub),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text("Unit: ", style: FTextStyle.listTitle),
                                        Text("${item["unit"]}", style: FTextStyle.listTitleSub),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text("Product/Service: ", style: FTextStyle.listTitle),
                                        Text("${item["product"]}", style: FTextStyle.listTitleSub),
                                      ],
                                    ),
                                    const SizedBox(height: 5),





                                  ],
                                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditRequisition()));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _showDeleteDialog(index),
                              ),
                            ],
                          ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
                        ],
                      ),
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
                color: AppColors.primaryColour,
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
