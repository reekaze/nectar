import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/cart_controller.dart';
import 'package:nectar/controllers/home_controller.dart';
import 'package:nectar/pages/Explore.dart';
import 'package:nectar/pages/account.dart';
import 'package:nectar/pages/cart.dart';
import 'package:nectar/pages/favourite.dart';
import 'package:nectar/pages/shop.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  CartController cartController = Get.put(CartController());
  List<Widget> pages = [
    ShopPage(),
    ExplorePage(),
    CartPage(),
    FavouritePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScaffold(
        body: pages[homeController.selectedNavBar.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [BoxShadow(color: Colors.black38.withOpacity(0.2), blurRadius: 10)]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.black,
              selectedItemColor: Color(0XFF53B175),
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/shop.svg",
                      color: homeController.selectedNavBar == 0 ? Color(0XFF53B175) : Colors.black,
                    ),
                    label: "Shop"),
                BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 24,
                      child: SvgPicture.asset(
                        "assets/images/explore.svg",
                        color: homeController.selectedNavBar == 1 ? Color(0XFF53B175) : Colors.black,
                      ),
                    ),
                    label: "Explore"),
                BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 24,
                      child: SvgPicture.asset(
                        "assets/images/cart.svg",
                        color: homeController.selectedNavBar == 2 ? Color(0XFF53B175) : Colors.black,
                      ),
                    ),
                    label: "Cart"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/favourite.svg",
                      color: homeController.selectedNavBar == 3 ? Color(0XFF53B175) : Colors.black,
                    ),
                    label: "Favourite"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/account.svg",
                      color: homeController.selectedNavBar == 4 ? Color(0XFF53B175) : Colors.black,
                    ),
                    label: "Account"),
              ],
              currentIndex: homeController.selectedNavBar.value,
              onTap: (value) {
                homeController.selectedNavBar.value = value;
                if (value == 2) {
                  cartController.getData();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
