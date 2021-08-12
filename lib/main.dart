import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FruitApp());
}

class FruitApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProductManager();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

