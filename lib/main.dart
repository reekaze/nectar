import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nectar/pages/get_started.dart';
import 'package:nectar/pages/home.dart';
import 'package:nectar/pages/login.dart';
import 'package:nectar/pages/phone_number.dart';
import 'package:nectar/pages/select_location.dart';
import 'package:nectar/pages/sign_up.dart';
import 'package:nectar/pages/verification.dart';

main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nectar",
      theme: ThemeData(fontFamily: "Poppins"),
      initialRoute: 'getStarted',
      getPages: [
        GetPage(name: '/getStarted', page: () => GetStartedPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signUp', page: () => SignUpPage()),
        GetPage(name: '/phoneNumber', page: () => PhoneNumberPage()),
        GetPage(name: '/verification', page: () => VerificationPage()),
        GetPage(name: '/selectLocation', page: () => SelectLocationPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
