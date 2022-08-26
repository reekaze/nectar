import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nectar/pages/explore_detail.dart';
import 'package:nectar/pages/get_started.dart';
import 'package:nectar/pages/home.dart';
import 'package:nectar/pages/login.dart';
import 'package:nectar/pages/order_accepted.dart';
import 'package:nectar/pages/phone_number.dart';
import 'package:nectar/pages/product_detail.dart';
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

  initRoute() {
    if (FirebaseAuth.instance.currentUser != null) {
      return "/home";
    } else {
      return "/getStarted";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nectar",
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0XFF53B175),
        ),
      ),
      initialRoute: initRoute(),
      getPages: [
        GetPage(name: '/getStarted', page: () => GetStartedPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signUp', page: () => SignUpPage()),
        GetPage(name: '/phoneNumber', page: () => PhoneNumberPage()),
        GetPage(name: '/verification', page: () => VerificationPage()),
        GetPage(name: '/selectLocation', page: () => SelectLocationPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/productDetail', page: () => ProductDetailPage()),
        GetPage(name: '/orderAccepted', page: () => OrderAcceptedPage()),
        GetPage(name: '/exploreDetail', page: () => ExploreDetailPage()),
      ],
    );
  }
}
