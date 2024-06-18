import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';

abstract class Styles {
  static const textlogo = TextStyle(
    fontSize: 64,
    fontFamily: 'Play',
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.90,
    color: Colors.white,
  );
  static const text24w700 = TextStyle(
    color: PrimaryColor,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 1,
    letterSpacing: -0.99,
  );
  static const text20w400 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    height: 1,
    letterSpacing: -0.99,
  );
  static const text20w600 = TextStyle(
    color: Color(0xFFF5F5F5),
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    height: 0,
  );
  static const text20w600black = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    height: 0.15,
    letterSpacing: -0.71,
  );

  static const text18w400 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static const text16w500 = TextStyle(
    color: TextColor,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    height: 0,
    decoration: TextDecoration.underline,
  );
  static const text14w500 = TextStyle(
    color: BorderColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    height: 0.10,
  );
  static const text14w600 = TextStyle(
    color: Color(0xFFFCFCFC),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    height: 0.10,
  );
  static const text16w600 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    height: 0.09,
    letterSpacing: 0.32,
  );
}
