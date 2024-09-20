import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_prac/view/otpscreen.dart';
import 'package:flutter/material.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Phoneauth> {
  TextEditingController phoneauth = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healty Bites"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Phone Login",
            style: TextStyle(fontSize: 35),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/recipe.png")),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: phoneauth,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {

                    print("Verification Failed : ${ex.message}"  );
                  },
                  codeSent: (String verificationid, int? resendtoken) {
                                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Otpscreen(
                                  verficationId: verificationid,
                                )));
                  },
                    // Pass this verification id to the next screen
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phoneauth.text.toString());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: Center(
                child: Text(
                  "GET OTP",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       await FirebaseAuth.instance.verifyPhoneNumber(
          //           verificationCompleted: (PhoneAuthCredential credential) {},
          //           verificationFailed: (FirebaseAuthException ex) {},
          //           codeSent: (String verificationid, int? resendtoken) {
          //             // Pass this verification id to the next screen
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => Otpscreen(
          //                           verficationId: 'verificationid',
          //                         )));
          //           },
          //           codeAutoRetrievalTimeout: (String verificationId) {},
          //           phoneNumber: phoneauth.text.toString());
          //     },
          //     child: Text("Get OTP")),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => Allfoods()));
          //     },
          //     child: Text("Healthy Recipes")),
        ],
      ),
    );
  }
}
