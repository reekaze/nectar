import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/shop_controller.dart';

class ShopPage extends StatelessWidget {
  ShopPage({Key? key}) : super(key: key);
  ShopPageController shopPageController = Get.put(ShopPageController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
                width: 26,
                height: 30,
                child: Image.asset("assets/images/nectar.png")),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0XFF4c4f4d),
                  ),
                  shopPageController.user.isEmpty
                      ? CircularProgressIndicator()
                      : Text(
                          "${shopPageController.user["city"]}, ${shopPageController.user["country"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0XFF4c4f4d)),
                        )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Color(0XFFf2f3f2),
                    hintText: "Search Store",
                    hintStyle: TextStyle(
                        color: Color(0XFF7c7c7c), fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
              ),
            ),
            SizedBox(height: 10),
            //caraousel
          ],
        )
      ],
    );
  }
}
