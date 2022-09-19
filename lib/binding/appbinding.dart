import 'package:city_truck_admin/controllers/add_driver_controller.dart';
import 'package:city_truck_admin/controllers/add_helper_controller.dart';
import 'package:city_truck_admin/controllers/add_truck_trip_controller.dart';
import 'package:city_truck_admin/controllers/addtruck_controller.dart';
import 'package:city_truck_admin/controllers/auth_controller.dart';
import 'package:city_truck_admin/controllers/splash_controller.dart';
import 'package:city_truck_admin/controllers/tracktruckdetailcontroller.dart';
import 'package:city_truck_admin/controllers/truckdetailcontroller.dart';
import 'package:get/get.dart';

import '../controllers/driverdetaillcontroller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TruckdetailController());
    Get.put(DriverdetalController());
    Get.put(TrackTruckdetailController());
    Get.put(SplashController());
    Get.put(AuthController());
    Get.put(AddtruckController());
    Get.put(AddDriverController());
    Get.put(AddHelperController());
    Get.put(AddTruckTripController());
  }
}
