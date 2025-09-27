import 'package:kobi_pay/features/transactions/data/data_sources/transaction_local_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepository({required this.localDataSource});

  Future<List<TransactionModel>> getTransactions() async {
    return await localDataSource.fetchTransactions();
  }
}
