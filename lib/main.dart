import 'package:currency_app/home.dart';
import 'package:currency_app/splash_screen.dart';
import 'package:currency_app/Test.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'Test.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        '/home': (context) => Home(),
        '/test': (context) => Test(),
      },
    ));
