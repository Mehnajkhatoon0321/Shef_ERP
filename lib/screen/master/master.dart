import 'package:flutter/material.dart';
import 'package:shef_erp/screen/master/product_category.dart';
import 'package:shef_erp/screen/master/product_service.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final List<Map<String, dynamic>> listItem = [
    {
      "image": "assets/images/dashboard.png",
      "title": 'Product/Services',
    },
    {
      "image": "assets/images/requisition.png",
      "title": 'Product/Category',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Master', style: FTextStyle.HeadingTxtWhiteStyle,
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          final item = listItem[index];
          return GestureDetector(
            onTap: () {
              _onItemTap(context, item["title"]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColors.formFieldBorderColour,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: Image.asset(
                  item["image"],
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  item["title"],
                  style: FTextStyle.HeadingTxtStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                // Optional: Add a trailing icon or widget
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );

  }
  void _onItemTap(BuildContext context, String title) {
    switch (title) {
      case 'Product/Category':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductCategory()),
        );
        break;
      case 'Product/Services':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductService()),
        );
        break;
      default:
      // Handle other cases if necessary
        break;
    }
  }
}
