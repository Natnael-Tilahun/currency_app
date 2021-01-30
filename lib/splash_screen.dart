import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[700],
      body: (SafeArea(
        child: Center(
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.euro_symbol_rounded,
                    size: 150,
                    color: Colors.cyanAccent,
                  ),
                  //Image(image: AssetImage('assets/images-1.jpg'),height: 200,width: 200,),
                  Divider(
                    height: 10.0,
                    color: Colors.cyanAccent,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Wellcome to',
                    style: TextStyle(
                        fontSize: 30.0,
                        wordSpacing: 3.0,
                        letterSpacing: 3.0,
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.w900),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 20.0),
                    child: Text(
                      'Currency Exchange App',
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.cyanAccent,
                          letterSpacing: 2.3,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    autofocus: true,
                    splashColor: Colors.cyanAccent,
                    icon: Icon(
                      Icons.replay_circle_filled,
                      semanticLabel: 'Continue',
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/test');
                    },
                    iconSize: 100,
                    color: Colors.cyanAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 5.0),
                    child: Text(
                      'Tap or hold to continue...',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0,
                          color: Colors.greenAccent),
                    ),
                  ),
                ],
              ) //icon button
            ],
          )),
        ),
      )),
    );
  }
}
