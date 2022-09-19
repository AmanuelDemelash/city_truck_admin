import 'package:city_truck_admin/controllers/add_driver_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class Mydrivers extends StatelessWidget {
  const Mydrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "My Drivers",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/addrivers");
        },
        elevation: 8,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Expanded(
            child: Obx(() => Container(
                margin: const EdgeInsets.only(left: 10),
                height: Get.height,
                width: Get.width,
                child: Get.find<AddDriverController>().drivers.value.isEmpty
                    ? const Center(
                        child: Text("no drivers found"),
                      )
                    : AnimatedList(
                        initialItemCount: Get.find<AddDriverController>()
                            .drivers
                            .value
                            .length,
                        itemBuilder: (context, index, animation) {
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              onTap: () => Get.toNamed("/driverinfo",
                                  arguments: Get.find<AddDriverController>()
                                      .drivers
                                      .value[index]),
                              contentPadding: const EdgeInsets.all(10),
                              leading: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                child: Hero(
                                  tag: "driverimage",
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        Get.find<AddDriverController>()
                                            .drivers
                                            .value[index]
                                            .driver_image),
                                  ),
                                ),
                              ),
                              title: Text(
                                Get.find<AddDriverController>()
                                    .drivers
                                    .value[index]
                                    .name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text("M.Number: "),
                                      Text(
                                          Get.find<AddDriverController>()
                                              .drivers
                                              .value[index]
                                              .phone,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Rating: "),
                                      RatingBar.builder(
                                        initialRating:
                                            Get.find<AddDriverController>()
                                                .drivers
                                                .value[index]
                                                .rate
                                                .toDouble(),
                                        minRating: 1,
                                        itemSize: 17,
                                        tapOnlyMode: false,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          size: 8,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ))),
          ),
        ],
      ),
    );
  }
}
