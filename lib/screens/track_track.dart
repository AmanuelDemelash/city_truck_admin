import 'dart:async';

import 'package:city_truck_admin/controllers/add_truck_trip_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackTrack extends StatefulWidget {
  TrackTrack({Key? key}) : super(key: key);

  @override
  State<TrackTrack> createState() => _TrackTrackState();
}

class _TrackTrackState extends State<TrackTrack> {
  final task = Get.arguments;
  Completer<GoogleMapController> mapcontroller = Completer();

  BitmapDescriptor start_marker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor end_marker = BitmapDescriptor.defaultMarker;
  List<LatLng> polylinecordinates = [];

  get_marker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/pin.png")
        .then((value) => start_marker = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/location.png")
        .then((value) => end_marker = value);
  }

  void getpolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBuJ_8xq4Di2929RJBdk0_yTHLArHycpAU",
        PointLatLng(task.start_loc_lat, task.start_loc_long),
        PointLatLng(task.end_loc_lat, task.end_loc_long));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
        title: const Text(
          "Track Your Truck",
          style: TextStyle(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "delete",
                    content: const Text("Do you want to delete trip?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            Get.find<AddTruckTripController>()
                                .delete_trip(task.id);
                            Get.back();
                          },
                          child: const Text("Yes")),
                    ]);
              },
              icon: const Icon(
                Icons.delete,
              ))
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(task.start_loc_lat, task.start_loc_long),
              zoom: 14.4746,
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
                  markerId: const MarkerId("start"),
                  position: LatLng(task.start_loc_lat, task.start_loc_long),
                  icon: start_marker),
              Marker(
                  markerId: const MarkerId("end"),
                  position: LatLng(task.end_loc_lat, task.end_loc_long),
                  icon: end_marker),
            },
            onMapCreated: (mapController) {
              mapcontroller.complete(mapController);
            },
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('trucks')
                            .doc(task.truck_id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  leading: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        snapshot.data!["truck_image"]),
                                  ),
                                  title: task.statuss == 0
                                      ? const Text(
                                          "Currently Parked",
                                        )
                                      : task.statuss == 1
                                          ? const Text("Currently Running")
                                          : const Text("Trip Complated"),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Text("Since: "),
                                          Text("1h:11min",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Location: "),
                                          Expanded(
                                            child: Text(task.end_location,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : const LinearProgressIndicator();
                        }),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 30),
                  child: Text(
                    "Summary",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.route_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              const Text(
                                "Total Distance",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                Get.find<AddTruckTripController>()
                                    .calculateDistance(
                                        task.start_loc_lat,
                                        task.start_loc_long,
                                        task.end_loc_lat,
                                        task.end_loc_long)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.fire_truck,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                "Total Running",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "1h:56m",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.local_parking_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                "Total Parked",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "1h:33m",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: Get.width,
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RaisedButton.icon(
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(14),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          if (task.statuss == 1) {
                            Get.toNamed("/tracktruckdetail", arguments: task);
                          } else {
                            Get.defaultDialog(
                                title: "Truck is not started..",
                                content: Container(),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("OK"))
                                ]);
                          }
                        },
                        label: task.statuss == 1
                            ? const Text("Track",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    fontSize: 20))
                            : task.statuss == 2
                                ? const Text("Trip Complated",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 20))
                                : const Text("Track",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 20))),
                  ),
                )
              ],
            ),
          ),
          Obx(() => Visibility(
                visible: Get.find<AddTruckTripController>().isdeleteing.value,
                child: Center(
                  child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.orange
                              : Colors.orange.shade300,
                        ),
                      );
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
