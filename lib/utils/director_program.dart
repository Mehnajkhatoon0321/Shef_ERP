import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:shef_erp/utils/font_text_Style.dart';
class ProgramDirector extends StatelessWidget {
  final String  pdStatus;
  const ProgramDirector({Key? key, required this.pdStatus}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String deliveryStatusText;
    Color deliveryStatusColor;

    // Assuming dlStatus is a String, so compare it with String literals
    switch (pdStatus) {

      case '10':
        deliveryStatusText = 'NA';
        deliveryStatusColor = Colors.black;
        break;
      case '0':
        deliveryStatusText = 'Pending Approval';
        deliveryStatusColor = Colors.red;
        break;case '1':
        deliveryStatusText =  'Approved';
        deliveryStatusColor = Colors.red;
        break;
      case '2':
        deliveryStatusText = 'Rejected';
        deliveryStatusColor = Colors.orange; // Color for cancelled status
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
            "P.D. Status:",
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
