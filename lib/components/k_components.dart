import 'package:flutter/material.dart';

final  kTextDecoration = InputDecoration(
  filled: true,
  labelStyle: TextStyle(
    color: Colors.orange,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 1.0),
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
        color: Colors.green, width: 2.0),
    borderRadius: BorderRadius.circular(10.0),
  ),
  hintStyle: TextStyle(color: Colors.black),
  fillColor: Colors.white,
);

