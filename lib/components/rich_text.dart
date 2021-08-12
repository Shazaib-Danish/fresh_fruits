import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RichTxt extends StatelessWidget {

  final double fontSize;

  RichTxt({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'F',
            style: GoogleFonts.titanOne(
              color: Color(0xFF54005B),
              fontSize: fontSize,
            )),
        TextSpan(
            text: 'r',
            style: GoogleFonts.titanOne(
              color: Color(0xFFF14473),
              fontSize: fontSize,
            )),
        TextSpan(
            text: 'u',
            style: GoogleFonts.titanOne(
              color: Color(0xFFD6B506),
              fontSize: fontSize,
            )),
        TextSpan(
          text: 'i',
          style: GoogleFonts.titanOne(
            color: Color(0xFFFDB923),
            fontSize: fontSize,
          ),
        ),
        TextSpan(
          text: 't',
          style: GoogleFonts.titanOne(
            color: Color(0xFFE62323),
            fontSize: fontSize,
          ),
        ),
        TextSpan(
          text: 's',
          style: GoogleFonts.titanOne(
            color: Color(0xFF006404),
            fontSize: fontSize,
          ),
        ),
      ]),
    );
  }
}
