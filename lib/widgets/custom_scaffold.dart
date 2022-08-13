import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  Widget body;
  Color? backgroundColor;
  CustomScaffold({Key? key, required this.body, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        body: body,
      ),
    );
  }
}
