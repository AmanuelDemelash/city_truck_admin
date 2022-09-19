import 'dart:io';

import 'package:city_truck_admin/controllers/addtruck_controller.dart';
import 'package:city_truck_admin/model/truck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTruck extends StatelessWidget {
  AddTruck({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  TextEditingController addtruck_model = TextEditingController();
  TextEditingController addtruck_plate = TextEditingController();
  TextEditingController addtruck_maxload = TextEditingController();
  TextEditingController addtruck_year = TextEditingController();
  TextEditingController addtruck_insured = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Add Truck",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Stack(children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        Get.find<AddtruckController>().getimage();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(
                            Get.find<AddtruckController>().picked_image.value)),
                        child: Get.find<AddtruckController>()
                                .picked_image
                                .value
                                .isEmpty
                            ? const Icon(Icons.photo_camera_rounded)
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: GetBuilder<AddtruckController>(
                          init: Get.find<AddtruckController>(),
                          initState: (_) {},
                          builder: (controller) {
                            return Form(
                                key: _formkey,
                                child: Column(children: [
                                  TextFormField(
                                    controller: addtruck_model,
                                    onSaved: (newValue) =>
                                        addtruck_model.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a truck model';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Truck Model",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Truck Model")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: addtruck_plate,
                                    onSaved: (newValue) =>
                                        addtruck_plate.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a plate number';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Plate Number",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Plate Number")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: addtruck_maxload,
                                    onSaved: (newValue) =>
                                        addtruck_maxload.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a load capacity';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Max Load Capacity",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Max Load Capacity")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: addtruck_year,
                                    onSaved: (newValue) =>
                                        addtruck_year.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a year ';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Year",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Year")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: addtruck_insured,
                                    onSaved: (newValue) =>
                                        addtruck_insured.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a Insured date';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                            onTap: () async {},
                                            child:
                                                const Icon(Icons.date_range)),
                                        hintText: "Insured Date",
                                        enabledBorder:
                                            const OutlineInputBorder(),
                                        disabledBorder:
                                            const OutlineInputBorder(),
                                        focusedBorder:
                                            const OutlineInputBorder(),
                                        label: const Text("Insured Date")),
                                  ),
                                ]));
                          })),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: Get.width,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RaisedButton(
                          padding: const EdgeInsets.all(10),
                          color: Colors.orange,
                          textColor: Colors.white,
                          onPressed: () {
                            _formkey.currentState!.save();
                            if (_formkey.currentState!.validate()) {
                              if (Get.find<AddtruckController>()
                                  .picked_image
                                  .value
                                  .isEmpty) {
                                Get.snackbar("Add truck image", "",
                                    snackPosition: SnackPosition.BOTTOM,
                                    padding: const EdgeInsets.all(5),
                                    duration: const Duration(seconds: 4));
                              } else {
                                Truck truck = Truck(
                                    "",
                                    addtruck_model.text,
                                    addtruck_plate.text,
                                    addtruck_maxload.text,
                                    addtruck_year.text,
                                    addtruck_insured.text,
                                    "",
                                    "");
                                Get.find<AddtruckController>().addtruck(truck);
                              }
                            }
                          },
                          child: const Text("Save",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontSize: 20))),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => Visibility(
                visible: Get.find<AddtruckController>().isadding.value == true
                    ? true
                    : false,
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(15),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              )),
        ]));
  }
}
