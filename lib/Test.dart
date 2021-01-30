import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String selectedCurrency;
  double currencyRate;
  String accessKey = "1cb1cd324552f413b4e9aa62941abddf";
  String latestEndpoint = "latest";
  String fluctuationEndpoint = "fluctuation";
  String convertEndpoint = "convert";
  double amount;
  double total;
  var rates;
  var currencynametextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void setupWorldCurrency() async {
    try {
      Response specificLatestResponse = await get(
          'http://data.fixer.io/api/$latestEndpoint?access_key=$accessKey&symbols=$selectedCurrency');
      // Response convertResponse = await get(
      //     'http://data.fixer.io/api/$convertEndpoint?access_key=19228b9981e8699b62cfcdbf0ec4ce1b&from=EUR &to=USD &amount=25');
      Map data = jsonDecode(specificLatestResponse.body);
      print(data);
      if (data['success'] == true) {
        currencyRate = data['rates']['$selectedCurrency'];
        currencyRate = double.parse('$currencyRate');
        totalSum(amount, currencyRate);
        await setState(() {
          Fluttertoast.showToast(
              msg: 'Succeessfuly converted. Thank you!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      } else if (data['success'] == false) {
        var codes = data['error']['code'];
        if (codes == 101) {
          Fluttertoast.showToast(
              msg:
                  'No API Key was specified or an invalid API Key was specified.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (codes == 404) {
          Fluttertoast.showToast(
              msg: 'The requested resource does not exist.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (codes == 102) {
          Fluttertoast.showToast(
              msg: 'The account this API request is coming from is inactive.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (codes == 103) {
          Fluttertoast.showToast(
              msg: 'The requested API endpoint does not exist.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (codes == 104) {
          Fluttertoast.showToast(
              msg:
                  'The maximum allowed API amount of monthly API requests has been reached.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (codes == 105) {
          Fluttertoast.showToast(
              msg:
                  'The current subscription plan does not support this API endpoint.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (codes == 106) {
          Fluttertoast.showToast(
              msg: 'The current request did not return any results.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    currencynametextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        backgroundColor: Colors.redAccent[700],
        title: (Text('Currency Exchange App')),
        centerTitle: true,
      )),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    child: Icon(
                      Icons.euro_rounded,
                      color: Colors.lightBlue,
                      size: 100.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 0.0),
                    child: Text(
                      'Base Currency Euro',
                      style: TextStyle(fontSize: 23.0, letterSpacing: 2.0),
                    ),
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.blueGrey,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.0,
                    child: Center(
                      child: Text(
                        'Convert To:',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 0),
                        child: RaisedButton(
                          textColor: Colors.black,
                          focusColor: Colors.cyan,
                          color: Colors.lightBlueAccent,
                          child:
                              Text('Select target Currency : $selectedCurrency',
                                  style: (TextStyle(
                                    fontSize: 22,
                                  ))),
                          onPressed: () {
                            showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyCode: true,
                                showCurrencyName: true,
                                searchHint: 'USD,EUR',
                                onSelect: (Currency currency) {
                                  selectedCurrency = currency.code;
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120.0,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Enter Amount: ',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "The amount is Empty!" : null,
                              controller: currencynametextController,
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Amount",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Total amount:',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35.0, vertical: 10.0),
                          child: Text(
                            // total.toString(),
                            total.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Rate:',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          // decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          //     border:Border.all(color: Colors.black,width: 1) ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10.0),
                          child: Text(
                            '1 EUR = ' + '$currencyRate $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        var no = currencynametextController.text;
                        amount = double.parse(no);
                        //fetching();
                        setupWorldCurrency();

                        // convertedRate+=34.0;
                      });
                    } else {
                      print('Amount is empty');
                    }
                  },
                  child: Text(
                    'Convert',
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
      ),
    );
  }

  totalSum(double amount, double currencyRate) {
    total = amount * currencyRate;
    return total;
  }
}
