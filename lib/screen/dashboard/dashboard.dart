import 'package:flutter/material.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/font_text_Style.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Dashboard',
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Adjust this value based on your layout preference
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildDashboardCard(
              context,
              'Product',
              Icons.production_quantity_limits,
                  () {}
            ),
            _buildDashboardCard(
              context,
              'Service',
              Icons.handyman,
                  () {},
              ),

            _buildDashboardCard(
              context,
              'Settings',
              Icons.settings,
                  () {}
            ),
            // Add more cards as needed
          ],
        ),
      ),
    );
  }

  // A method to build a card with an icon and a label
  Widget _buildDashboardCard(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: AppColors.primaryColour,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: FTextStyle.HeadingTxtStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
