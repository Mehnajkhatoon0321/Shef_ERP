import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:shef_erp/screen/requisition/add_part.dart';
import 'package:shef_erp/screen/requisition/requisition.dart';
import 'package:shef_erp/utils/colours.dart';
import 'package:shef_erp/utils/common_function.dart';
import 'package:shef_erp/utils/flutter_flow_animations.dart';
import 'package:shef_erp/utils/font_text_Style.dart';
import 'package:shef_erp/utils/form_field_style.dart';
import 'package:shef_erp/utils/no_space_input_formatter_class.dart';
import 'package:shef_erp/utils/validator_utils.dart';
class AddRequisition extends StatefulWidget {
  const AddRequisition({super.key});

  @override
  State<AddRequisition> createState() => _AddRequisitionState();
}

class _AddRequisitionState extends State<AddRequisition> {  late final TextEditingController dateFrom = TextEditingController();
  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(40.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };
  late final GlobalKey<FormFieldState<String>> dateKey =
  GlobalKey<FormFieldState<String>>();
bool isButtonEnabled = false;
bool isLoading = false;
bool addVisibility =false;
String gender = "";
late final FocusNode _dateAppNode = FocusNode();
  void _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != currentDate) {
      // Format the date to dd-MM-yyyy
      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

      setState(() {
        dateFrom.text = formattedDate;
      });
    }
  }
List<dynamic> list = ['Female', 'data', 'items'];
String? selectedItem; // Variable to keep track of selected item
  @override
  Widget build(BuildContext context) {
    var valueType = CommonFunction.getMyDeviceType(MediaQuery.of(context));
    var displayType = valueType.toString().split('.').last;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Add Requisition', style: FTextStyle.HeadingTxtWhiteStyle,
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
body: Form(
  child: Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date",
          style: FTextStyle.formLabelTxtStyle,
        ).animateOnPageLoad(
          animationsMap['imageOnPageLoadAnimation2']!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            key: dateKey,
            focusNode: _dateAppNode,
            keyboardType: TextInputType.text,
            decoration: FormFieldStyle.defaultAddressInputDecoration.copyWith(
              hintText: "dd-mm-yyyy",
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_today, // Calendar icon
                  color: AppColors.primaryColour, // Adjust color as needed
                ),
                onPressed: () {
                  // Show date picker when the icon is pressed
                  _selectDate(context);
                },
              ),
            ),
            inputFormatters: [NoSpaceFormatter()],
            controller: dateFrom,
            validator: ValidatorUtils.dateValidator,
            onTap: () {
              setState(() {
                // isProductCategoryFieldFocused = false;
              });
            },
          ).animateOnPageLoad(
            animationsMap['imageOnPageLoadAnimation2']!,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Add Requisition Product",
          style: FTextStyle.formLabelTxtStyle,
        ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
        const SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            setState(() {
              addVisibility = !addVisibility; // Toggle the visibility
            });
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color:AppColors.gray_2,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12),top:Radius.circular(12) ),
            ),
            child: Column(
              children: [

                const SizedBox(height: 30,),
                const Icon(Icons.add_box_rounded,color:AppColors.primaryColour,size: 50, ),
                const SizedBox(height: 10,),
                Text("Add Requisition",style :FTextStyle.formLabelTxtStyle),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
        Visibility(
          visible: addVisibility,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Container(
           width: MediaQuery.of(context).size.width,
     height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.formFieldBackColour,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product/Service",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),

                    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28.0),
      border: Border.all(color: Colors.blueGrey),
      color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
      value: selectedItem,
      hint:const Text( "Select Product/Service ",style: FTextStyle.formhintTxtStyle,),
      onChanged: (String? newValue) {
      setState(() {
      selectedItem = newValue;
      });
      },

      items: list.map<DropdownMenuItem<String>>((dynamic value) {
      return DropdownMenuItem<String>(

      value: value,
      child: Text(value.toString()),
      );
      }).toList(),
      ),
      ),
      ),
    ),

                    Text(
                      "Specification",
                      style: FTextStyle.formLabelTxtStyle,
                    ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimation2']!,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          height:
                          (displayType == 'desktop' || displayType == 'tablet')
                              ? 40
                              : 38,
                          child: ElevatedButton(
                              onPressed: isButtonEnabled
                                  ? () async {
                                setState(() {
                                  isLoading = true;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  const RequisitionScreen(),
                                  ),
                                );
                                // BlocProvider.of<AuthenticationBloc>(context).add(
                                //   LoginEventHandler(
                                //     email: _email.text.toString(),
                                //     password: _password.text.toString(),
                                //   ),
                                // );
                              }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                backgroundColor: isButtonEnabled
                                    ? AppColors.primaryColour
                                    : AppColors.disableButtonColor,
                              ),
                              child:
                              Text(
                                "Add",
                                style: FTextStyle.loginBtnStyle,
                              )

                            // isLoading? CircularProgressIndicator(color: Colors.white,):Text(
                            //   Constants.loginBtnTxt,
                            //   style: FTextStyle.loginBtnStyle,
                            // )
                          ),
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),



        Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              height:
              (displayType == 'desktop' || displayType == 'tablet')
                  ? 70
                  : 45,
              child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () async {
                    setState(() {
                      isLoading = true;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const RequisitionScreen(),
                      ),
                    );
                    // BlocProvider.of<AuthenticationBloc>(context).add(
                    //   LoginEventHandler(
                    //     email: _email.text.toString(),
                    //     password: _password.text.toString(),
                    //   ),
                    // );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    backgroundColor: isButtonEnabled
                        ? AppColors.primaryColour
                        : AppColors.disableButtonColor,
                  ),
                  child:
                  Text(
                   "Submit",
                    style: FTextStyle.loginBtnStyle,
                  )

                // isLoading? CircularProgressIndicator(color: Colors.white,):Text(
                //   Constants.loginBtnTxt,
                //   style: FTextStyle.loginBtnStyle,
                // )
              ),
            ).animateOnPageLoad(
                animationsMap['imageOnPageLoadAnimation2']!),
          ),
        ),

      ],
    ),
  ),
),
    );
  }
}
