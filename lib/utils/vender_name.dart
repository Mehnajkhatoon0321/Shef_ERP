import 'package:flutter/material.dart';
import 'package:shef_erp/utils/font_text_Style.dart';



class VendorStatus extends StatelessWidget {
  final String role;
  final int deliveryStatus;
  final String companyName;

  const VendorStatus({
    super.key,
    required this.role,
    required this.deliveryStatus,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the role is neither 'Requester' nor 'Vendor'
    if (role == 'Requester' || role == 'Vendor') {
      return Container(); // Return an empty container if the condition is met
    }

    String statusText;
    Color statusColor;

    switch (deliveryStatus) {
      case 0:
        statusText = 'NA';
        statusColor = Colors.black; // NA color
        break;
      case 1:
      case 8:
        statusText = companyName;
        statusColor = const Color(0xFF05A718); // Delivered color
        break;
      case 2:
        statusText = companyName;
        statusColor = Colors.red; // Cancelled color
        break;
      default:
        statusText = 'Unknown Status';
        statusColor = Colors.grey; // Unknown status color
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Vendor Name:", style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              statusText,
              style: FTextStyle.listTitle.copyWith( color: statusColor,fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
