import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<Transaction> create(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      Uri.http(baseUrl, '/transactions'),
      headers: {
        'Content-Type': 'application/json',
        'password': '1000',
      },
      body: transactionJson,
    );
    return Transaction.fromJson(jsonDecode(response.body));
  }

  Future<List<Transaction>> readAll() async {
    final Response response = await client
        .get(Uri.http(baseUrl, '/transactions'))
        .timeout(Duration(seconds: 5));
    final List<dynamic> transactions = jsonDecode(response.body);
    return transactions
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }
}
