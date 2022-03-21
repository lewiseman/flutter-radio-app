import 'package:flutter/material.dart';
import 'package:radio/app/config/theme.dart';
import 'package:radio/app/views/home/root.dart';

void main() {
  runApp(const RadioApp());
}

class RadioApp extends StatelessWidget {
  const RadioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: RadioAppTheme.darkTheme,
      title: 'Radio App',
      home: const RadioHome(),
    );
  }
}
