import 'package:equatable/equatable.dart';
import 'package:kobi_pay/core/constants/app_constants.dart';
import '../../data/models/transaction_model.dart';

abstract class TransactionState extends Equatable {
  final String selectedMonth;

  const TransactionState({this.selectedMonth = 'January'});

  @override
  List<Object?> get props => [selectedMonth];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial({super.selectedMonth});
}

class TransactionLoading extends TransactionState {
  const TransactionLoading({super.selectedMonth});
}

class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactions;

  const TransactionLoaded(this.transactions, {super.selectedMonth});

  List<TransactionModel> get monthFilteredTransactions {
    return transactions.where((t) {
      return _monthName(t.date) == selectedMonth;
    }).toList();
  }

  double get monthlyTotal {
    return monthFilteredTransactions.fold(0.0, (sum, t) => sum + t.amount);
  }

  Map<String, double> get statusTotals {
    double success = 0, failed = 0, refunded = 0;
    for (var t in monthFilteredTransactions) {
      switch (t.status.toLowerCase()) {
        case 'successful':
          success += t.amount;
          break;
        case 'failed':
          failed += t.amount;
          break;
        case 'refunded':
          refunded += t.amount;
          break;
      }
    }
    return {'successful': success, 'failed': failed, 'refunded': refunded};
  }

  Map<String, int> get statusCounts {
    int success = 0, failed = 0, refunded = 0;
    for (var t in monthFilteredTransactions) {
      switch (t.status.toLowerCase()) {
        case 'successful':
          success++;
          break;
        case 'failed':
          failed++;
          break;
        case 'refunded':
          refunded++;
          break;
      }
    }
    return {'successful': success, 'failed': failed, 'refunded': refunded};
  }

  String _monthName(DateTime date) {
    const months = AppConstants.months;
    return months[date.month - 1];
  }

  @override
  List<Object?> get props => [transactions, selectedMonth];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message, {super.selectedMonth});

  @override
  List<Object?> get props => [message, selectedMonth];
}
