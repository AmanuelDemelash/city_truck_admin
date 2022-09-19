import 'dart:io';

import 'package:city_truck_admin/controllers/add_helper_controller.dart';
import 'package:city_truck_admin/model/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHelper extends StatelessWidget {
  AddHelper({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  TextEditingController helper_name = TextEditingController();
  TextEditingController helper_phone = TextEditingController();
  TextEditingController helper_email = TextEditingController();
  TextEditingController helper_address = TextEditingController();
  TextEditingController helper_total = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text("Add Helpers"),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios))),
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
                                Get.find<AddHelperController>().getimage();
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(
                                    Get.find<AddHelperController>()
                                        .helper_image
                                        .value)),
                                child: Get.find<AddHelperController>()
                                        .helper_image
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
                                    controller: helper_name,
                                    onSaved: (newValue) =>
                                        helper_name.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a drhelper name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "helper name",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Name")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: helper_phone,
                                    onSaved: (newValue) =>
                                        helper_phone.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a helper phone';
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
                                    controller: helper_email,
                                    onSaved: (newValue) =>
                                        helper_email.text != newValue,
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
                                    controller: helper_address,
                                    onSaved: (newValue) =>
                                        helper_address.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a helper address';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "addis ababa Ethiopia",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Address")),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: helper_total,
                                    onSaved: (newValue) =>
                                        helper_total.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter a helper total year as helper';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: "5",
                                        enabledBorder: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text("Total Year as aHelper")),
                                  ),
                                  const SizedBox(
                                    height: 15,
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
                              if (Get.find<AddHelperController>()
                                  .helper_image
                                  .value
                                  .isEmpty) {
                                Get.snackbar("Add helper image", "",
                                    snackPosition: SnackPosition.BOTTOM,
                                    padding: const EdgeInsets.all(5),
                                    duration: const Duration(seconds: 4));
                              } else {
                                Helper helper = Helper(
                                  helper_name.text,
                                  helper_phone.text,
                                  "",
                                  helper_email.text,
                                  helper_address.text,
                                  helper_total.text,
                                );
                                Get.find<AddHelperController>()
                                    .add_helper(Get.arguments, helper);
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
                visible: Get.find<AddHelperController>().isadding.value == true
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
