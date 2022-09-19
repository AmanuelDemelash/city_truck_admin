import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Verifycode extends StatelessWidget {
  const Verifycode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.perm_phone_msg_sharp,
              color: Colors.orange,
              size: 35,
            ),
            SizedBox(
              width: 15,
            ),
            Text("Phone verification",
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
          ],
        ),
        const Text(
          "Verify Code",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 15,
        ),
        const Center(
          child: Text(
            "please check your message and enter the verification code we just send you +251947054595",
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          child: OtpTextField(
            numberOfFields: 4,
            fieldWidth: 60,
            autoFocus: true,
            borderRadius: BorderRadius.circular(10),
            fillColor: Colors.white,

            textStyle: const TextStyle(color: Colors.white),
            cursorColor: Colors.orange,
            focusedBorderColor: Colors.orange,

            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            // end onSubmit
            onSubmit: (String code) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                          height: 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          )),
                    );
                  });
              Future.delayed(Duration(seconds: 2), () {
                Get.offNamed("/homepage");
              });
            },
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
