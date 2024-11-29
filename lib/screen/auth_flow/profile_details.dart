import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  bool isButtonEnabled = false;
  bool isInitialLoading = false;
  Map<String,dynamic> data ={};
  String? errorMessage;
  @override
  void initState() {
    BlocProvider.of<AllRequesterBloc>(context)
        .add(ProfileListHandler());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    final screenWidth = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
        body: BlocListener<AllRequesterBloc, AllRequesterState>(
          listener: (context, state) {
            if (state is ProfileListLoading) {
              setState(() {
                isInitialLoading = true;
              });
            } else if (state is ProfileListSuccess) {
               data = state.eventList['user'];
              print(">>>>>>>>>>>ALLDATA$data");
              setState(() {


                isInitialLoading = false;
              });
            } else if (state is ProfileFailure) {
              setState(() {
                isInitialLoading = false;
              });
              errorMessage = state.eventFailure['message'];

              if (kDebugMode) {
                print("error>> ${state.eventFailure}");
              }
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Container(
                      width: screenWidth*0.41, // Adjust width as needed
                      height: height*0.2, // Adjust height as needed
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
                    Container(
                      width:screenWidth/3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height:height*0.05,
                              child: Text("Name : ", style: FTextStyle.Faqssubtitle)),
                          Container(  height:height*0.07,
                              child: Text("Email : ", style: FTextStyle.Faqssubtitle)),
                          Container(  height:height*0.05,
                              child: Text("Phone No : ", style: FTextStyle.Faqssubtitle)),
                          Container(  height:height*0.05,
                              child: Text("Designation : ", style: FTextStyle.Faqssubtitle))
                          ,Container(  height:height*0.07,
                              child: Text("Password : ", style: FTextStyle.Faqssubtitle)),
                          Container(  height:height*0.05,
                              child: Text("Address : ", style: FTextStyle.Faqssubtitle)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            height:height*0.05,
                            child: Text(
                              data['name'] ?? "",
                              style: FTextStyle.formhintTxtStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),

                          Container(
                            height:height*0.07,
                            child: Text(
                              data['email'] ?? "",
                              style: FTextStyle.formhintTxtStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),

                          Container(
                            height:height*0.05,
                            child: Text(
                              data['contact'] ?? "",
                              style: FTextStyle.formhintTxtStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),

                          Container(
                            height:height*0.05,
                            child: Text(
                              data['designation'] ?? "",
                              style: FTextStyle.formhintTxtStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),

                          Container(
                            height:height*0.07,
                            child: Text(
                              data['password'] ?? "",
                              style: FTextStyle.formhintTxtStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),

                          Container(
                            height:height*0.05,
                            child: Text(
                              data['address'] ?? "",
                              style: FTextStyle.formhintTxtStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
