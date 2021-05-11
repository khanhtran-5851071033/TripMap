import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Util {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static void unfocus(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  static const Color myColor = Color(0xff29166F);
}

void saveUserInfo(String _msv, _pass) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('msv', _msv);
  prefs.setString('pass', _pass);
}

void removeUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('msv');
  prefs.remove('pass');
}

Future<String> getMsv() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('msv');
}

const String url = 'https://utc2.edu.vn';

class GradientText extends StatelessWidget {
  GradientText(
    this.fontSize,
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
