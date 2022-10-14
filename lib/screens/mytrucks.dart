import 'package:city_truck_admin/controllers/addtruck_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Mytrucks extends StatelessWidget {
  const Mytrucks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: const Text(
            "My Trucks",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: "Add Truck",
            onPressed: () {
              Get.toNamed("/addtruck");
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Stack(

          children:[
            Container(
              height: 50,
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
                Obx(() => Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: Get.height,
                      width: Get.width,
                      child: Get.find<AddtruckController>().trucks.value.isEmpty
                          ?  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitFadingCircle(
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: index.isEven
                                        ? Colors.orange
                                        : Colors.orange.shade300,
                                  ),
                                );
                              },
                            ),
                            const Text("finding Trucks"),
                          ],
                        ),
                      )
                          : AnimatedList(
                            physics:const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              initialItemCount: Get.find<AddtruckController>()
                                  .trucks
                                  .value
                                  .length,
                              itemBuilder: (context, index, animation) {
                                return Card(
                                    elevation: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(7),
                                              bottomLeft: Radius.circular(7)),
                                          child: Hero(
                                            tag: "truckimage",
                                            child: Image(
                                              width: 100,
                                              height: 100,
                                              image: NetworkImage(
                                                  Get.find<AddtruckController>()
                                                      .trucks
                                                      .value[index]
                                                      .truck_image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            onTap: () => Get.toNamed("/truckinfo",
                                                arguments:
                                                    Get.find<AddtruckController>()
                                                        .trucks
                                                        .value[index]),
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            title: Text(
                                              Get.find<AddtruckController>()
                                                  .trucks
                                                  .value[index]
                                                  .truckmodel,
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
                                                    const Text("Number: "),
                                                    Text(
                                                        Get.find<
                                                                AddtruckController>()
                                                            .trucks
                                                            .value[index]
                                                            .paltenumber,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text("Year: "),
                                                    Text(
                                                      Get.find<AddtruckController>()
                                                          .trucks
                                                          .value[index]
                                                          .year,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            ))),

              ],
            ),
          ),
    ]
        )
    );
  }
}
