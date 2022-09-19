import 'package:city_truck_admin/components/mydrawer.dart';
import 'package:city_truck_admin/controllers/add_truck_trip_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/listtask.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "City Truck",
          ),
          bottom: const TabBar(indicatorWeight: 2, tabs: [
            Tab(
              text: "List Task",
            ),
            Tab(
              text: "Map View",
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/addtrucktrip");
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          tooltip: "add trip",
          elevation: 10,
        ),
        drawer: const mydrawer(),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Listtask(),
              SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Obx(() => GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(9.005401, 38.763611),
                          zoom: 13.4746,
                        ),
                        myLocationEnabled: true,
                        markers:
                            Get.find<AddTruckTripController>().markers.value,
                      ))),
            ]),
      ),
    );
  }
}
