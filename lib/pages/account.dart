import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/account_controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.blueGrey,
                ),
                decoration: BoxDecoration(color: Color(0XFFF2F3F2), borderRadius: BorderRadius.circular(27)),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        accountController.username.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: Color(0XFF53B175),
                      )
                    ],
                  ),
                  Text(accountController.email ?? "")
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Color(0XFFE2E2E2),
            thickness: 1,
          ),
          ...accountController.listItem.map((item) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(item[0]),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        item[1],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Color(0XFFE2E2E2),
                  thickness: 1,
                ),
              ],
            );
          }).toList(),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAllNamed('/login');
                },
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(alignment: Alignment.centerLeft, child: Icon(Icons.exit_to_app_outlined)),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0XFF53B175),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
