// firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobileapp/loginstate/otp_verify.dart';

final nameProvider = StateProvider<String>((ref) => '');
final mobileNumberProvider = StateProvider<String>((ref) => '');
bool otpsent_button = false;

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

// firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  String name = '';
  String mobileNumber = '';
  String countryCode = '+91';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login Screen'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/details.gif",
                  // filterQuality: FilterQuality.high,
                  fit: BoxFit.fitWidth,
                  height: 190,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                _buildTextField('Name', TextInputType.text, (value) {
                  setState(() {
                    name = value;
                  });
                }),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField('C code', TextInputType.phone,
                          (value) {
                        setState(() {
                          countryCode = value;
                        });
                      }),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: _buildTextField(
                          'Mobile Number', TextInputType.phone, (value) {
                        setState(() {
                          mobileNumber = value;
                        });
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      otpsent_button = true;
                    });
                    phoneNumberVerification(
                        countryCode, mobileNumber, name, context);
                  },
                  child: (otpsent_button == true)
                      ? SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : Text(
                          'Sent OTP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: Color.fromARGB(255, 78, 42,
                        194), // Change the background color as needed
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextInputType keyboardType, Function(String) onChanged) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

// firebase
  phoneNumberVerification(countryCode, phoneNumber, name, context) async {
    try {
      await auth.verifyPhoneNumber(
          timeout: Duration(seconds: 5),
          phoneNumber: '$countryCode$phoneNumber',
          verificationCompleted: (PhoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException exception) async {
            Fluttertoast.showToast(
                msg: "${exception.message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromARGB(255, 78, 42, 194),
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              otpsent_button = false;
            });
          },
          codeSent: (String VerificationID, int? resendToken) async {
            print("89");

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => otp_verify(
                        countryCode, phoneNumber, VerificationID, name)),
                (route) => false).then((value) {
              setState(() {
                otpsent_button = false;
              });
            });
            Fluttertoast.showToast(
                msg: "OTP sent successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromARGB(255, 78, 42, 194),
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              otpsent_button = false;
            });
          },
          codeAutoRetrievalTimeout: (String VerificationID) {});
      return 'SUCCESS';
    } catch (error) {
      print(error);
      return 'ERROR';
    }
  }
}
