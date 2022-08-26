import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  String text;
  double size;
  void Function() onPressed;
  CustomElevatedButton({Key? key, required this.text, required this.size, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(primary: Color(0XFF53B175), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19))),
      ),
    );
  }
}
