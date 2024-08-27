import 'package:flutter/material.dart';
import 'package:shef_erp/utils/font_text_Style.dart';

import '../../utils/colours.dart';
class VenderDashboard extends StatefulWidget {
  const VenderDashboard({super.key});

  @override
  State<VenderDashboard> createState() => _VenderDashboardState();
}

class _VenderDashboardState extends State<VenderDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Dashboard', style: FTextStyle.HeadingTxtWhiteStyle,
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
    );
  }
}
