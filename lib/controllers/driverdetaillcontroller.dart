import 'package:get/get.dart';

class DriverdetalController extends GetxController {
  var current_driver_item = 0.obs;

  Rx<List<String>> item_driver_menu_list =
      Rx<List<String>>(["Driver Trip History", "Helpers"]);

  void change_menu(int index) {
    current_driver_item.value = index;
  }
}
