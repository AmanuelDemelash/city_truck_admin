// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  TextEditingController signin_email = TextEditingController();
  TextEditingController signin_password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
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
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.7))),
            SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
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
                          "Sign In",
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
                          "Sign in to your account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              letterSpacing: 3),
                        ),
                        Text(
                          "Admin",
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
                                      controller: signin_email,
                                      onSaved: (newValue) =>
                                          signin_email.text != newValue,
                                      validator: (value) {
                                        if (value == null ||
                                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value)) {
                                          return 'Enter a valid email!';
                                        }
                                        return null;
                                      },
                                      autofocus: false,
                                      cursorColor: Colors.orange,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          hintText: "Enter your email",
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
                                      controller: signin_password,
                                      onSaved: (newValue) =>
                                          signin_password.text != newValue,
                                      validator: (value) {
                                        if (value == null ||
                                            value.length != 6) {
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
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Forgot password?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 30,
                              ),
                              // sign in button
                              Obx(
                                () => Get.find<AuthController>()
                                            .issignin
                                            .value ==
                                        true
                                    ? SpinKitFadingCircle(
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
                                      )
                                    : Container(
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.orange,
                                                  blurRadius: 50,
                                                  offset: Offset(10, 5))
                                            ]),
                                        width: Get.width,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: RaisedButton(
                                            highlightColor: Colors.orange,
                                            padding: const EdgeInsets.all(13),
                                            onPressed: () {
                                              _formkey.currentState!.save();
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                Get.find<AuthController>()
                                                    .Signin_admin(
                                                        signin_email.text,
                                                        signin_password.text);
                                              }
                                            },
                                            color: Colors.orange,
                                            elevation: 5,
                                            child: const Text("Sign In",
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
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: const [
                              //     Expanded(
                              //         child: Divider(
                              //       thickness: 1,
                              //       color: Colors.white54,
                              //     )),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Text("OR",
                              //         style: TextStyle(
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 20)),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Expanded(
                              //         child: Divider(
                              //       thickness: 1,
                              //       color: Colors.white54,
                              //     ))
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // const Text(
                              //   "connect with",
                              //   style: TextStyle(color: Colors.white),
                              // ),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     Expanded(
                              //       child: SizedBox(
                              //         width: Get.width,
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(10),
                              //           child: RaisedButton.icon(
                              //             padding: EdgeInsets.all(10),
                              //             icon: const FaIcon(
                              //               FontAwesomeIcons.facebook,
                              //               color: Colors.white,
                              //             ),
                              //             color: Colors.blue,
                              //             onPressed: () {},
                              //             label: const Text(
                              //               "Facebook",
                              //               style: TextStyle(
                              //                   color: Colors.white, letterSpacing: 2),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 15,
                              //     ),
                              //     Expanded(
                              //       child: SizedBox(
                              //         width: Get.width,
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(10),
                              //           child: RaisedButton.icon(
                              //             padding: EdgeInsets.all(10),
                              //             icon: const FaIcon(
                              //               FontAwesomeIcons.google,
                              //               color: Colors.white,
                              //             ),
                              //             color: Colors.red,
                              //             onPressed: () {},
                              //             label: const Text(
                              //               "Google",
                              //               style: TextStyle(
                              //                   color: Colors.white, letterSpacing: 2),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("signup");
                                },
                                child: const Text.rich(TextSpan(
                                    text: "Dont have an account?",
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "  Sign up now",
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
          ],
        ));
  }
}
