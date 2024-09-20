

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_prac/view/home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Otpscreen extends StatefulWidget {
  String verficationId;

  Otpscreen({required this.verficationId, super.key});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.message),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verficationId,
                          smsCode: otp.text.toString());

                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                } catch (e) {}
              },
              child: Text("Verify OTP"))
        ],
      ),
    );
  }
}
