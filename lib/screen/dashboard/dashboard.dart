import 'package:flutter/material.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> listData = [
    { "product_description": "10 CV NVR","brand": "Toshiba","model": "TC-R3110","warranty": "3 YEARS	",},
    { "product_description": "10 CV NVR tFVGFD","brand": "Toshiba","model": "TC-R3110DFGFDG","warranty": "3 YEARS	",},
    { "product_description": "10 CV NVR fdgfdg","brand": "Toshiba","model": "TC-R3110","warranty": "3 YEARS	",},
    { "product_description": "10 CV NVR DFGFDGFD","brand": "Toshiba","model": "TC-R311DFGDF0","warranty": "3 YEARS	",},
    { "product_description": "10 CV NVR GFGF","brand": "Toshiba","model": "TFDGDC-R3110","warranty": "3 YEARS	",},
    { "product_description": "10 CV NVR" ,"brand": "Toshiba","model": "TCFGFD-R3110","warranty": "3 YEARS	",},
    { "product_description": "10GRFGF CV NVR","brand": "Toshiba","model": "GD-R3110","warranty": "3 YEARS	",},
    { "product_description": "10 FDDFGCV NVR","brand": "Toshiba","model": "TFGDFC-R3110","warranty": "3 YEARS	",},

  ];
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
