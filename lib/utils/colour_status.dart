import 'package:flutter/material.dart';
import 'package:shef_erp/utils/font_text_Style.dart';

class DeliveryStatus extends StatelessWidget {
  final String dlStatus;

  const DeliveryStatus({Key? key, required this.dlStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String deliveryStatusText;
    Color deliveryStatusColor;

    // Assuming dlStatus is a String, so compare it with String literals
    switch (dlStatus) {
      case '0':
        deliveryStatusText = 'NA';
        deliveryStatusColor = Colors.black;
        break;
      case '1':
        deliveryStatusText = 'Pending for Delivery';
        deliveryStatusColor = Colors.red;
        break;
      case '2':
        deliveryStatusText = 'Cancelled';
        deliveryStatusColor = Colors.orange; // Color for cancelled status
        break;
      case '8':
        deliveryStatusText = 'Delivered';
        deliveryStatusColor = Colors.green;
        break;
      default:
        deliveryStatusText = 'Unknown';
        deliveryStatusColor = Colors.grey;
    }

    return Row(
      children: [
        const Text(
          "Delivery Status:",
          style: FTextStyle.listTitle // Replace with FTextStyle.listTitleBig if needed
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            deliveryStatusText,
            style: FTextStyle.listTitle.copyWith( color: deliveryStatusColor,fontSize: 15)// Replace with FTextStyle.listTitleSubBig.copyWith if needed
          ),
        ),
      ],
    );
  }
}
