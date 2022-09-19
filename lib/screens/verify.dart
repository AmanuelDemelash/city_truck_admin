import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/verifycode.dart';

class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

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
          color: Colors.black.withOpacity(0.7),
        ),
        Center(
          child: Column(
            children: [
              Expanded(child: Container()),
              const SizedBox(
                height: 20,
              ),
              Expanded(flex: 2, child: Verifycode())
            ],
          ),
        ),
        Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ))
      ],
    ));
  }
}
