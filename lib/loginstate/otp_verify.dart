import 'package:flutter/material.dart';
import 'package:mobileapp/loginstate/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

bool otpverify_button = false;
bool verificationStarted = false;

class otp_verify extends StatefulWidget {
  final countryCodeValue;
  final _phoneNumber;
  final VerificationID;
  final _name;
  otp_verify(
      this.countryCodeValue, this._phoneNumber, this.VerificationID, this._name,
      {super.key});

  @override
  State<otp_verify> createState() => _otp_verifyState();
}

class _otp_verifyState extends State<otp_verify> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final currentText = TextEditingController();
  String enteredOTP = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.09,
                    ),
                    Image.asset(
                      "assets/otp.gif",
                      fit: BoxFit.fitWidth,
                      height: 190,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .07),
                    const Center(
                        child: Text(
                      'Verify with mobile number',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: screenSize.height * .02,
                    ),
                    Text(
                      "We have sent you 6-digit code on the phone number ${widget.countryCodeValue} ${widget._phoneNumber}",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: screenSize.height * .04,
                    ),
                    PinFieldAutoFill(
                        currentCode: currentText.text,
                        onCodeChanged: (p0) {
                          if (currentText.text.length == 6) {
                            verifyOTPCommonMethod(currentText.text);
                            setState(() {
                              otpverify_button = true;
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                        codeLength: 6,
                        enabled: true,
                        autoFocus: false,
                        controller: currentText,
                        decoration: BoxLooseDecoration(
                            strokeColorBuilder:
                                FixedColorBuilder(Colors.black))),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    if (otpverify_button == true)
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Authenticating...",
                          style: TextStyle(
                            color: Color.fromARGB(255, 78, 42, 194),
                            fontSize: 16,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  verifyOTPCommonMethod(verificationCode) async {
    verificationStarted = true;
    print("Verifying");
    await FirebaseConfiguration().verifyOTP(
        widget.countryCodeValue,
        widget._phoneNumber,
        currentText.text,
        widget.VerificationID,
        widget._name,
        context);
  }
}
