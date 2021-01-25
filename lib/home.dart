import 'package:currency_app/world_currency.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCurrency;
  String selectedCountry;
  double currencyRate;
  var amount;
  var total;
  var textController = TextEditingController();

  void setupWorldCurrency() async {
    try {
      WorldCurrency instance = WorldCurrency(
          symbol: '$selectedCurrency',
          amount: '$amount',
          rates: '$currencyRate');
      await instance.getData();
      print(instance.rates);
      setState(() {
        currencyRate = instance.rates;
        amount = textController.text;
        total = amount * currencyRate;
        print(total);
      });
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
    textController.dispose();
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
                        focusColor: Colors.blueGrey,
                        child: Text('Target Currency :$selectedCurrency',
                            style: (TextStyle(
                              fontSize: 25,
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
                                selectedCountry = currency.name;
                                // print('selected currency: $selectedCurrency');
                                // print('selected country: $selectedCountry');
                                // setState(() {
                                // child:  Text('$selected_currency');
                                // });
                              });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.0,
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
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: TextField(
                          controller: textController,
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
                            border: Border.all(color: Colors.black, width: 1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 10.0),
                        child: Text(
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
                          '1 EUR = ' + ' $currencyRate ' + ' $selectedCurrency',
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
                  setState(() {
                    textController.text;
                    fetching();
                    // convertedRate+=34.0;
                  });
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
    );
  }

  void fetching() {
    setupWorldCurrency();
  }
}
