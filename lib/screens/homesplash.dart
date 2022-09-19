import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/citytruck.jpg"))),
        ),
        Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black.withOpacity(0.3),
        ),
        SafeArea(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text("CITY TRUCK",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  blurRadius: 20,
                                  offset: Offset(7, 2))
                            ],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                              thickness: 1.2,
                            )),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                              thickness: 1.2,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        const Text(
                          "the best truck tracking app you can find in the city the best truck tracking app you can find in the city",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 60,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
