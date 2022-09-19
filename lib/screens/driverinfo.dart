import 'package:city_truck_admin/controllers/add_driver_controller.dart';
import 'package:city_truck_admin/model/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/driverdetaillcontroller.dart';

class DriverInfo extends StatelessWidget {
  DriverInfo({Key? key}) : super(key: key);

  final Driver mydriver = Get.arguments;
  final _formkey = GlobalKey<FormState>();
  TextEditingController driver_trip = TextEditingController();
  TextEditingController driver_exp = TextEditingController();
  TextEditingController driver_comp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
              onPressed: () {
                Get.find<DriverdetalController>().current_driver_item.value = 0;
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<AddDriverController>().delete_driver(mydriver.id);
                },
                icon: const Icon(Icons.delete, color: Colors.white))
          ],
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              mydriver.name,
              style: const TextStyle(color: Colors.white),
            ),
            background: Hero(
                tag: "driverimage",
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(mydriver.driver_image))),
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
                                    Get.find<DriverdetalController>()
                                        .change_menu(index);
                                  },
                                  child: Text(
                                    Get.find<DriverdetalController>()
                                        .item_driver_menu_list
                                        .value[index]
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight:
                                          Get.find<DriverdetalController>()
                                                      .current_driver_item
                                                      .value ==
                                                  index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      fontSize:
                                          Get.find<DriverdetalController>()
                                                      .current_driver_item
                                                      .value ==
                                                  index
                                              ? 16
                                              : 13,
                                      color: Get.find<DriverdetalController>()
                                                  .current_driver_item
                                                  .value ==
                                              index
                                          ? Colors.orange
                                          : Colors.black45,
                                    ),
                                  )))),
                    )),
                Obx(
                  () => IndexedStack(
                    index: Get.find<DriverdetalController>()
                        .current_driver_item
                        .value,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: driver_trip,
                                  onSaved: (newValue) =>
                                      driver_trip.text != newValue,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter drivers total trip';
                                    }
                                    return null;
                                  },
                                  // initialValue: mydriver.total_trip,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      label: Text("Total Trip")),
                                ),
                                TextFormField(
                                  controller: driver_exp,
                                  onSaved: (newValue) =>
                                      driver_exp.text != newValue,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter drivers experiance';
                                    }
                                    return null;
                                  },
                                  //initialValue: mydriver.experiance,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      label: Text("Driver Experiance")),
                                ),
                                TextFormField(
                                  controller: driver_comp,
                                  onSaved: (newValue) =>
                                      driver_comp.text = newValue!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter drivers total completed task';
                                    }
                                    return null;
                                  },
                                  //initialValue: mydriver.total_comp_task,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      label: Text("Total Completed Task")),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: Get.width,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: RaisedButton(
                                        padding: const EdgeInsets.all(10),
                                        color: Colors.orange,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          _formkey.currentState!.save();
                                          if (_formkey.currentState!
                                              .validate()) {
                                            Get.find<AddDriverController>()
                                                .update_driver_info(
                                                    mydriver.id,
                                                    driver_trip.text,
                                                    driver_exp.text,
                                                    driver_comp.text);
                                          }
                                        },
                                        child: const Text("Update Driver Info",
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('drivers')
                                        .doc(mydriver.id)
                                        .collection('helper')
                                        .snapshots(),
                                    builder: (context, orderSnapshot) {
                                      return orderSnapshot.hasData
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: orderSnapshot
                                                  .data!.docs.length,
                                              itemBuilder: (context, index) {
                                                var helperData = orderSnapshot
                                                    .data?.docs[index];
                                                return Card(
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      radius: 60,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              helperData![
                                                                  "image"]),
                                                    ),
                                                    title: Text(
                                                        helperData["name"]),
                                                    subtitle: Text(
                                                        helperData["phone"]),
                                                  ),
                                                );
                                              },
                                            )
                                          : const Text("no helper found!");
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: Get.width,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: RaisedButton(
                                        padding: const EdgeInsets.all(10),
                                        color: Colors.orange,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Get.toNamed("/addhelper",
                                              arguments: mydriver.id);
                                        },
                                        child: const Text("Add Helpers",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                                fontSize: 20))),
                                  ),
                                )
                              ],
                            ),
                          )),
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
