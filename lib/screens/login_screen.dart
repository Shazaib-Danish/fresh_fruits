import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_and_fruits/components/k_components.dart';
import 'package:fresh_and_fruits/components/rich_text.dart';
import 'package:fresh_and_fruits/screens/pin_code.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phoneNumber = '+92';

  final _textValidator = GlobalKey<FormState>();

  Future<bool> exit() {
    SystemNavigator.pop();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Image.asset(
                  'assets/HEALTHY_FOOD_COURIER.jpg',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fresh ',
                    style: GoogleFonts.blackHanSans(
                      fontSize: 26,
                      color: Color(0xFF55CB28),
                    ),
                  ),
                  Text(
                    '&  ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  RichTxt(
                    fontSize: 26,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 15.0),
                child: Text(
                  'We deliver fresh fruits and vegetables to your destination',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Form(
                key: _textValidator,
                child: Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 70,
                    child: TextFormField(
                      validator: (value) {
                        if (_phoneNumber == '+92') {
                          return '*Enter Number';
                        } else {
                          print(_phoneNumber.length);
                          if (_phoneNumber.length == 13 ||
                              _phoneNumber.length == 14) {
                            return null;
                          } else {
                            return '*incorrect number';
                          }
                        }
                      },
                      decoration: kTextDecoration.copyWith(
                        prefixText: '+92',
                        labelText: 'Enter phone number',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: ((value) {
                        _phoneNumber = '+92$value';
                        print(_phoneNumber);
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              MaterialButton(
                elevation: 10.0,
                minWidth: 300,
                height: 50.0,
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
                color: Color(0xFFDC302E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                onPressed: () {
                  if (_textValidator.currentState!.validate()) {
                    if (_phoneNumber.startsWith('0', 3)) {
                      String finalStr = _phoneNumber.substring(0, 3) +
                          _phoneNumber.substring(3 + 1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PinCodeVerificationScreen(finalStr),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PinCodeVerificationScreen(_phoneNumber),
                          ));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
