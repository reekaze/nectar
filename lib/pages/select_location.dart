import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/select_location_controller.dart';
import 'package:nectar/widgets/custom_elevated_button.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class SelectLocationPage extends StatelessWidget {
  SelectLocationPage({Key? key}) : super(key: key);
  SelectLocationController selectLocationController =
      Get.put(SelectLocationController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: Color(0XFFfcfcfd),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 233,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background2.jpg"),
                          fit: BoxFit.cover))),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 233,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(child: Image.asset("assets/images/location.png")),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Select Your Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Switch on your location to stay in tune with what's happening in your area",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0XFF7C7C7C),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Your Country",
                          style: TextStyle(
                              color: Color(0XFF7C7C7C),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0XFFE2E2E2)))),
                            child: DropdownButtonFormField(
                              icon: Icon(Icons.keyboard_arrow_down),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              hint: Text("Select your country"),
                              items: selectLocationController.country
                                  .map((country) {
                                return DropdownMenuItem(
                                    value: country.code,
                                    child: Text(
                                      country.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ));
                              }).toList(),
                              onChanged: (value) async {
                                selectLocationController
                                    .changeSelectedCountryCode(
                                        value.toString());
                                selectLocationController.city.clear();
                                await selectLocationController
                                    .getCities(value.toString());
                                String countryName = selectLocationController
                                    .country
                                    .firstWhere((country) =>
                                        country.code == value.toString())
                                    .name;
                                selectLocationController
                                    .changeSelectedCountryName(countryName);
                                print(selectLocationController
                                    .selectedCountryName);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Your City",
                          style: TextStyle(
                              color: Color(0XFF7C7C7C),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0XFFE2E2E2)))),
                            child: DropdownButtonFormField(
                              icon: Icon(Icons.keyboard_arrow_down),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              value: selectLocationController.city.isEmpty
                                  ? ""
                                  : selectLocationController.city[0].id,
                              hint: selectLocationController
                                      .selectedCountryName.isEmpty
                                  ? Text("Select your country first")
                                  : Text("wait"),
                              items: selectLocationController.city.map((city) {
                                return DropdownMenuItem(
                                    value: city.id,
                                    child: Text(city.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )));
                              }).toList(),
                              onChanged: (value) {
                                String cityName = selectLocationController.city
                                    .firstWhere(
                                        (city) => city.id == value.toString())
                                    .name;
                                selectLocationController
                                    .changeSelectedCityName(cityName);
                                print(
                                    selectLocationController.selectedCityName);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CUstomElevatedButton(
                              text: "Submit",
                              size: 18,
                              onPressed: () {
                                Get.offAllNamed('/home');
                              }),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
