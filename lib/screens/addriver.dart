import 'dart:io';

import 'package:city_truck_admin/model/driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_driver_controller.dart';

class AddDriver extends StatelessWidget {
  AddDriver({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  TextEditingController driver_name = TextEditingController();
  TextEditingController driver_phone = TextEditingController();
  TextEditingController driver_email = TextEditingController();
  TextEditingController driver_experiance = TextEditingController();
  TextEditingController driver_license = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Add Driver",
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
              ))),
      body: Stack(
        children: [
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
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Obx(
                            () => InkWell(
                              onTap: () {
                                Get.find<AddDriverController>().getimage();
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(
                                    Get.find<AddDriverController>()
                                        .driver_image
                                        .value)),
                                child: Get.find<AddDriverController>()
                                        .driver_image
                                        .value
                                        .isEmpty
                                    ? const Icon(Icons.add_photo_alternate)
                                    : null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(13),
                            child: Form(
                                key: _formkey,
                                child: Column(children: [
                                  TextFormField(
                                    controller: driver_name,
                                    onSaved: (newValue) =>
                                        driver_name.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a driver name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "driver name",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Name")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: driver_phone,
                                    onSaved: (newValue) =>
                                        driver_phone.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter drivers phone';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "+2519********",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Mobile Number")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: driver_email,
                                    onSaved: (newValue) =>
                                        driver_email.text != newValue,
                                    validator: (value) {
                                      if (value == null ||
                                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                        return 'Enter a valid email!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        hintText: "user@gmail.com",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Email Address")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: driver_experiance,
                                    onSaved: (newValue) =>
                                        driver_experiance.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter drivers experiance';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: "5",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Driver Experiance")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: driver_license,
                                    onSaved: (newValue) =>
                                        driver_license.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter drivers license validity';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: const InputDecoration(
                                        hintText: "3/5/2022",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("License Validity")),
                                  ),
                                ])),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: Get.width,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RaisedButton(
                          padding: const EdgeInsets.all(10),
                          color: Colors.orange,
                          textColor: Colors.white,
                          onPressed: () {
                            _formkey.currentState!.save();
                            if (_formkey.currentState!.validate()) {
                              if (Get.find<AddDriverController>()
                                  .driver_image
                                  .value
                                  .isEmpty) {
                                Get.snackbar("Add driver image", "",
                                    snackPosition: SnackPosition.BOTTOM,
                                    padding: const EdgeInsets.all(5),
                                    duration: const Duration(seconds: 4));
                              } else {
                                Driver driver = Driver(
                                    "",
                                    driver_name.text,
                                    driver_phone.text,
                                    driver_email.text,
                                    driver_experiance.text,
                                    driver_license.text,
                                    "",
                                    1,
                                    "0",
                                    "0");
                                Get.find<AddDriverController>()
                                    .add_Driver(driver);
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
                visible: Get.find<AddDriverController>().isadding.value == true
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
        ],
      ),
    );
  }
}
