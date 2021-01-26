import 'dart:convert';
import 'package:http/http.dart';

class WorldCurrency {
  String symbol = "";
  var amount;
  var rates;

  WorldCurrency({this.symbol, this.amount, this.rates});

  Future<void> getData() async {
    try {
      String accessKey = "1cb1cd324552f413b4e9aa62941abddf";
      String latestEndpoint = "latest";
      String fluctuationEndpoint = "fluctuation";
      String convertEndpoint = "convert";
      String symbols;
      //double amount=2;

      // Response fluctuationResponse = await get(
      //     'http://data.fixer.io/api/$fluctuationEndpoint?access_key=$accessKey');

      Response specificLatestResponse = await get(
          'http://data.fixer.io/api/$latestEndpoint?access_key=$accessKey&symbols=$symbols');

      // Response latestResponse = await get(
      //     'http://data.fixer.io/api/$latestEndpoint?access_key=$accessKey');
      // Response conversionResponse = await get(
      //     'http://data.fixer.io/api/$convertEndpoint?access_key=$accessKey&from= EUR & to = USD & amount = 1 ');

      Map data = jsonDecode(specificLatestResponse.body);
      rates = data['rates'];
      //print(data);
      //print(rates);

    } catch (e) {
      print('caught errors: $e');
      rates('couldnot get rates');
    }
  }
}
