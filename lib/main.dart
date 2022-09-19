import 'package:city_truck_admin/screens/addhelper.dart';
import 'package:city_truck_admin/screens/addriver.dart';
import 'package:city_truck_admin/screens/addtruck.dart';
import 'package:city_truck_admin/screens/addtrucktrip.dart';
import 'package:city_truck_admin/screens/driverinfo.dart';
import 'package:city_truck_admin/screens/homepage.dart';
import 'package:city_truck_admin/screens/homesplash.dart';
import 'package:city_truck_admin/screens/mydrivers.dart';
import 'package:city_truck_admin/screens/mytrucks.dart';
import 'package:city_truck_admin/screens/signin.dart';
import 'package:city_truck_admin/screens/signup.dart';
import 'package:city_truck_admin/screens/track_track.dart';
import 'package:city_truck_admin/screens/tracktruckdetail.dart';
import 'package:city_truck_admin/screens/truckinfo.dart';
import 'package:city_truck_admin/screens/verify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'binding/appbinding.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      title: 'City Truck',
      defaultTransition: Transition.fade,
      theme: ThemeData(
          fontFamily: "Myappfont",
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: "/homesplash",
      getPages: [
        GetPage(name: "/homesplash", page: () => const HomeSplash()),
        GetPage(name: "/signin", page: () => SignIn()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/verify", page: () => const Verify()),
        GetPage(name: "/homepage", page: () => const Homepage()),
        GetPage(name: "/mytrucks", page: () => const Mytrucks()),
        GetPage(name: "/truckinfo", page: () => TruckInfo()),
        GetPage(name: "/addtruck", page: () => AddTruck()),
        GetPage(name: "/mydrivers", page: () => const Mydrivers()),
        GetPage(name: "/addrivers", page: () => AddDriver()),
        GetPage(name: "/driverinfo", page: () => DriverInfo()),
        GetPage(name: "/addhelper", page: () => AddHelper()),
        GetPage(name: "/tracktruck", page: () => TrackTrack()),
        GetPage(name: "/tracktruckdetail", page: () => TrackTruckDetail()),
        GetPage(name: "/addtrucktrip", page: () => AddTruckTrip()),
      ],
    );
  }
}
