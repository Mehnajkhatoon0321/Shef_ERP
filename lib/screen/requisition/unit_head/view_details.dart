import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';

class ViewDetails extends StatefulWidget {
  String requisition;
  String poNumber;
  String requestDate;
  String unit;
  String product;
  String specification;
  String quantity;
  String unitHead;
  String purchase;
  String delivery;
  String vender;

  ViewDetails(
      {required this.requisition,
      required this.poNumber,
      required this.requestDate,
      required this.unit,
      required this.product,
      required this.specification,
      required this.quantity,
      required this.unitHead,
      required this.purchase,
      required this.delivery,
      required this.vender,
      super.key});

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Requisition View',
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
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
        ),
        // You can set this to any color you prefer
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              // color: Colors.yellow,

              child: Image.asset(
                "assets/images/onboarding2.png",
                fit: BoxFit.cover,
              )).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Requisition No: ",
                        style: FTextStyle.listTitleBig),
                    Text(widget.requisition,
                        style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("PO No. : ", style: FTextStyle.listTitleBig),
                    Expanded(
                        child: Text(widget.poNumber,
                            style: FTextStyle.listTitleSubBig)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Request Date: ",
                        style: FTextStyle.listTitleBig),
                    Text(widget.requestDate,
                        style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Unit: ", style: FTextStyle.listTitleBig),
                    Text(widget.unit, style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Product/Service: ",
                        style: FTextStyle.listTitleBig),
                    Text(widget.product,
                        style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Specification: ",
                        style: FTextStyle.listTitleBig),
                    Text(widget.specification,
                        style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Quantity: ", style: FTextStyle.listTitleBig),
                    Text(widget.quantity,
                        style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Unit Head Status: ",
                        style: FTextStyle.listTitleBig),
                    Text(
                      widget.unitHead,
                      style: widget.unitHead == 'Pending'
                          ? FTextStyle.listTitleSubBig
                              .copyWith(color: Colors.red)
                          : FTextStyle.listTitleSubBig
                              .copyWith(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Purchase Manager Status: ",
                        style: FTextStyle.listTitleBig),
                    Text(
                      widget.purchase,
                      style: widget.purchase == 'Pending'
                          ? FTextStyle.listTitleSubBig
                              .copyWith(color: Colors.red)
                          : FTextStyle.listTitleSubBig
                              .copyWith(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Delivery Status: ",
                        style: FTextStyle.listTitleBig),
                    Text(
                      widget.delivery,
                      style: widget.delivery == 'Pending'
                          ? FTextStyle.listTitleSubBig
                              .copyWith(color: Colors.red)
                          : FTextStyle.listTitleSubBig
                              .copyWith(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Vendor Name: ", style: FTextStyle.listTitleBig),
                    Text(widget.vender, style: FTextStyle.listTitleSubBig),
                  ],
                )
              ],
            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
          )
        ],
      ),
    );
  }
}
