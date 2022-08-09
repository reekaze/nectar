import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 9),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset("assets/images/nectar_icon.svg"),
          Text(
            "Welcome",
            style: TextStyle(
                color: Colors.white, fontSize: 43, fontWeight: FontWeight.bold),
          ),
          Text(
            "to our store",
            style: TextStyle(
                color: Colors.white, fontSize: 43, fontWeight: FontWeight.bold),
          ),
          Text(
            "Get your groceries in as fast as one hour",
            style: TextStyle(
                fontSize: 15, color: Color(0xFFFCFCFC).withOpacity(0.7)),
          ),
          SizedBox(
            height: 30,
          ),
          CUstomElevatedButton(
              text: "Get Started",
              size: 18,
              onPressed: () {
                Get.toNamed('/login');
              })
        ],
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/get_started.png"),
              fit: BoxFit.cover),
          color: Colors.black),
    ));
  }
}
