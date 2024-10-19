import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shef_erp/all_bloc/requester/all_requester_bloc.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
class VendorView extends StatefulWidget {

  String id;
   VendorView({required this.id, super.key});

  @override
  State<VendorView> createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView> {

  Map<String, dynamic> personalData = {

  };   Map<String, dynamic> responseData = {

  };
  Map<String, dynamic> bankData = {

  };

  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<AllRequesterBloc>(context).add(VendorViewHandler(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Vendor View',
          style: FTextStyle.HeadingTxtWhiteStyle,
          textAlign: TextAlign.center,
        ),
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
        ),
      ),
      body: BlocListener<AllRequesterBloc, AllRequesterState>(
  listener: (context, state) {

    if (state is VendorViewLoading) {
      setState(() {
        isLoading = true;
      });
    } else if (state is VendorViewSuccess) {
      setState(() {
        var responseData = state.vendorViewList;






        // Access personal data from Alldata
         personalData = responseData['user_info'] ;
         bankData = responseData['vendor_info'] ;
        print(">>>>>>>>>>>personaldata$personalData");
        print(">>>>>>>>>>>bankData$bankData");


      });
    } else if (state is VendorViewFailure) {
      setState(() {
        isLoading = false;
      });
      print("error>> ${state.vendorEditFailure}");
      var serverFail = state.vendorEditFailure['message'];
      print(">>>>>>>>>>>ALLDATADelete$serverFail");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(serverFail),
          backgroundColor: AppColors.primaryColour,
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    }

    // TODO: implement listener
  },
  child:isLoading && personalData.isEmpty
      ? Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal:0.03, vertical: 5),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 10,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  )
      : personalData.isEmpty
      ? Center(
    child: isLoading
        ? const CircularProgressIndicator() // Show circular progress indicator
        : const Text("No  data  available.",
        style: FTextStyle.listTitle),
  )
      :  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),//
              Text(
                "Personal Details:",
                style: FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19),
              ),
              const SizedBox(height: 10),//
              Divider(height: 2,color: AppColors.formFieldHintColour,thickness: 2,),
              const SizedBox(height: 10),//
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Roles: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text("Vendor"?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
        
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contact Person Name: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(personalData['name'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(personalData['email'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 10),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contact No.:", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(personalData['contact'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 10),
           Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Whatsapp: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['whatsapp'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(personalData['address'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),

              const SizedBox(height: 20),//
              Divider(height: 2,color: AppColors.formFieldHintColour,thickness: 2,),
              const SizedBox(height: 20),// Add some spacing
              Text(
                "Company Details:",
                style: FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19),
              ),
              const SizedBox(height: 10),//
              Divider(height: 2,color: AppColors.formFieldHintColour,thickness: 2,),
              const SizedBox(height: 10),//
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Type: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['company_type'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Company Name: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['company_name'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),    Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['address'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),    Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("PAN : ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['pan'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),
              Text("PAN Upload : ", style: FTextStyle.listTitleBig),

              _buildImage(bankData['pan_file']),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("GST : ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['gst'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),
              Text("GST Upload : ", style: FTextStyle.listTitleBig),

              _buildImage(bankData['gst_file']),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("TAN: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['tan'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),
              Text("TAN Upload : ", style: FTextStyle.listTitleBig),

              _buildImage(bankData['cheque']),
              const SizedBox(height: 10),//
              Divider(height: 2,color: AppColors.formFieldHintColour,thickness: 2,),
              const SizedBox(height: 20),//
        
              Text(
                "Bank Details:",
                style: FTextStyle.formLabelTxtStyle.copyWith(fontSize: 19),
              ),
              const SizedBox(height: 10),//
              Divider(height: 2,color: AppColors.formFieldHintColour,thickness: 2,),
              const SizedBox(height: 10),//
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Account Name: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['company_name'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
        
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Account Number: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['account_no'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("IFSC: ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['ifsc'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 10),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bank Name :", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['bank_name'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Branch ", style: FTextStyle.listTitleBig),
                  Expanded(child: Text(bankData['branch'] ?? 'N/A', style: FTextStyle.listTitleSubBig)),
                ],
              ),
        
        
              const SizedBox(height: 20),//
              Divider(height: 2,color: AppColors.formFieldHintColour,thickness: 2,),
              const SizedBox(height: 20),//
            ],
          ),
        ),
      ),
),
    );
  }
  Widget _buildImage(String? fileName) {
    if (fileName == null || fileName.isEmpty) {
      return const Text('No upload available.');
    }

    // Check file extension
    String extension = fileName.split('.').last.toLowerCase();

    // Assuming the fileName is a complete URL for network images
    String fileUrl = 'https://erp.studyhallfoundation.org/public/uploads/vendor/$fileName';

    if (extension == 'jpeg' || extension == 'jpg' || extension == 'png') {
      return Image.network(fileUrl, width: 200, height: 200); // Increased size
    } else if (extension == 'pdf') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              if (await canLaunch(fileUrl)) {
                await launch(fileUrl);
              } else {
                throw 'Could not launch $fileUrl';
              }
            },
            child: const Text('View Pdf'),
          ),
        ],
      );
    } else {
      return const Text('Unsupported file type.');
    }
  }


}

