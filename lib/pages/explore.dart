import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/explore_controller.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);
  ExploreConroller exploreConroller = Get.put(ExploreConroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
