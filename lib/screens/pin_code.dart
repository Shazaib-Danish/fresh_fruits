import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/components/circular_progress.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/products.dart';
import 'package:fresh_and_fruits/screens/user_name_adress.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  PinCodeVerificationScreen(this.phoneNumber);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  late SharedPreferences loginData;

  final _auth = FirebaseAuth.instance;

  late String userName;
  late String userContact;
  late String userAddress;
  late int customerTotalOrder;
  late bool previousUser = false;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    startTimer();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PinCodeVerificationScreen(widget.phoneNumber),
            ));
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    _verify();
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future searchUser(String number) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: number)
        .get()
        .then((QuerySnapshot docs) {
      if (docs.docs.isNotEmpty) {
        userName = docs.docs[0].get('fullName');
        userContact = docs.docs[0].get('userId');
        userAddress = docs.docs[0].get('address');
        customerTotalOrder = docs.docs[0].get('totalOrder');
        previousUser = true;
      } else {
        previousUser = false;
      }
    });
  }

  late String verId;

  _verify() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
    };
//
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
    };
//
    final PhoneCodeSent codeSent = (String verificationId) {
      print('verification id is $verificationId');
      verId = verificationId;
    } as PhoneCodeSent;
//
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '${widget.phoneNumber}',
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: widget.phoneNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 6) {
                          return "*Fill all fields";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 40,
                        activeFillColor:
                            hasError ? Colors.orange : Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(fontSize: 20, height: 1.6),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) async {
                        CircularProgress().circularProgress(context);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserNameAndAddress(
                                      widget.phoneNumber),
                            ));
                      //   try {
                      //     setState(() {
                      //       hasError = false;
                      //     });
                      //     await _auth
                      //         .signInWithCredential(
                      //             PhoneAuthProvider.credential(
                      //                 verificationId: verId,
                      //                 smsCode: currentText))
                      //         .then((value) async {
                      //       if (value.user != null) {
                      //         searchUser(widget.phoneNumber)
                      //             .then((value) async {
                      //           if (previousUser) {
                      //             loginData =
                      //                 await SharedPreferences.getInstance();
                      //             loginData.setBool('login', false);
                      //             loginData.setString('userId', userContact);
                      //             Provider.of<ProductManager>(context,
                      //                     listen: false)
                      //                 .addUser(userName, userContact,
                      //                     userAddress, customerTotalOrder);
                      //             Navigator.pop(context);
                      //             Navigator.pushReplacement(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => Products(),
                      //                 ));
                      //           } else {
                      //             Navigator.pop(context);
                      //             Navigator.pushReplacement(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       UserNameAndAddress(
                      //                           widget.phoneNumber),
                      //                 ));
                      //           }
                      //         });
                      //       }
                      //     });
                      //   } catch (e) {
                      //     print('Getting error, catch called');
                      //     Navigator.pop(context);
                      //     errorController!.add(ErrorAnimationType
                      //         .shake); // Triggering error shake animation
                      //     setState(() {
                      //       hasError = true;
                      //     });
                      //   }
                       },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          hasError = false;
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        hasError ? "Incorrect code" : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      '$_start',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " RESEND",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
