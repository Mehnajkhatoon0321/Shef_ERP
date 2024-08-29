import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class RequesterDetails extends StatefulWidget {
  String requestDate;
  String product;
  String specification;
  String quantity;
  String delivery;
  String image;
  RequesterDetails({super.key, required this.requestDate, required this.product, required this.specification, required this.quantity, required this.image, required this.delivery});




  @override
  State<RequesterDetails> createState() => _RequesterDetailsState();
}

class _RequesterDetailsState extends State<RequesterDetails> {

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
        title: Text('Requisition View', style: FTextStyle.HeadingTxtWhiteStyle,
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
        ),
        // You can set this to any color you prefer
      ),
      body: Column(
        children: [
          widget.image != null && widget.image!.isNotEmpty
              ? SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child:Image.asset("${widget.image}",fit: BoxFit.cover, ),
          )
              : Container(),
          // SizedBox(
          //     height:MediaQuery.of(context).size.height/ 3,width: MediaQuery.of(context).size.width,
          //     // color: Colors.yellow,
          //
          //     child: Image.asset("${widget.image}",fit: BoxFit.cover, )).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Request Date: ", style: FTextStyle.listTitleBig),
                    Text(widget.requestDate, style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),


                Row(
                  children: [
                    const Text("Product/Service: ", style: FTextStyle.listTitleBig),
                    Text(widget.product, style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Specification: ", style: FTextStyle.listTitleBig),
                    Text(widget.specification, style: FTextStyle.listTitleSubBig),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Text("Quantity: ", style: FTextStyle.listTitleBig),
                    Text(widget.quantity, style: FTextStyle.listTitleSubBig),
                  ],
                ),
                const SizedBox(height: 5),


                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Delivery Status: ", style: FTextStyle.listTitleBig),
                    Text(widget.delivery, style:  widget.delivery == 'Pending'
                        ? FTextStyle.listTitleSubBig.copyWith(color: Colors.red)
                        : FTextStyle.listTitleSubBig.copyWith(color: Colors.green),),
                  ],
                ),
                const SizedBox(height: 5),





              ],
            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
          )


        ],
      ),
    );
  }
}
