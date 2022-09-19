import 'dart:async';

import 'package:city_truck_admin/controllers/tracktruckdetailcontroller.dart';
import 'package:city_truck_admin/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackTruckDetail extends StatefulWidget {
  TrackTruckDetail({Key? key}) : super(key: key);

  @override
  State<TrackTruckDetail> createState() => _TrackTruckDetailState();
}

class _TrackTruckDetailState extends State<TrackTruckDetail> {
  late final Task _task = Get.arguments;
  late GoogleMapController mapcontroller;
  bool added = false;

  List<LatLng> polylinecordinates = [];

  BitmapDescriptor start_marker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor end_marker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor truck_marker = BitmapDescriptor.defaultMarker;

  get_marker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/pin.png")
        .then((value) => start_marker = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/location.png")
        .then((value) => end_marker = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/currenttruck.png")
        .then((value) => truck_marker = value);
  }

  void getpolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBuJ_8xq4Di2929RJBdk0_yTHLArHycpAU",
        PointLatLng(_task.start_loc_lat, _task.start_loc_long),
        PointLatLng(_task.end_loc_lat, _task.end_loc_long),
        travelMode: TravelMode.driving);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylinecordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getpolyline();
    get_marker();
  }

  Future<void> move_camera(
      AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) async {
    await mapcontroller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target:
          LatLng(snapshot.data!["current_lat"], snapshot.data!["current_long"]),
      zoom: 14.4746,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Tasks')
                  .doc(_task.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (added) {
                  move_camera(snapshot);
                }
                return snapshot.hasData
                    ? GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(snapshot.data!["current_lat"],
                              snapshot.data!["current_long"]),
                          zoom: 16.4746,
                        ),
                        polylines: {
                          Polyline(
                              polylineId: const PolylineId("route"),
                              points: polylinecordinates,
                              color: Colors.blue,
                              width: 5),
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId("current"),
                            position: LatLng(snapshot.data!["current_lat"],
                                snapshot.data!["current_long"]),
                            icon: truck_marker,
                          ),
                          Marker(
                              markerId: const MarkerId("start"),
                              position: LatLng(
                                  _task.start_loc_lat, _task.start_loc_long),
                              icon: start_marker),
                          Marker(
                              markerId: const MarkerId("end"),
                              position:
                                  LatLng(_task.end_loc_lat, _task.end_loc_long),
                              icon: end_marker),
                        },
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            mapcontroller = controller;
                            added = true;
                          });
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: IconButton(
              onPressed: () {
                Get.find<TrackTruckdetailController>().currentmenuitem.value =
                    0;
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 34,
                color: Colors.orange,
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: Get.find<TrackTruckdetailController>().show.value,
              child: Positioned(
                bottom: 0,
                left: 5,
                right: 5,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  width: Get.width,
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('trucks')
                              .doc(_task.truck_id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListTile(
                                    leading: CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(
                                          snapshot.data!["truck_image"]),
                                    ),
                                    title: Text(snapshot.data!["truck_model"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(snapshot.data!["plate_num"]),
                                    trailing: const Text(
                                      "In transit",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  )
                                : const Text("TRUCK");
                          }),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                2,
                                (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      child: TextButton(
                                          onPressed: () {
                                            Get.find<
                                                    TrackTruckdetailController>()
                                                .changemenu(index);
                                          },
                                          child: Text(
                                            Get.find<
                                                    TrackTruckdetailController>()
                                                .currentmenu_text
                                                .value[index]
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight:
                                                  Get.find<TrackTruckdetailController>()
                                                              .currentmenuitem
                                                              .value ==
                                                          index
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize:
                                                  Get.find<TrackTruckdetailController>()
                                                              .currentmenuitem
                                                              .value ==
                                                          index
                                                      ? 16
                                                      : 13,
                                              color:
                                                  Get.find<TrackTruckdetailController>()
                                                              .currentmenuitem
                                                              .value ==
                                                          index
                                                      ? Colors.orange
                                                      : Colors.black45,
                                            ),
                                          )),
                                    ))),
                          )),
                      Obx(() => IndexedStack(
                            index: Get.find<TrackTruckdetailController>()
                                .currentmenuitem
                                .value,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Task",
                                        style: TextStyle(color: Colors.black)),
                                    Text(
                                      _task.task_type,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Departed",
                                        style: TextStyle(color: Colors.black)),
                                    Text(
                                      _task.date,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Start Location",
                                        style: TextStyle(color: Colors.black)),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          _task.start_location,
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Current Location",
                                        style: TextStyle(color: Colors.black)),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.gps_fixed,
                                          color: Colors.pink,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "${_task.current_lat}, ${_task.current_long}",
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Trip End Location",
                                        style: TextStyle(color: Colors.black)),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          _task.end_location,
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("trucks")
                                      .doc(_task.truck_id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 3),
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text("Vehicle Model",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                        snapshot.data![
                                                            "truck_model"],
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black54)),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text("Vehicle Number",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                        snapshot
                                                            .data!["plate_num"],
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black54)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                        "Max Load Capacity",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                        snapshot.data![
                                                            "load_capacity"],
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black54)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                        "Insured Due Date",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                        snapshot.data![
                                                            "insured_date"],
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black54)),
                                                  ],
                                                ),
                                                StreamBuilder<DocumentSnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("drivers")
                                                        .doc(_task.driver_id)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.hasData
                                                          ? ExpansionTile(
                                                              iconColor:
                                                                  Colors.orange,
                                                              title: const Text(
                                                                  "Driver",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15)),
                                                              children: [
                                                                ListTile(
                                                                  leading:
                                                                      CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            snapshot.data!["image"]),
                                                                  ),
                                                                  title: Text(
                                                                      snapshot.data![
                                                                          "name"],
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  subtitle: Text(
                                                                      snapshot.data![
                                                                          "phone"],
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.black45)),
                                                                  trailing:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await launchUrl(
                                                                              Uri.parse("tel:${snapshot.data!["phone"]}"),
                                                                              mode: LaunchMode.externalApplication,
                                                                            );
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.phone,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                )
                                                              ],
                                                            )
                                                          : const Text(
                                                              "loading..");
                                                    }),
                                                StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('drivers')
                                                        .doc(_task.driver_id)
                                                        .collection('helper')
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.hasData
                                                          ? ExpansionTile(
                                                              iconColor:
                                                                  Colors.orange,
                                                              title: const Text(
                                                                  "Helper",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15)),
                                                              children: [
                                                                ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemCount: snapshot
                                                                            .data!
                                                                            .docs
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var helperData = snapshot
                                                                              .data
                                                                              ?.docs[index];
                                                                          return ListTile(
                                                                            leading:
                                                                                CircleAvatar(
                                                                              backgroundImage: NetworkImage(helperData!["image"]),
                                                                            ),
                                                                            title:
                                                                                const Text("Tekeleab mulu", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                            subtitle:
                                                                                Text(helperData["phone"], style: const TextStyle(color: Colors.black45)),
                                                                            trailing: IconButton(
                                                                                onPressed: () async {
                                                                                  await launchUrl(
                                                                                    Uri.parse("tel:${helperData["phone"]}"),
                                                                                    mode: LaunchMode.externalApplication,
                                                                                  );
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.phone,
                                                                                  size: 30,
                                                                                  color: Colors.black,
                                                                                )),
                                                                          );
                                                                        })
                                                              ],
                                                            )
                                                          : const Text(
                                                              "no helper assigned");
                                                    })
                                              ],
                                            ),
                                          )
                                        : const Text("loading");
                                  })
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 40,
            child: Obx(() => FloatingActionButton(
                onPressed: () {
                  Get.find<TrackTruckdetailController>().show.value == true
                      ? Get.find<TrackTruckdetailController>().show.value =
                          false
                      : Get.find<TrackTruckdetailController>().show.value =
                          true;
                },
                child: Get.find<TrackTruckdetailController>().show.value == true
                    ? const Icon(
                        Icons.close,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.info,
                        color: Colors.white,
                      ))),
          ),
        ],
      ),
    );
  }
}
