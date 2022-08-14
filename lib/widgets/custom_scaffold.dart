import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  Widget body;
  Color? backgroundColor;
  Widget? bottomNavigationBar;
  CustomScaffold(
      {Key? key,
      required this.body,
      this.backgroundColor,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: backgroundColor ?? Colors.white,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
