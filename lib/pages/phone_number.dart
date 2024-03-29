import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/phone_number_controller.dart';
import 'package:nectar/widgets/custom_scaffold.dart';

class PhoneNumberPage extends StatelessWidget {
  PhoneNumberPage({Key? key}) : super(key: key);
  List<List<String>> country = [
    ["62", "ID"],
    ["60", "MY"],
    ["65", "SG"],
    ["1", "US"],
    ["", "Other"]
  ];

  PhoneNumberController phoneNumberController = Get.put(PhoneNumberController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 233,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.png"), fit: BoxFit.cover)),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Enter your phone number",
                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Phone Number",
                        style: TextStyle(color: Color(0XFF7C7C7C), fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            SizedBox(
                              width: phoneNumberController.selectedCountry.value == "" ? 60 : 50,
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(border: InputBorder.none),
                                  iconSize: 15,
                                  icon: Visibility(
                                      visible: phoneNumberController.selectedCountry.value == "" ? true : false, child: Icon(Icons.arrow_downward)),
                                  hint: Text(
                                    "Code",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  items: country.map((c) {
                                    return DropdownMenuItem(
                                        value: c[0],
                                        child: c[1] != "Other"
                                            ? Row(
                                                children: [
                                                  Flag.fromString(
                                                    c[1],
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ],
                                              )
                                            : Text("Other", style: TextStyle(fontWeight: FontWeight.bold)));
                                  }).toList(),
                                  onChanged: (value) {
                                    phoneNumberController.changeSelectedCountry(value.toString());
                                  }),
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: phoneNumberController.numberController.value,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                decoration: InputDecoration(
                                    prefixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
                                    prefixIcon:
                                        phoneNumberController.selectedCountry.value != "" && phoneNumberController.selectedCountry.value != "0"
                                            ? Text(
                                                "+${phoneNumberController.selectedCountry.value.toString()}",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                              )
                                            : Text(""),
                                    border: InputBorder.none),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0XFFE2E2E2),
                      )
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 233,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/background2.jpg"), fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ClipOval(
                child: Material(
                  color: Color(0XFF53b175),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Get.toNamed('/verification');
                    },
                    child: SizedBox(
                      height: 67,
                      width: 67,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
