import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fresh_and_fruits/components/circular_progress.dart';
import 'package:fresh_and_fruits/components/k_components.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UserNameAndAddress extends StatelessWidget {
  final String _phoneNumber;

  UserNameAndAddress(this._phoneNumber);

  final _textValidator = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String address;

  late SharedPreferences loginData;

  var _auth = FirebaseFirestore.instance.collection('Users');

  Future<dynamic> _addUser() async {
    await _auth.doc(_phoneNumber).set({
      'userId': _phoneNumber,
      'fullName': '$firstName $lastName',
      'homeTown': 'Allama Iqbal Town',
      'address': address,
      'totalOrder' : 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _textValidator,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        'Complete your profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.green,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        '.',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.deepOrange,
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                  decoration: kTextDecoration.copyWith(
                      hintText: 'First Name',
                      hintStyle: TextStyle(color: Colors.grey)),
                  keyboardType: TextInputType.name,
                  onChanged: ((value) {
                    firstName = value;
                  }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                  decoration: kTextDecoration.copyWith(
                      hintText: 'Last Name',
                      hintStyle: TextStyle(color: Colors.grey)),
                  keyboardType: TextInputType.name,
                  onChanged: ((value) {
                    lastName = value;
                  }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                  controller: TextEditingController(text: 'Allam Iqbal Town'),
                  decoration: kTextDecoration.copyWith(
                      hintStyle: TextStyle(color: Colors.grey)),
                  keyboardType: TextInputType.name,
                  onChanged: ((value) {
                    lastName = value;
                  }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                  decoration: kTextDecoration.copyWith(
                      hintText: 'Complete home address',
                      hintStyle: TextStyle(color: Colors.grey)),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 4,
                  keyboardType: TextInputType.streetAddress,
                  onChanged: ((value) {
                    address = value;
                  }),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    elevation: 10.0,
                    minWidth: 300,
                    height: 50.0,
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    color: Colors.green[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () {
                      if (_textValidator.currentState!.validate()) {
                        CircularProgress().circularProgress(context);
                        _addUser().then((_) async {
                          Provider.of<ProductManager>(context, listen: false)
                              .addUser('$firstName $lastName', _phoneNumber,
                                  address, 0);
                          loginData = await SharedPreferences.getInstance();
                          loginData.setBool('login', false);
                          loginData.setString('userId', _phoneNumber);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Products(),
                              ));
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
