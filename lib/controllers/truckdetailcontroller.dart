import 'package:get/get.dart';

class TruckdetailController extends GetxController {
  var current_item = 0.obs;

  Rx<List<String>> item_menu_list =
      Rx<List<String>>(["Truck Info", "About Driver"]);

  void change_menu(int index) {
    current_item.value = index;
  }
}
