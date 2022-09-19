import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  late String id;
  late String task_type;
  late double start_loc_lat;
  late double start_loc_long;
  late double end_loc_lat;
  late double end_loc_long;
  late double current_lat;
  late double current_long;
  late String load_carring;
  late String date;
  late String truck_id;
  late String driver_id;
  late String total_kilometer;
  late String total_task;
  late int statuss;
  late String start_location;
  late String end_location;

  Task(
      this.id,
      this.task_type,
      this.start_loc_lat,
      this.start_loc_long,
      this.end_loc_lat,
      this.end_loc_long,
      this.current_lat,
      this.current_long,
      this.load_carring,
      this.date,
      this.truck_id,
      this.driver_id,
      this.total_kilometer,
      this.total_task,
      this.statuss,
      this.start_location,
      this.end_location);

  Task.fromDocunmentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    task_type = documentSnapshot["task_type"];
    start_loc_lat = documentSnapshot["start_lat"];
    start_loc_long = documentSnapshot["start_long"];
    end_loc_lat = documentSnapshot["end_lat"];
    end_loc_long = documentSnapshot["end_long"];
    current_lat = documentSnapshot["current_lat"];
    current_long = documentSnapshot["current_long"];
    load_carring = documentSnapshot["load_carring"];
    date = documentSnapshot["date"];
    truck_id = documentSnapshot["truck"];
    driver_id = documentSnapshot["driver"];
    total_kilometer = documentSnapshot["total_km"];
    total_task = documentSnapshot["total_task"];
    statuss = documentSnapshot["task_statuss"];
    start_location = documentSnapshot["start_location"];
    end_location = documentSnapshot["end_location"];
  }
}
