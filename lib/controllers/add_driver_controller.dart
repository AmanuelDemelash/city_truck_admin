import 'dart:io';

import 'package:city_truck_admin/model/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddDriverController extends GetxController {
  var driver_image = ''.obs;
  var isadding = false.obs;
  var isdelating = false.obs;
  var isupdateing = false.obs;
  Rx<List<Driver>> drivers = Rx<List<Driver>>([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    drivers.bindStream(getdrivers());
  }

  getimage() async {
    Get.defaultDialog(
      title: "Pick Truck image",
      barrierDismissible: true,
      content: Container(),
      radius: 10,
      contentPadding: const EdgeInsets.all(15),
      actions: [
        TextButton(
          onPressed: () async {
            var image =
                (await ImagePicker().pickImage(source: ImageSource.camera))!;
            driver_image.value = image.path;
          },
          child: const Text("From Camera"),
        ),
        TextButton(
          onPressed: () async {
            var image =
                (await ImagePicker().pickImage(source: ImageSource.gallery))!;
            driver_image.value = image.path;
          },
          child: const Text("From Gallery"),
        )
      ],
    );
  }

  Future<void> add_Driver(Driver driver) async {
    isadding.value = true;
    String url = await uploadPic(File(driver_image.value));
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(email: driver.email, password: "truck1")
        .then((value) {
      firestore.collection("drivers").doc(auth.currentUser!.uid).set({
        "name": driver.name,
        "phone": driver.phone,
        "email": driver.email,
        "experiance": driver.experiance,
        "license": driver.license,
        "image": url,
        "rate": driver.rate,
        "total_trip": driver.total_trip,
        "total_comp_task": driver.total_comp_task
      }).then((value) {
        isadding.value = false;
        Get.snackbar("Driver added", "",
            snackPosition: SnackPosition.BOTTOM,
            padding: const EdgeInsets.all(5),
            duration: const Duration(seconds: 4));
        driver_image.value = '';
        Get.offNamed("/mydrivers");
      });
    }).catchError((error) {
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
    });
  }

  Future<String> uploadPic(File imagefile) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    //Create a reference to the location you want to upload to in firebase
    var reference = storage.ref().child("DriversImage/${imagefile.path}");

    //Upload the file to firebase
    var uploadTask = reference.putFile(imagefile);
    String url = await uploadTask.then((p0) => p0.ref.getDownloadURL());
    return url;
  }

  Stream<List<Driver>> getdrivers() {
    return FirebaseFirestore.instance
        .collection("drivers")
        .snapshots()
        .map((event) {
      List<Driver> driver = [];
      for (var element in event.docs) {
        driver.add(Driver.fromdocumentsnapshot(element));
      }
      return driver;
    });
  }

  Future<void> delete_driver(String id) async {
    Get.defaultDialog(
      title: "Delete Driver?",
      barrierDismissible: true,
      content: Container(
        child: Center(
          child: isdelating.value == true ? CircularProgressIndicator() : null,
        ),
      ),
      radius: 10,
      contentPadding: const EdgeInsets.all(15),
      actions: [
        TextButton(
          onPressed: () async {
            Get.back();
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
            isdelating.value == true;
            await FirebaseFirestore.instance
                .collection("drivers")
                .doc(id)
                .delete()
                .then((value) {
              isdelating.value == false;

              Get.back();
              Get.offNamed("/mydrivers");
            }).catchError((error) {
              Get.snackbar("Error", error.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(seconds: 4));
            });
          },
          child: const Text("Yes"),
        )
      ],
    );
  }

  Future<void> update_driver_info(
      String id, String totaltrip, String expi, String total_comp_task) async {
    isupdateing.value = true;
    await FirebaseFirestore.instance.collection("drivers").doc(id).update({
      'total trip': totaltrip,
      'total_comp_task': total_comp_task,
      'experiance': expi
    }).then((value) {
      isupdateing.value = false;
      Get.snackbar("Updated", "",
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(2),
          duration: const Duration(seconds: 4));
    }).catchError((error) {
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
    });
  }
}
