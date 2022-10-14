import 'package:city_truck_admin/controllers/add_truck_trip_controller.dart';
import 'package:city_truck_admin/controllers/addtruck_controller.dart';
import 'package:city_truck_admin/model/task.dart';
import 'package:city_truck_admin/utility/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/utils/google_search/place_type.dart';

class AddTruckTrip extends StatelessWidget {
  AddTruckTrip({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  TextEditingController task_start = TextEditingController();
  TextEditingController task_end = TextEditingController();
  TextEditingController task_type = TextEditingController();
  TextEditingController task_load = TextEditingController();
  TextEditingController task_date = TextEditingController();
  TextEditingController task_km = TextEditingController();
  TextEditingController task_total_num = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Add Truck Trip",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ))),
      body: Stack(children: [
        Container(
          height: 50,
          decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.all(10),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          leading: const Icon(
                            Icons.circle,
                            color: Colors.pink,
                          ),
                          title: SearchLocation(
                            apiKey: mapApi,
                            language: 'en',
                            country: 'ET',
                            placeholder: "Start Location",
                            placeType: PlaceType.cities,
                            onSelected: (Place place) async {
                              final geolocation = await place.geolocation;
                              var placelocation = geolocation!.coordinates;
                              Get.find<AddTruckTripController>()
                                  .start_lati
                                  .value = placelocation.latitude;
                              Get.find<AddTruckTripController>()
                                  .start_long
                                  .value = placelocation.longitude;
                              task_start.text = place.description;
                            },
                          )),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.circle,
                          color: Colors.black54,
                          size: 7,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.circle,
                          color: Colors.black54,
                          size: 7,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.circle,
                          color: Colors.black54,
                          size: 7,
                        ),
                      ),
                      ListTile(
                          leading:
                              const Icon(Icons.circle, color: Colors.green),
                          title: SearchLocation(
                            apiKey: mapApi,
                            language: 'en',
                            country: 'ET',
                            placeholder: "End Location",
                            strictBounds: true,
                            placeType: PlaceType.cities,
                            onSelected: (Place place) async {
                              final geolocation = await place.geolocation;
                              var placelocation = geolocation!.coordinates;
                              Get.find<AddTruckTripController>()
                                  .end_lati
                                  .value = placelocation.latitude;
                              Get.find<AddTruckTripController>()
                                  .end_long
                                  .value = placelocation.longitude;
                              task_end.text = place.description;
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                                title: const Text("Trip Task",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: TextFormField(
                                    controller: task_type,
                                    onSaved: (newValue) =>
                                        task_type.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter task type';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        hintText: "Chemical Delivery"))),
                            ListTile(
                                title: const Text("Enter Load Carring",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: TextFormField(
                                    controller: task_load,
                                    onSaved: (newValue) =>
                                        task_load.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter load carring';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        hintText: "16.4 Tonnes"))),
                            ListTile(
                                title: const Text("Select Date",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: TextFormField(
                                    controller: task_date,
                                    onSaved: (newValue) =>
                                        task_date.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter task date';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        hintText: "Mar 20,2022"))),
                            ListTile(
                                title: const Text("Assign Truck",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('trucks')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? DropdownButton<String>(
                                              isExpanded: true,
                                              hint: const Text("add truck"),
                                              //value: task_track_id,
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                              items: List.generate(
                                                  snapshot.data!.docs.length,
                                                  (index) {
                                                var truckData =
                                                    snapshot.data?.docs[index];
                                                return DropdownMenuItem(
                                                  value: truckData!.id,
                                                  child: Text(
                                                    truckData["truck_model"],
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                );
                                              }),
                                              onChanged: (value) {
                                                Get.find<
                                                        AddTruckTripController>()
                                                    .task_track_id
                                                    .value = value!;
                                              })
                                          : const Text("no truck found");
                                    })),
                            ListTile(
                                title: const Text("Assign Drivers",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('drivers')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? DropdownButton<String>(
                                              isExpanded: true,
                                              hint: Text("driver"),
                                              //value: task_driver_id,
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                              items: List.generate(
                                                  snapshot.data!.docs.length,
                                                  (index) {
                                                var driverData =
                                                    snapshot.data?.docs[index];
                                                return DropdownMenuItem(
                                                  value: driverData!.id,
                                                  child: Text(
                                                    driverData["name"],
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                );
                                              }),
                                              onChanged: (value) {
                                                Get.find<
                                                        AddTruckTripController>()
                                                    .task_driver_id
                                                    .value = value!;
                                              })
                                          : const Text("no driver found");
                                    })),
                            ListTile(
                                title: const Text("Total Kilometers",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: task_km,
                                    onSaved: (newValue) =>
                                        task_km.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter total km';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        hintText: "345 Km"))),
                            ListTile(
                                title: const Text("Number of task avaliable",
                                    style: TextStyle(color: Colors.black)),
                                subtitle: TextFormField(
                                    controller: task_total_num,
                                    onSaved: (newValue) =>
                                        task_total_num.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter total task';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        hintText: "1"))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => Visibility(
                            visible: Get.find<AddTruckTripController>()
                                        .isadding
                                        .value ==
                                    true
                                ? false
                                : true,
                            child: Container(
                              width: Get.width,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ElevatedButton(

                                    onPressed: () {
                                      _formkey.currentState!.save();
                                      if (_formkey.currentState!.validate()) {
                                        Task task = Task(
                                            "",
                                            task_type.text,
                                           
                                            0.0, 0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                            task_load.text,
                                            task_date.text,
                                            "",
                                            "",
                                            task_km.text,
                                            task_total_num.text,
                                            0,
                                            task_start.text,
                                            task_end.text);
                                        Get.find<AddTruckTripController>()
                                            .add_TruckTrip(task);
                                      }
                                    },
                                    child:const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:  Text("Add trip",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2,
                                              fontSize: 20)),
                                    )),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
        Obx(() => Visibility(
            visible: Get.find<AddTruckTripController>().isadding.value == true
                ? true
                : false,
            child: SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.orange : Colors.green,
                  ),
                );
              },
            ))),
      ]),
    );
  }
}
