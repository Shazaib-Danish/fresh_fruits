import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/components/rich_text.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final double pi = 3.14;
  late AnimationController _controller;
  late Animation _animation;

  late String userName;
  late String userContact;
  late String userAddress;
  late int totalCustomeOrder;

  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
        lowerBound: 0,
        upperBound: 1.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);

    _controller.forward();

    _controller.addListener(() {
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 3), () {
      checkIfAlreadyLogin();
    });
    super.initState();
  }

  Future<void> checkIfAlreadyLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    if (newUser == false) {
      String? userId = loginData.getString('userId');
      searchUser(userId).then((value) {
        Provider.of<ProductManager>(context, listen: false)
            .addUser(userName, userContact, userAddress, totalCustomeOrder);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Products()));
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  Future searchUser(String? number) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: number)
        .get()
        .then((QuerySnapshot docs) {
      if (docs.docs.isNotEmpty) {
        userName = docs.docs[0].get('fullName');
        userContact = docs.docs[0].get('userId');
        userAddress = docs.docs[0].get('address');
        totalCustomeOrder = docs.docs[0].get('totalOrder');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.height * 0.3,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fresh',
                  style: GoogleFonts.blackHanSans(
                    fontSize: 40,
                    color: Color(0xFF55CB28),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: 200 * pi / 180,
                      child: Image.asset(
                        'assets/curve-down-arrow.png',
                        color: Color(0xFFA5A5A5),
                        width: 40,
                        height: _animation.value * 40,
                      ),
                    ),
                    Text(
                      '&',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Transform.rotate(
                        angle: 30 * pi / 270,
                        child: Image.asset(
                          'assets/curve-down-arrow.png',
                          color: Color(0xFF55CB28),
                          width: 40,
                          height: _animation.value * 40,
                        )),
                  ],
                ),
                RichTxt(
                  fontSize: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
