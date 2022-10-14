import 'package:city_truck_admin/controllers/add_truck_trip_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Listtask extends StatelessWidget {
  const Listtask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
        SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              GetBuilder<AddTruckTripController>(
                  init: Get.find<AddTruckTripController>(),
                  initState: (_) {},
                  builder: (controller) {
                    return controller.tasks.value.isEmpty
                        ? Container(
                            width: Get.width,
                            height: 100,
                            child: const Center(
                              child: Text(
                                "no task yet added",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        : SizedBox(
                            child: AnimatedList(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              initialItemCount: controller.tasks.value.length,
                              itemBuilder: (context, index, animation) {
                                return InkWell(
                                  onTap: () => Get.toNamed("/tracktruck",
                                      arguments: controller.tasks.value[index]),
                                  child: Card(
                                    elevation: 4,
                                    child: Container(
                                        width: Get.width,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StreamBuilder<DocumentSnapshot?>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('trucks')
                                                      .doc(controller
                                                          .tasks
                                                          .value[index]
                                                          .truck_id)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    return snapshot.hasData
                                                        ? Banner(
                                                            message: controller
                                                                        .tasks
                                                                        .value[
                                                                            index]
                                                                        .statuss ==
                                                                    0
                                                                ? "pending"
                                                                : controller
                                                                            .tasks
                                                                            .value[index]
                                                                            .statuss ==
                                                                        1
                                                                    ? "Running"
                                                                    : "Complated",
                                                            location:
                                                                BannerLocation
                                                                    .topEnd,
                                                            color: controller
                                                                        .tasks
                                                                        .value[
                                                                            index]
                                                                        .statuss ==
                                                                    0
                                                                ? Colors.red
                                                                : controller
                                                                            .tasks
                                                                            .value[
                                                                                index]
                                                                            .statuss ==
                                                                        1
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .green,
                                                            child: ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                radius: 24,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        snapshot
                                                                            .data!["truck_image"]),
                                                              ),
                                                              title: Text(
                                                                  snapshot.data![
                                                                      "truck_model"],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              subtitle: Text(
                                                                  snapshot.data![
                                                                      "plate_num"]),
                                                            ),
                                                          )
                                                        : const Center(
                                                            child:
                                                                LinearProgressIndicator(),
                                                          );
                                                  }),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Task",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Text(
                                                      controller
                                                          .tasks
                                                          .value[index]
                                                          .task_type,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Text(
                                                      "Departed",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Text(
                                                      controller.tasks
                                                          .value[index].date,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    const Text(
                                                      "Location",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${controller.tasks.value[index].start_location.toString()} to ${controller.tasks.value[index].end_location.toString()} ",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Flag.fromCode(
                                                          FlagsCode.ET,
                                                          height: 20,
                                                          width: 30,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ])),
                                  ),
                                );
                              },
                            ),
                          );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
