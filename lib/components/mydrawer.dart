import 'package:city_truck_admin/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mydrawer extends StatelessWidget {
  const mydrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              accountName: Text(
                  FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                  style: TextStyle(
                    color: Colors.black,
                  )),
              accountEmail:
                  Text(FirebaseAuth.instance.currentUser!.email.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      )),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/profile.png"))),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => Get.back(),
            child: const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.orange,
              ),
              title: Text("Home"),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed("/mytrucks"),
            child: const ListTile(
              leading: Icon(
                Icons.drive_eta_rounded,
                color: Colors.orange,
              ),
              title: Text("My Trucks"),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed("/mydrivers"),
            child: const ListTile(
              leading: Icon(
                Icons.person_pin,
                color: Colors.orange,
              ),
              title: Text("My Drivers"),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed("/setting"),
            child: const ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.orange,
              ),
              title: Text("Terms and Conditions"),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed("/mytriphistory"),
            child: const ListTile(
              leading: Icon(
                Icons.phone_callback,
                color: Colors.orange,
              ),
              title: Text("Contact Us"),
            ),
          ),
          InkWell(
            onTap: () => Get.defaultDialog(
              title: "Do you want to Logout?",
              content: Container(),
              barrierDismissible: false,
              radius: 10,
              contentPadding: EdgeInsets.all(15),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<AuthController>().logout();
                  },
                  child: const Text("Logout"),
                )
              ],
            ),
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.orange,
              ),
              title: Text("Log Out"),
            ),
          )
        ],
      ),
    );
  }
}
