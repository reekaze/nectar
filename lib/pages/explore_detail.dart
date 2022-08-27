import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/explore_detail_controller.dart';
import 'package:nectar/widgets/custom_card.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class ExploreDetailPage extends StatelessWidget {
  ExploreDetailPage({Key? key}) : super(key: key);

  var title = Get.arguments[0];
  ExploreDetailController exploreDetailController = Get.put(ExploreDetailController(Get.arguments[1]));

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.keyboard_arrow_left),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SvgPicture.asset("assets/images/filter.svg")
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (exploreDetailController.isLoading.isTrue)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (exploreDetailController.products.isNotEmpty)
                    GridView.count(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 150 / 225,
                      children: [
                        ...exploreDetailController.products.map((product) {
                          return CustomCard(
                            name: product.name ?? "",
                            image: product.image ?? "",
                            price: product.price ?? "",
                            unit: product.unit ?? "",
                            productId: product.productId ?? "",
                          );
                        }).toList()
                      ],
                    )
                ],
              ),
              if (!exploreDetailController.isLoading.value && exploreDetailController.products.isEmpty)
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
