import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 7), () {
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user == null) {
          Get.offNamed("/signin");
        } else {
          Get.offNamed("/homepage");
        }
      });
    });
  }
}
