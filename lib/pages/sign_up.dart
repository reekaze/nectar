import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/sign_up_controller.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: Color(0XFFfcfcfd),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 233,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background2.jpg"), fit: BoxFit.cover))),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 233,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.png"), fit: BoxFit.cover)),
                  child: Image.asset("assets/images/nectar.png"),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 29),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Enter your credentials to continue",
                          style: TextStyle(color: Color(0XFF7C7C7C), fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Username",
                          style: TextStyle(color: Color(0XFF7C7C7C), fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: signUpController.usernameController.value,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                          decoration:
                              InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0XFFE2E2E2), width: 1))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(color: Color(0XFF7C7C7C), fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: signUpController.emailController.value,
                          onChanged: (value) {
                            signUpController.checkEmailExistence(value.toString());
                          },
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                          decoration: InputDecoration(
                              suffixIcon: (signUpController.isEmailExist.value && signUpController.isEmailControllerEmpty.isFalse)
                                  ? Icon(
                                      Icons.dangerous,
                                      color: Colors.red,
                                    )
                                  : (!signUpController.isEmailExist.value && signUpController.isEmailControllerEmpty.isFalse)
                                      ? Icon(
                                          Icons.done,
                                          color: Color(0XFF53b175),
                                        )
                                      : SizedBox(),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0XFFE2E2E2), width: 1))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(color: Color(0XFF7C7C7C), fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: signUpController.passwordController.value,
                          obscuringCharacter: '●',
                          obscureText: signUpController.visibility.value ? false : true,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: signUpController.visibility.value ? 1 : 4),
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () => signUpController.changeVisibility(),
                                child: SizedBox(
                                  child: Icon(
                                    signUpController.visibility.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    color: Color(0XFF7C7C7C),
                                  ),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0XFFE2E2E2), width: 1))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(style: TextStyle(fontSize: 14, color: Color(0XFF7C7C7C), fontWeight: FontWeight.bold), children: [
                            TextSpan(text: "By continuing you agree to our"),
                            TextSpan(text: " Terms of Service", style: TextStyle(color: Color(0XFF53B175))),
                            TextSpan(text: " and"),
                            TextSpan(text: " Privacy Policy", style: TextStyle(color: Color(0XFF53B175))),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomElevatedButton(
                              text: "Sign Up",
                              size: 18,
                              onPressed: () {
                                signUpController.signUp();
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed("/login");
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0XFF53B175)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
