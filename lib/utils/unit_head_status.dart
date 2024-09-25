import 'package:flutter/material.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class UnitHeadStatus extends StatelessWidget {
  final String  unitStatus;
   UnitHeadStatus({Key? key, required this.unitStatus}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String deliveryStatusText;
    Color deliveryStatusColor;

    // Assuming dlStatus is a String, so compare it with String literals
    switch (unitStatus) {

      case '0':
        deliveryStatusText = 'Pending';
        deliveryStatusColor = Colors.red;
        break;
      case '1':
        deliveryStatusText = 'Approved';
        deliveryStatusColor = Colors.green;
      case '2':
        deliveryStatusText = 'Rejected';
        deliveryStatusColor = Colors.orange; // Color for cancelled status
        break;

        case '8':
        deliveryStatusText = 'Received';
        deliveryStatusColor = AppColors.primaryColourDark;
        break;
      default:
        deliveryStatusText = 'Unknown';
        deliveryStatusColor = Colors.grey;
    }

    return Row(
      children: [
        const Text(
            "U.H. Status:",
            style: FTextStyle.listTitle // Replace with FTextStyle.listTitleBig if needed
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
              deliveryStatusText,
              style: FTextStyle.listTitle.copyWith( color: deliveryStatusColor)// Replace with FTextStyle.listTitleSubBig.copyWith if needed
          ),
        ),
      ],
    );
  }
}
