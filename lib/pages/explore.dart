import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

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
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              Text("data"),
              Text("data"),
              Text("data"),
              Text("data"),
            ],
          )
        ],
      ),
    );
  }
}
