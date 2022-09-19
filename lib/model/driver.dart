import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  late String id;
  late String name;
  late String phone;
  late String email;
  late String experiance;
  late String license;
  late String driver_image;
  late int rate;
  late String total_trip;
  late String total_comp_task;

  Driver(
      this.id,
      this.name,
      this.phone,
      this.email,
      this.experiance,
      this.license,
      this.driver_image,
      this.rate,
      this.total_trip,
      this.total_comp_task);

  Driver.fromdocumentsnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    phone = documentSnapshot['phone'];
    email = documentSnapshot['email'];
    experiance = documentSnapshot['experiance'];
    license = documentSnapshot["license"];
    driver_image = documentSnapshot['image'];
    rate = documentSnapshot['rate'];
    total_trip = documentSnapshot['total_trip'];
    total_comp_task = documentSnapshot['total_comp_task'];
  }
}
