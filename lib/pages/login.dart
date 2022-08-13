import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/login_controller.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = false;
  LoginController loginController = Get.put(LoginController());

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
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background2.jpg"),
                          fit: BoxFit.cover))),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 233,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover)),
                  child: Image.asset("assets/images/nectar.png"),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 29),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Enter your emails and password",
                          style: TextStyle(
                              color: Color(0XFF7C7C7C),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              color: Color(0XFF7C7C7C),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: loginController.emailController.value,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0XFFE2E2E2), width: 1))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                              color: Color(0XFF7C7C7C),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: loginController.passwordController.value,
                          obscuringCharacter: '●',
                          obscureText:
                              loginController.visibility.value ? false : true,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing:
                                  loginController.visibility.value ? 1 : 4),
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () => loginController.changeVisibility(),
                                child: SizedBox(
                                  child: Icon(
                                    loginController.visibility.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Color(0XFF7C7C7C),
                                  ),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0XFFE2E2E2), width: 1))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CUstomElevatedButton(
                              text: "Login",
                              size: 18,
                              onPressed: () {
                                loginController.login();
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/signUp');
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0XFF53B175)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Forgot",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text("Password?",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          "Or login with :",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0XFF828282),
                              fontWeight: FontWeight.bold),
                        )),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          "assets/images/google.png",
                                        ),
                                      ),
                                      Text(
                                        "Google",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(19))),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          "assets/images/fb.png",
                                        ),
                                      ),
                                      Text(
                                        "Facebook",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0XFF3a5897),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(19))),
                              ),
                            ),
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
