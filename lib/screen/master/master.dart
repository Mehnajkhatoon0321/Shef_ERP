import 'package:flutter/material.dart';
import 'package:shef_erp/screen/master/master_list/events.dart';
import 'package:shef_erp/screen/master/master_list/product_category.dart';
import 'package:shef_erp/screen/master/master_list/product_service.dart';
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
      "image": "assets/images/productServices.png",
      "title": 'Product/Services',
    },
    {
      "image": "assets/images/productCategory.png",
      "title": 'Product/Category',
    },
    {
      "image": "assets/images/event.png",
      "title": 'Events',
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
                color:
                Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: index % 2 == 0 ? Colors.blue.shade700 : Colors.yellow.shade700,
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],



                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12.0),
                leading: Image.asset(
                  item["image"],
                  width: 55,
                  height: 50,
                  fit: BoxFit.fill,
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
        case 'Events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventScreen()),
        );
        break;
      default:
      // Handle other cases if necessary
        break;
    }
  }
}
