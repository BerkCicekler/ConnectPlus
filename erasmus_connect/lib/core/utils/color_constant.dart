import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray600 = fromHex('#6a707c');

  static Color green300 = fromHex('#80b08a');

  static Color blueGray400 = fromHex('#8390a1');

  static Color yellow10000 = fromHex('#00ffe4cc');

  static Color indigo50 = fromHex('#e8ecf4');

  static Color gray800 = fromHex('#523318');

  static Color gray900 = fromHex('#1e232c');

  static Color orange700 = fromHex('#ff7b00');

  static Color gray50 = fromHex('#f7f8f9');

  static Color gray100 = fromHex('#f6f7f8');

  static Color black900 = fromHex('#000000');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color cyan400 = fromHex('#34c2c1');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
