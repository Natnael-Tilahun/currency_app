import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() =>runApp(MaterialApp(
home:Scaffold(
  appBar: (AppBar(
    title: (Text('Currency Exchange App')),
    centerTitle: true,
  )),

  body: Padding(
    padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            Container(
            padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
            child: Icon(
              Icons.euro_rounded,
              color: Colors.lightBlue,
              size: 100.0,
            ),
      ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 0.0),
              child: Text('Base Currency Euro',style: TextStyle(
                fontSize: 23.0,
                letterSpacing: 2.0
              ),
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.blueGrey,
            )
          ],
        ),
        Text('Enter Amount ',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        Text('Target Currency',
        style: TextStyle(
          fontSize: 18.0,
        ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal:40.0,vertical:5.0),
        child: RaisedButton(
          child: Text('Convert',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
          ),
          color: Colors.amber,
        ),
        ),
      ],
    ),
  ),
)
),//home
);