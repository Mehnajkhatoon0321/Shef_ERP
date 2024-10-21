import 'package:flutter/material.dart';

import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/pref_utils.dart';
class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:AppColors.primaryColourDark,// Customize app bar color
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 28,
            ), // Back icon
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'My  Profile',
            style: FTextStyle.HeadingTxtWhiteStyle,
          ), // Title of the app bar
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/2.9,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Container(
                    width: 160, // Adjust width as needed
                    height: 160, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // Background color for placeholder
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile.png'), // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name            :  ", style: FTextStyle.Faqssubtitle),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Email             :  ", style: FTextStyle.Faqssubtitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Phone  No     :  ", style: FTextStyle.Faqssubtitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("DOB               :  ", style: FTextStyle.Faqssubtitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Address       :  ", style: FTextStyle.Faqssubtitle),
                      ),
                    ],
                  ),
                   Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PrefUtils.getUserName(),
                          style: FTextStyle.formhintTxtStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            PrefUtils.getInsideEmailLogin(),
                            style: FTextStyle.formhintTxtStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "--",
                            style: FTextStyle.formhintTxtStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "--",
                            style: FTextStyle.formhintTxtStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "--",
                            style: FTextStyle.formhintTxtStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 23.0),
            //   child: SizedBox(
            //     height: (displayType == 'desktop' || displayType == 'tablet') ? 70 : 46,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const EditProfile(),
            //           ),
            //         );
            //       },
            //       style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         backgroundColor: AppColors.primaryColourDark,
            //       ),
            //       child: Text(
            //         "Edit Profile",
            //         style: FTextStyle.loginBtnStyle,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
