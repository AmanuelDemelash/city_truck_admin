import 'dart:io';
import 'package:city_truck_admin/controllers/add_driver_controller.dart';
import 'package:city_truck_admin/model/truck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddtruckController extends GetxController {
  var picked_image = ''.obs;
  var isadding = false.obs;
  var isdelating = false.obs;
  Rx<List<Truck>> trucks = Rx<List<Truck>>([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    trucks.bindStream(gettrucks());
  }

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
            picked_image.value = image.path;
          },
          child: const Text("From Camera"),
        ),
        TextButton(
          onPressed: () async {
            var image =
                (await ImagePicker().pickImage(source: ImageSource.gallery))!;
            picked_image.value = image.path;
          },
          child: const Text("From Gallery"),
        )
      ],
    );
  }

  Future<void> addtruck(Truck track) async {
    isadding.value = true;
    String url = await uploadPic(File(picked_image.value));

    firestore.collection("trucks").add({
      "truck_model": track.truckmodel,
      "plate_num": track.paltenumber,
      "load_capacity": track.loadcapacity,
      "year": track.year,
      "insured_date": track.insured_date,
      "truck_image": url,
      "driver_id": ""
    }).then((value) {
      // FirebaseAuth.instance.currentUser!.sendEmailVerification();
      isadding.value = false;
      Get.snackbar("Truck added", "",
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
      picked_image.value = '';
      Get.toNamed("/mytrucks");
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
    var reference = storage.ref().child("TrucksImage/${imagefile.path}");

    //Upload the file to firebase
    var uploadTask = reference.putFile(imagefile);
    String url = await uploadTask.then((p0) => p0.ref.getDownloadURL());
    return url;
  }

  Stream<List<Truck>> gettrucks() {
    return FirebaseFirestore.instance
        .collection("trucks")
        .snapshots()
        .map((event) {
      List<Truck> truck = [];
      for (var element in event.docs) {
        truck.add(Truck.fromdocumentsnapshot(element));
      }
      return truck;
    });
  }

  Future<void> delete_truck(String id) async {
    Get.defaultDialog(
      title: "Delete Truck?",
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
                .collection("trucks")
                .doc(id)
                .delete()
                .then((value) {
              Get.back();
              isdelating.value == false;

              Get.back();
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

  Future<void> assign_driver(String id) async {
    Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Get.find<AddDriverController>().drivers.value.isEmpty
              ? const Center(
                  child: Text("no driver found!!"),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount:
                      Get.find<AddDriverController>().drivers.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        onTap: () {
                          firestore.collection("trucks").doc(id).update({
                            'driver_id': Get.find<AddDriverController>()
                                .drivers
                                .value[index]
                                .id
                          }).then((value) => Get.back());
                        },
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                Get.find<AddDriverController>()
                                    .drivers
                                    .value[index]
                                    .driver_image),
                          ),
                        ),
                        title: Text(
                          Get.find<AddDriverController>()
                              .drivers
                              .value[index]
                              .name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text("M.Number: "),
                                Text(
                                    Get.find<AddDriverController>()
                                        .drivers
                                        .value[index]
                                        .phone,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        }));
  }
}
