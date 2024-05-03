import 'package:flutter/material.dart';

Color hexToColor(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

final primaryColors = {
  '100': hexToColor('#FFEEE9'),
  '200': hexToColor('#FFD9D3'),
  '300': hexToColor('#FFC0BE'),
  '400': hexToColor('#FFAEB2'),
  '500': hexToColor('#FF93A3'),
  '600': hexToColor('#DB6B86'),
  '700': hexToColor('#B74A6E'),
  '800': hexToColor('#932E5A'),
  '900': hexToColor('#7A1C4D'),
};
