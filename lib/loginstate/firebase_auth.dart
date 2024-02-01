import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home_page.dart';

class FirebaseConfiguration {
  FirebaseAuth auth = FirebaseAuth.instance;

  verifyOTP(countryCode, phoneNumber, otp, verificationid, name, context) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationid, smsCode: otp);
    auth.signInWithCredential(authCredential).then(
      (result) async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => home_page()),
            (route) => false);

        Fluttertoast.showToast(
            msg: "OTP verified",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 78, 42, 194),
            textColor: Colors.white,
            fontSize: 16.0);
      },
    ).catchError((error) {
      Fluttertoast.showToast(
          msg: 'Invalid OTP',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Color.fromARGB(255, 78, 42, 194),
          textColor: Colors.white,
          fontSize: 16.0);
      // verificationStarted.value = false;
    });
  }
}
