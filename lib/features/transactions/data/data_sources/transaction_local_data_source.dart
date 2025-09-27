import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kobi_pay/core/constants/api_endpoints.dart';
import '../models/transaction_model.dart';

class TransactionLocalDataSource {
  Future<List<TransactionModel>> fetchTransactions() async {
    final response = await rootBundle.loadString(ApiEndpoints.getTransactions);
    final data = json.decode(response) as List<dynamic>;
    return data.map((e) => TransactionModel.fromJson(e)).toList();
  }
}
