import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/controllers/product_detail_controller.dart';
import 'package:nectar/main.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';
import 'package:nectar/widgets/custom_scaffold.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({Key? key}) : super(key: key);
  ProductDetailController productDetailController = Get.put(ProductDetailController(productId: Get.arguments[0]));

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            "assets/images/back arrow.svg",
                            color: Colors.black,
                          )),
                      SvgPicture.asset(
                        "assets/images/upload.svg",
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Obx(
                  () {
                    if (productDetailController.isLoading.value == true)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              child: Image.network(
                                productDetailController.product.value.image as String,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              ),
                              decoration: BoxDecoration(color: Color(0XFFF2F3F2)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productDetailController.product.value.name as String,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Icon(Icons.favorite_outline),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    productDetailController.product.value.unit as String,
                                    style: TextStyle(
                                      color: Color(0XFF7C7C7C),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            productDetailController.removeCounter();
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: productDetailController.counter.value > 1
                                                ? Color(0XFF53B175)
                                                : Color(
                                                    0XFFB3B3B3,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 45,
                                          height: 45,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              productDetailController.counter.value.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Color(0XFFE2E2E2),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            productDetailController.addCounter();
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Color(0XFF53B175),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "\$ " + (productDetailController.product.value.price as String),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Divider(
                                  color: Color(0XFFE2E2E2),
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productDetailController.isProductDetailHide.value = !productDetailController.isProductDetailHide.value;
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Product Detail",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Icon(
                                          productDetailController.isProductDetailHide.value ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  productDetailController.product.value.detail as String,
                                  style: TextStyle(
                                    color: Color(0XFF7C7C7C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: productDetailController.isProductDetailHide.value || productDetailController.product.value.detail == ""
                                        ? 0
                                        : 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Color(0XFFE2E2E2),
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nutritions",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            "100 gr",
                                            style: TextStyle(color: Color(0XFF7C7C7C), fontWeight: FontWeight.bold, fontSize: 11),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Color(0XFFEBEBEB),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Color(0XFFE2E2E2),
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Review",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            for (var i = 0; i < 5; i++)
                                              Icon(
                                                Icons.star,
                                                color: Color(0XFFF3603F),
                                              )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomElevatedButton(
                  text: "Add To Cart",
                  size: 18,
                  onPressed: () {
                    //snackbar and reset counter value
                    Get.snackbar(
                      "Success",
                      "Add ${productDetailController.counter.value} ${productDetailController.product.value.name} to cart",
                      backgroundColor: Color(0XFF53B175).withOpacity(0.8),
                    );
                    productDetailController.counter.value = 1;
                    //back end add to cart
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
