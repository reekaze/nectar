import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  Widget body;
  Color? backgroundColor;
  Widget? bottomNavigationBar;
  bool? resizeToAvoidBottomInset;
  CustomScaffold({Key? key, required this.body, this.backgroundColor, this.bottomNavigationBar, this.resizeToAvoidBottomInset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: true,
        backgroundColor: backgroundColor ?? Colors.white,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
