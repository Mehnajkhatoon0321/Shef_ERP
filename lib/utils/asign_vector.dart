import 'package:flutter/material.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class PurchaseManager extends StatelessWidget {
  final String  pmStatus;
  PurchaseManager({Key? key, required this.pmStatus}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String deliveryStatusText;
    Color deliveryStatusColor;

    // Assuming dlStatus is a String, so compare it with String literals
    switch (pmStatus) {

      case '0':
        deliveryStatusText = 'NA';
        deliveryStatusColor = Colors.black;
        break;
      case '1':
        deliveryStatusText = 'Pending Approval';
        deliveryStatusColor = Colors.red;
        break;
      case '2':
        deliveryStatusText = 'Rejected';
        deliveryStatusColor = Colors.orange; // Color for cancelled status
        break;
      case '3':
        deliveryStatusText = 'Assigned to Vendor';
        deliveryStatusColor = Colors.green;
        break;
        case '8':
        deliveryStatusText = 'Received';
        deliveryStatusColor = Colors.green;
        break;
      default:
        deliveryStatusText = 'Unknown';
        deliveryStatusColor = Colors.grey;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            "P.M. Status:",
            style: FTextStyle.listTitle // Replace with FTextStyle.listTitleBig if needed
        ),
        SizedBox(width: 2,),
        Expanded(
          child: Text(
              deliveryStatusText,
              style: FTextStyle.listTitle.copyWith( color: deliveryStatusColor,fontSize: 15)// Replace with FTextStyle.listTitleSubBig.copyWith if needed
          ),
        ),
      ],
    );
  }
}
