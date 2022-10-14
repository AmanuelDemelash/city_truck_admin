import 'package:city_truck_admin/model/admin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  TextEditingController signup_name = TextEditingController();
  TextEditingController signup_password = TextEditingController();
  TextEditingController signup_email = TextEditingController();
  TextEditingController signup_repassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
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
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.7))),
          SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.start,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: Get.width,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Create new account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 3),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shadowColor: Colors.white,
                                child: TextFormField(
                                    controller: signup_name,
                                    onSaved: (newValue) =>
                                        signup_name.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your full name!';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    cursorColor: Colors.pink,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        hintText: "Full Name",
                                        hintStyle: TextStyle(fontSize: 12),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shadowColor: Colors.white,
                                child: TextFormField(
                                    controller: signup_email,
                                    onSaved: (newValue) =>
                                        signup_email.text != newValue,
                                    validator: (value) {
                                      if (value == null ||
                                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                        return 'Enter a valid email!';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    cursorColor: Colors.pink,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        hintText: "Email",
                                        hintStyle: TextStyle(fontSize: 12),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),

                            const SizedBox(
                              height: 14,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shadowColor: Colors.white,
                                child: TextFormField(
                                    controller: signup_password,
                                    onSaved: (newValue) =>
                                        signup_password.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.length != 6) {
                                        return 'Enter a valid password max length is 6';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Password",
                                        hintStyle: TextStyle(fontSize: 12),
                                        prefixIcon: Icon(
                                          Icons.key,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                shadowColor: Colors.white,
                                child: TextFormField(
                                    controller: signup_repassword,
                                    onSaved: (newValue) =>
                                        signup_repassword.text != newValue,
                                    validator: (value) {
                                      if (value == null || value.length != 6) {
                                        return 'Enter a valid password max length is 6';
                                      } else if (value !=
                                          signup_password.text) {
                                        return 'password dosnt much...';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Confirm password",
                                        hintStyle: TextStyle(fontSize: 12),
                                        prefixIcon: Icon(
                                          Icons.key,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            // sign in button
                            Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.orange,
                                    blurRadius: 50,
                                    offset: Offset(10, 5))
                              ]),
                              width: Get.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ElevatedButton(

                                  onPressed: () {
                                    _formkey.currentState!.save();
                                    if (_formkey.currentState!.validate()) {
                                      Admin admin = Admin("", signup_name.text,
                                          signup_email.text);
                                      Get.find<AuthController>().Signup_admin(
                                          admin, signup_password.text);
                                    }
                                  },

                                  child:const  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text.rich(TextSpan(
                                  text: "Already have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: " Sign In now",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold))
                                  ])),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
          Obx(() => Visibility(
                visible: Get.find<AuthController>().issignup.value == true
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
