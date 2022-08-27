import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/explore_controller.dart';
import 'package:nectar/widgets/custom_card.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);
  ExploreConroller exploreConroller = Get.put(ExploreConroller());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: exploreConroller.isVisible.value
            ? Visibility(
                visible: exploreConroller.isVisible.value,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    Center(
                      child: Text(
                        "Find Products",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        exploreConroller.search2.value.text = exploreConroller.search.value.text;
                        if (value != "") {
                          exploreConroller.getSearchData(value);
                          exploreConroller.isVisible2.value = true;
                          exploreConroller.focusNode2.value.requestFocus();
                          exploreConroller.isVisible.value = false;
                        }
                      },
                      controller: exploreConroller.search.value,
                      focusNode: exploreConroller.focusNode.value,
                      decoration: InputDecoration(
                        hintText: "Search Store",
                        hintStyle: TextStyle(color: Color(0XFF7c7c7c), fontWeight: FontWeight.bold),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 25,
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: Color(0XFFF2F3F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        ...exploreConroller.productTypes.map((type) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                '/exploreDetail',
                                arguments: [type[0], type[4]],
                              );
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/${type[1]}",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    type[0],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              color: type[3],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(
                                  color: type[2].withOpacity(0.7),
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      ],
                    )
                  ],
                ),
              )
            : Visibility(
                visible: exploreConroller.isVisible2.value,
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  if (value == "") {
                                    exploreConroller.search.value.text = exploreConroller.search2.value.text;
                                    exploreConroller.isVisible.value = true;
                                    exploreConroller.focusNode.value.requestFocus();
                                    exploreConroller.isVisible2.value = false;
                                  } else {
                                    exploreConroller.getSearchData(value);
                                  }
                                },
                                controller: exploreConroller.search2.value,
                                focusNode: exploreConroller.focusNode2.value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  suffix: GestureDetector(
                                    onTap: () {
                                      exploreConroller.search.value.text = "";
                                      exploreConroller.search2.value.text = "";
                                      exploreConroller.isVisible.value = true;
                                      exploreConroller.focusNode.value.requestFocus();
                                      exploreConroller.isVisible2.value = false;
                                    },
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0XFFC5C5C5)),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Color(0XFFF2F3F2),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset("assets/images/filter.svg")
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (exploreConroller.isLoading.value)
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        else if (exploreConroller.products.isNotEmpty)
                          GridView.count(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: .65,
                            children: exploreConroller.products.map((product) {
                              return CustomCard(
                                name: product.name as String,
                                image: product.image as String,
                                price: product.price as String,
                                unit: product.unit as String,
                                productId: product.productId as String,
                              );
                            }).toList(),
                          )
                      ],
                    ),
                    if (!exploreConroller.isLoading.value && exploreConroller.products.isEmpty)
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/empty box.png"),
                            Text(
                              "Not Found",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
      ),
    );
  }
}
