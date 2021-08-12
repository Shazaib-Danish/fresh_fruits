import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class CircularProgress extends StatelessWidget {

  Widget? circularProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: LoadingBouncingGrid.square(
            borderColor: Colors.white,
            borderSize: 3.0,
            size: 50.0,
            inverted: true,
            backgroundColor: Colors.deepOrangeAccent,
          ),
        );
      },
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}