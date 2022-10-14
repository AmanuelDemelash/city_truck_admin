import 'package:city_truck_admin/controllers/addtruck_controller.dart';
import 'package:city_truck_admin/controllers/truckdetailcontroller.dart';
import 'package:city_truck_admin/model/truck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruckInfo extends StatelessWidget {
  TruckInfo({Key? key}) : super(key: key);

  final Truck _truck = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
              onPressed: () {
                Get.find<TruckdetailController>().current_item.value = 0;
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<AddtruckController>().delete_truck(_truck.id);
                },
                icon: const Icon(Icons.delete, color: Colors.white))
          ],
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(_truck.truckmodel,
                style: const TextStyle(
                  color: Colors.white,
                )),
            background: Hero(
              tag: "truckimage",
              child: Image(
                  fit: BoxFit.cover, image: NetworkImage(_truck.truck_image)),
            ),
          ),
        ),
        SliverFillRemaining(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          2,
                          (index) => Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: TextButton(
                                  onPressed: () {
                                    Get.find<TruckdetailController>()
                                        .change_menu(index);
                                  },
                                  child: Text(
                                    Get.find<TruckdetailController>()
                                        .item_menu_list
                                        .value[index]
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight:
                                          Get.find<TruckdetailController>()
                                                      .current_item
                                                      .value ==
                                                  index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      fontSize:
                                          Get.find<TruckdetailController>()
                                                      .current_item
                                                      .value ==
                                                  index
                                              ? 16
                                              : 13,
                                      color: Get.find<TruckdetailController>()
                                                  .current_item
                                                  .value ==
                                              index
                                          ? Colors.orange
                                          : Colors.black45,
                                    ),
                                  )))),
                    )),
                Obx(
                  () => IndexedStack(
                    index: Get.find<TruckdetailController>().current_item.value,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              initialValue: _truck.truckmodel,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text("Model")),
                            ),
                            TextFormField(
                              initialValue: "In Transist",
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text("Current status")),
                            ),
                            TextFormField(
                              initialValue: _truck.paltenumber,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text("Truck Number")),
                            ),
                            TextFormField(
                              initialValue: _truck.loadcapacity,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text("Max Load Capacity")),
                            ),
                            TextFormField(
                              initialValue: _truck.insured_date,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text("Insured Due Date")),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: Get.width,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ElevatedButton(

                                    onPressed: () {},
                                    child: const Text("Update Truck Info",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                            fontSize: 20))),
                              ),
                            )
                          ],
                        )),
                      ),
                      AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: _truck.driver_id.isEmpty
                              ? Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    color: Colors.orange,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.find<AddtruckController>()
                                              .assign_driver(_truck.id);
                                        },
                                        child: const Text(
                                          "Assign driver",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                )
                              : StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("drivers")
                                      .doc(_truck.driver_id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return Form(
                                        child: Column(
                                      children: [
                                        TextFormField(
                                          initialValue: snapshot.data!["name"],
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              label: Text("Driver Name")),
                                        ),
                                        TextFormField(
                                          initialValue:
                                              snapshot.data!["experiance"],
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              label: Text("Driver Experiance")),
                                        ),
                                        TextFormField(
                                          initialValue:
                                              snapshot.data!["total_trip"],
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              label: Text("Number of Trip")),
                                        ),
                                        TextFormField(
                                          initialValue: snapshot.data!["phone"],
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              label: Text("Phone Number")),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          width: Get.width,
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ElevatedButton(

                                                onPressed: () {},
                                                child:const Padding(
                                                  padding:  EdgeInsets.all(8.0),
                                                  child:  Text(
                                                      "Update Driver Info",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 2,
                                                          fontSize: 20)),
                                                )),
                                          ),
                                        )
                                      ],
                                    ));
                                  })),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
