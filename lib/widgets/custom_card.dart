import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomCard extends StatelessWidget {
  late String name;
  late String image;
  late String price;
  late String unit;
  late String productId;
  CustomCard({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.unit,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/productDetail', arguments: [productId]);
      },
      child: Container(
        width: 175,
        height: 250,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              unit,
              style: TextStyle(
                color: Color(0Xff7c7c7c),
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ $price",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //add to cart
                        var uid = FirebaseAuth.instance.currentUser!.uid;
                        var data = await FirebaseFirestore.instance.collection("carts").doc(uid).get();
                        Map<String, dynamic> temp1;
                        List<Map<String, dynamic>> temp = [];
                        bool isFirstTimeAdd = true;

                        if (data.data()?["products"] != null) {
                          for (var i = 0; i < data.data()?["products"].length; i++) {
                            if (productId == data.data()!["products"][i]["productId"]) {
                              temp1 = data.data()!["products"][i];
                              temp1["total"] = temp1["total"] + 1;
                              temp.add(temp1);
                              isFirstTimeAdd = false;
                            } else {
                              temp.add(data.data()!["products"][i]);
                            }
                          }
                        }

                        if (isFirstTimeAdd) {
                          temp.add({
                            "productId": productId,
                            "total": 1,
                          });
                        }

                        await FirebaseFirestore.instance.collection("carts").doc(uid).set({
                          "products": [...temp]
                        });

                        //snackbar

                        if (Get.isSnackbarOpen) {
                          Get.closeCurrentSnackbar();
                        }
                        Get.snackbar(
                          "Success",
                          "Add 1 ${name} to cart",
                          backgroundColor: Color(0XFF53B175).withOpacity(0.8),
                        );
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: Color(0xff53b175)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          border: Border.all(color: Color(0xffE2E2E2)),
        ),
      ),
    );
  }
}
