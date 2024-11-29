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
  final String image;

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
      required this.image,
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
    String imageUrl =
        'https://erp.studyhallfoundation.org/public/uploads/requisition/${widget.image}';
    print(">>>>>>widget${widget.image}");
    print(">>>>>>url>>>>${imageUrl}");

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Requisition View',
            style: FTextStyle.HeadingTxtWhiteStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.primaryColourDark,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  widget.image.isNotEmpty
                      ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Image.network(
                      'https://erp.studyhallfoundation.org/public/uploads/requisition/${widget.image}',
                      fit: BoxFit.fill, // Change to BoxFit.contain for a clearer view without cropping
                      errorBuilder: (context, error, stackTrace) {
                        print("Image failed to load: $error");
                        return Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[200],
                          child: Center(
                            child: Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: Center(
                      child: Text(
                        'No Image Available',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  // Optionally display a message if the image is empty
                  if (widget.image.isEmpty)
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          'No Image Available',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Requisition No: ",
                            style: FTextStyle.listTitleBig),
                        Text(widget.requisition,
                            style: FTextStyle.listTitleSubBig),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("PO No. : ", style: FTextStyle.listTitleBig),
                        Expanded(
                            child: Text(widget.poNumber,
                                style: FTextStyle.listTitleSubBig)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Request Date: ",
                            style: FTextStyle.listTitleBig),
                        Expanded(
                          child: Text(widget.requestDate,
                              style: FTextStyle.listTitleSubBig),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Unit: ", style: FTextStyle.listTitleBig),
                        Expanded(child: Text(widget.unit, style: FTextStyle.listTitleSubBig)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Product/Service: ",
                            style: FTextStyle.listTitleBig),
                        Expanded(child: Text(widget.product, style: FTextStyle.listTitleSubBig)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Quantity: ", style: FTextStyle.listTitleBig),
                        Expanded(child: Text(widget.quantity, style: FTextStyle.listTitleSubBig)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Vendor Name: ",
                            style: FTextStyle.listTitleBig),
                        Expanded(child: Text(widget.vender, style: FTextStyle.listTitleSubBig)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Specification: ",
                            style: FTextStyle.listTitleBig),
                        Expanded(
                          child: Text(
                            widget.specification,
                            style: FTextStyle.listTitleSubBig,
                          ),
                        ),
                      ],
                    ),
                  ],
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
