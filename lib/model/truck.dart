import 'package:cloud_firestore/cloud_firestore.dart';

class Truck {
  late String id;
  late String truckmodel;
  late String paltenumber;
  late String loadcapacity;
  late String year;
  late String insured_date;
  late String truck_image;
  late String driver_id;
  Truck(this.id, this.truckmodel, this.paltenumber, this.loadcapacity,
      this.year, this.insured_date, this.truck_image, this.driver_id);

  Truck.fromdocumentsnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    truckmodel = documentSnapshot['truck_model'];
    paltenumber = documentSnapshot['plate_num'];
    loadcapacity = documentSnapshot['load_capacity'];
    year = documentSnapshot['year'];
    insured_date = documentSnapshot["insured_date"];
    truck_image = documentSnapshot['truck_image'];
    driver_id = documentSnapshot['driver_id'];
  }
}
