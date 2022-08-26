import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/verification_controller.dart';
import 'package:nectar/widgets/custom_scaffold.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({Key? key}) : super(key: key);
  VerificationController verificationController = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 233,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.png"), fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 233,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/background2.jpg"), fit: BoxFit.cover),
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Enter your 6-digit code",
                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Code",
                        style: TextStyle(color: Color(0XFF7C7C7C), fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PinCodeTextField(
                        keyboardType: TextInputType.number,
                        appContext: context,
                        controller: verificationController.pinCodeController.value,
                        length: 6,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeFillColor: Color(0XFF53b175).withOpacity(0.5),
                            inactiveFillColor: Colors.blue.withOpacity(0.5),
                            inactiveColor: Colors.blue,
                            selectedFillColor: Colors.blue.withOpacity(0.5)),
                        enableActiveFill: true,
                        onCompleted: (value) {
                          verificationController.userInputtedOTP();
                          verificationController.pinCodeController.value.text = "";
                          verificationController.codeController.value.text = "";
                        },
                        onChanged: (value) {
                          verificationController.changeCodeControllerValue(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Visibility(
                      visible: verificationController.isResendVisible.value,
                      child: GestureDetector(
                          onTap: () {
                            verificationController.resendOTP();
                          },
                          child: Text("Resend Code", style: TextStyle(color: Color(0XFF53b175), fontWeight: FontWeight.bold))),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Color(0XFF53b175),
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {},
                        child: SizedBox(
                          height: 67,
                          width: 67,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
