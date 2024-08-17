import 'package:flutter/material.dart';
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

    );
  }
}
