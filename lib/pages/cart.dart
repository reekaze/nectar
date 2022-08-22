import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/cart_controller.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Cart",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0XFFE2E2E2),
                ),
                SizedBox(
                  height: 20,
                ),
                if (cartController.isLoading.value)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else if (cartController.cartsData.isNotEmpty)
                  ...cartController.cartsData.map(
                    (data) {
                      int index = cartController.cartsData.indexOf(data);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: cartController.productInfoData[index]["image"],
                                    height: 70,
                                    width: 70,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartController.productInfoData[index]["name"],
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                                        ),
                                        Text(
                                          cartController.productInfoData[index]["unit"],
                                          style: TextStyle(color: Color(0XFF7C7C7C), fontWeight: FontWeight.bold, fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await cartController.removeItem(index, data["total"], "remove");
                                              },
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                child: Icon(Icons.remove, color: Color(0XFF53B175)),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(17),
                                                    border: Border.all(
                                                      color: Color(
                                                        0XFFF0F0F0,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(data["total"].toString()),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await cartController.addItem(index, data["total"]);
                                              },
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                child: Icon(Icons.add, color: Color(0XFF53B175)),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(17),
                                                    border: Border.all(
                                                      color: Color(
                                                        0XFFF0F0F0,
                                                      ),
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await cartController.removeItem(index, data["total"], "close");
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Color(0XFFB3B3B3),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "\$ ${(double.parse(cartController.productInfoData[index]["price"]) * data["total"]).toStringAsFixed(2)} ",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0XFFE2E2E2),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
            if (cartController.cartsData.isEmpty && cartController.isLoading.isFalse)
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty cart.png",
                    ),
                    Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            else if (cartController.isLoading.isFalse)
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        bottomSheet();
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Checkout",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "\$ ${cartController.totalPrice.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0XFF489E67),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0XFF53B175), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19))),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet() => Get.bottomSheet(
        DraggableScrollableSheet(
          initialChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              child: ListView(
                controller: scrollController,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0XFFE2E2E2),
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyle(
                                color: Color(0XFF7C7C7C),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Select Method",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Color(0XFFE2E2E2),
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment",
                              style: TextStyle(
                                color: Color(0XFF7C7C7C),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/card.png"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Color(0XFFE2E2E2),
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Promo Code",
                              style: TextStyle(
                                color: Color(0XFF7C7C7C),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Pick Discount",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Color(0XFFE2E2E2),
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total cost",
                              style: TextStyle(
                                color: Color(0XFF7C7C7C),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$ ${cartController.totalPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Color(0XFFE2E2E2),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "By placing an order you agree to our",
                          style: TextStyle(
                            color: Color(0XFF7C7C7C),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Terms ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "And ",
                                style: TextStyle(
                                  color: Color(0XFF7C7C7C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "Conditions",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CustomElevatedButton(
                            text: "Place Order",
                            size: 16,
                            onPressed: () async {
                              await cartController.checkOut();
                              Navigator.pop(context);
                              Get.offNamed('/orderAccepted');
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            );
          },
        ),
      );
}
