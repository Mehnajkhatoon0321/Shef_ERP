import 'package:flutter/material.dart';
import 'package:shef_erp/utils/colour_status.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class RequesterDetails extends StatefulWidget {
  final String requestDate;
  final String product;
  final String specification;
  final String quantity;
  final String delivery;
  final String unit;
  final String image;

  const RequesterDetails({
    super.key,
    required this.requestDate,
    required this.product,
    required this.specification,
    required this.quantity,
    required this.image,
    required this.unit,
    required this.delivery,
  });

  @override
  State<RequesterDetails> createState() => _RequesterDetailsState();
}

class _RequesterDetailsState extends State<RequesterDetails> {
  @override
  Widget build(BuildContext context) {

    String imageUrl = 'https://erp.studyhallfoundation.org/public/uploads/requisition/${widget.image}';

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
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
        ),
        body: Column(
          children: [
            // Using a Stack widget to overlay the text over the image
            Stack(
              children: [
                widget.image.isNotEmpty
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  // width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
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
                  color: Colors.grey[200], // Light grey background for no image
                  child: Center(
                    child: Text(
                      'No Image Available',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Request Date: ",
                        style: FTextStyle.listTitleBig,
                      ),
                      Text(widget.requestDate, style: FTextStyle.listTitleSubBig),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Product/Service: ",
                        style: FTextStyle.listTitleBig,
                      ),
                      Text(widget.product, style: FTextStyle.listTitleSubBig),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quantity: ",
                        style: FTextStyle.listTitleBig,
                      ),
                      Text(widget.quantity, style: FTextStyle.listTitleSubBig),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: DeliveryStatus(dlStatus: widget.delivery), // Pass appropriate status
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit: ", style: FTextStyle.listTitle),
                      Expanded(
                        child: Text(
                          widget.unit,
                          style: FTextStyle.listTitleSub,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Specification: ", style: FTextStyle.listTitle),
                      Expanded(
                        child: Text(widget.specification, style: FTextStyle.listTitleSubBig),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
