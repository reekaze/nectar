import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/shop_controller.dart';
import 'package:nectar/widgets/custom_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopPage extends StatelessWidget {
  ShopPage({Key? key}) : super(key: key);
  ShopController shopPageController = Get.put(ShopController());
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(width: 26, height: 30, child: Image.asset("assets/images/nectar.png")),
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
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0XFF4c4f4d)),
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
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Color(0XFFf2f3f2),
                  hintText: "Search Store",
                  hintStyle: TextStyle(color: Color(0XFF7c7c7c), fontWeight: FontWeight.bold),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 25,
                  ),
                  isDense: true,
                )),
              ),
              SizedBox(height: 15),
              //caraousel
              carousel(context),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Exclusive Offer",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0XFF53B175,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  height: 250,
                  child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      children: shopPageController.isExclusifeOfferLoading.value == false
                          ? shopPageController.exclusiveOffer.map((data) {
                              return Container(
                                margin: EdgeInsets.only(
                                    right: shopPageController.exclusiveOffer.indexOf(data) == shopPageController.exclusiveOffer.length - 1 ? 0 : 15),
                                child: CustomCard(
                                  image: data["image"],
                                  name: data["name"],
                                  price: data["price"],
                                  unit: data["unit"],
                                  productId: data["productId"],
                                ),
                              );
                            }).toList()
                          : [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ]),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Selling",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0XFF53B175,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  height: 250,
                  child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      children: shopPageController.isBestSellingLoading.value == false
                          ? shopPageController.bestSelling.map((data) {
                              return Container(
                                margin: EdgeInsets.only(
                                    right: shopPageController.bestSelling.indexOf(data) == shopPageController.bestSelling.length - 1 ? 0 : 15),
                                child: CustomCard(
                                  image: data["image"],
                                  name: data["name"],
                                  price: data["price"],
                                  unit: data["unit"],
                                  productId: data["productId"],
                                ),
                              );
                            }).toList()
                          : [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ]),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Groceries",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0XFF53B175,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  height: 250,
                  child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      children: shopPageController.isGroceriesLoading.value == false
                          ? shopPageController.groceries.map((data) {
                              return Container(
                                margin: EdgeInsets.only(
                                    right: shopPageController.groceries.indexOf(data) == shopPageController.groceries.length - 1 ? 0 : 15),
                                child: CustomCard(
                                  image: data["image"],
                                  name: data["name"],
                                  price: data["price"],
                                  unit: data["unit"],
                                  productId: data["productId"],
                                ),
                              );
                            }).toList()
                          : [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ]),
                ),
              ),
              SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }

  Widget carousel(context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: CarouselSlider.builder(
                itemCount: 3,
                carouselController: buttonCarouselController,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: "https://ik.imagekit.io/reekaze/banner/banner${index + 1}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 115,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    shopPageController.currentCarouselIndex.value = index;
                  },
                )),
          ),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: shopPageController.currentCarouselIndex.value,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Color(0XFF53b175),
                dotColor: Color(0XFFa9a19c),
                dotHeight: 6,
                dotWidth: 6,
              ),
              onDotClicked: (index) {
                shopPageController.currentCarouselIndex.value = index;
                buttonCarouselController.jumpToPage(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
