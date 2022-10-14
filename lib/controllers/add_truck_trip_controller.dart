import 'dart:math';

import 'package:city_truck_admin/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddTruckTripController extends GetxController {
  var isadding = false.obs;
  var isdeleteing = false.obs;
  var task_track_id = ''.obs;
  var task_driver_id = ''.obs;
  RxDouble start_lati = RxDouble(0.0);
  RxDouble start_long = RxDouble(0.0);
  RxDouble end_lati = RxDouble(0.0);
  RxDouble end_long = RxDouble(0.0);

  Rx<List<Task>> tasks = Rx<List<Task>>([]);
  Rx<List<Task>> running_tasks = Rx<List<Task>>([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  BitmapDescriptor trucks_marker = BitmapDescriptor.defaultMarker;

  Rxn<LatLng> start_cordinates = Rxn<LatLng>();

  @override
  void onInit() {
    super.onInit();
    tasks.bindStream(gettasks());
    running_tasks.bindStream(get_running_tasks());
    get_marker();
  }

  Stream<List<Task>> gettasks() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .snapshots()
        .map((event) {
      List<Task> task = [];
      for (var element in event.docs) {
        task.add(Task.fromDocunmentSnapshot(element));
      }
      return task;
    });
  }

  get_marker() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/currenttruck.png")
        .then((value) => trucks_marker = value);
  }

  Stream<List<Task>> get_running_tasks() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .where("task_statuss", isEqualTo: 1)
        .snapshots()
        .map((event) {
      List<Task> running = [];
      for (var element in event.docs) {
        running.add(Task.fromDocunmentSnapshot(element));
      }
      get_running_truck_marker();
      get_marker();
      return running;
    });
  }

// for map view
  void get_running_truck_marker() {
    if (running_tasks.value.isNotEmpty) {
      for (var element in running_tasks.value) {
        markers.value.add(
          Marker(
            markerId: MarkerId(element.id),
            position: LatLng(element.current_lat, element.current_long),
            icon: trucks_marker,
            onTap: () {
              Get.defaultDialog(
                  title: "",
                  content: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('drivers')
                          .doc(element.driver_id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/profile.png"),
                                    radius: 30,
                                  ),
                                  Text(snapshot.data!["name"]),
                                  Text(snapshot.data!["phone"]),
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      }));
            },
          ),
        );
      }
    } else {
      markers.value.add(const Marker(
          markerId: MarkerId("admin"), position: LatLng(9.005401, 38.763611)));
    }
  }

  Future<void> add_TruckTrip(Task task) async {
    isadding.value = true;
    if (task_driver_id.value.isEmpty || task_track_id.value.isEmpty) {
      Get.snackbar("Assign truck and driver ", "",
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
    } else {
      firestore.collection("Tasks").add({
        "task_type": task.task_type,
        "start_lat": start_lati.value,
        "start_long": start_long.value,
        "end_lat": end_lati.value,
        "end_long": end_long.value,
        "current_lat": task.current_lat,
        "current_long": task.current_long,
        "load_carring": task.load_carring,
        "date": task.date,
        "truck": task_track_id.value.toString(),
        "driver": task_driver_id.value.toString(),
        "total_km": task.total_kilometer,
        "total_task": task.total_task,
        "task_statuss": task.statuss,
        "start_location": task.start_location,
        "end_location": task.end_location
      }).then((value) {
      
        firestore
            .collection("drivers")
            .doc(task_driver_id.value)
            .collection("notification")
            .add({
          "title": "New task",
          "task_desc":
              "${task.task_type} from ${task.start_location} To ${task.end_location}"
        }).then((value) {
           isadding.value = false;
        task_driver_id.value = '';
        task_track_id.value = '';

          Get.snackbar("Task added", "",
              snackPosition: SnackPosition.BOTTOM,
              padding: const EdgeInsets.all(5),
              duration: const Duration(seconds: 4));
        });

        Get.offNamed("/homepage");
      }).catchError((error) {
        isadding.value = false;
        Get.snackbar("Error", error.toString(),
            snackPosition: SnackPosition.BOTTOM,
            padding: const EdgeInsets.all(5),
            duration: const Duration(seconds: 4));
      });
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    var result = 12742 * asin(sqrt(a));
    return result.ceilToDouble();
  }

  Future<void> delete_trip(String id) async {
    isdeleteing.value = true;
    await FirebaseFirestore.instance
        .collection("Tasks")
        .doc(id)
        .delete()
        .then((value) {
      isdeleteing.value = false;
      Get.snackbar("Task deleted succesfully", "",
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
      Get.offNamed("/homepage");
    }).catchError((error) {
      isdeleteing.value = false;
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.all(5),
          duration: const Duration(seconds: 4));
    });
  }
}
