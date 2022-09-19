import 'dart:io';

import 'package:city_truck_admin/model/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddHelperController extends GetxController {
  var helper_image = ''.obs;
  var isadding = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getimage() {
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
            helper_image.value = image.path;
          },
          child: const Text("From Camera"),
        ),
        TextButton(
          onPressed: () async {
            var image =
                (await ImagePicker().pickImage(source: ImageSource.gallery))!;
            helper_image.value = image.path;
          },
          child: const Text("From Gallery"),
        )
      ],
    );
  }

  Future<void> add_helper(String id, Helper helper) async {
    isadding.value = true;
    String url = await uploadPic(File(helper_image.value));

    firestore.collection("drivers").doc(id).collection("helper").add({
      "name": helper.name,
      "phone": helper.phone,
      "email": helper.email,
      "address": helper.address,
      "total_year_ashelper": helper.total_year,
      "image": url,
    }).then((value) {
      isadding.value = false;
      Get.snackbar("Helper added", "",
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
      helper_image.value = '';
      Get.offNamed("/driverinfo");
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
    var reference = storage.ref().child("HelperImage/${imagefile.path}");

    //Upload the file to firebase
    var uploadTask = reference.putFile(imagefile);
    String url = await uploadTask.then((p0) => p0.ref.getDownloadURL());
    return url;
  }
}
