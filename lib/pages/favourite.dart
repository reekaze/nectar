import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/favourite_controller.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({Key? key}) : super(key: key);
  FavouriteController favouriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Favourite",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                )),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0XFFE2E2E2),
                ),
                if (favouriteController.isLoading.value)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else if (favouriteController.listFavourite.length > 0)
                  ...favouriteController.listFavourite.map(
                    (data) {
                      var index = favouriteController.listFavourite.indexOf(data);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.network(
                                  data["image"],
                                  width: 70,
                                  height: 70,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["name"],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        data["unit"],
                                        style: TextStyle(
                                          color: Color(0XFF7C7C7C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await Get.toNamed("/productDetail", arguments: [favouriteController.listFavouriteId[index]]);
                                    favouriteController.getData();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "\$ ${data["price"]}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_right)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0XFFE2E2E2),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                SizedBox(
                  height: 100,
                )
              ],
            ),
            if (favouriteController.listFavourite.isEmpty && !favouriteController.isLoading.value)
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty box.png",
                    ),
                    Text(
                      "Your favourite is empty",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              )
            else if (!favouriteController.isLoading.value)
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomElevatedButton(
                    text: "Add All To Cart",
                    size: 16,
                    onPressed: () async {
                      await favouriteController.addAllToCart();
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
