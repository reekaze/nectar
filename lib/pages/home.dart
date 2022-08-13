import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/home_controller.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text("Home, username : ${homeController.username.value}")),
          Text("Phone : ${homeController.phone.value}"),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offNamed('/login');
              },
              child: Text("Logout"))
        ],
      ),
    ));
  }
}
