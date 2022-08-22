import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class OrderAcceptedPage extends StatelessWidget {
  const OrderAcceptedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Image.asset(
                "assets/images/order accepted.png",
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "Your order has been accepted",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Your items has been placed and is on it's way to being processed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF7C7C7C),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              CustomElevatedButton(
                text: "Track Order",
                size: 16,
                onPressed: () {},
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed('/home');
                },
                child: Center(
                  child: Text(
                    "Back to home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
