import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class MonthSelected extends TransactionEvent {
  final String month;

  MonthSelected(this.month);

  @override
  List<Object?> get props => [month];
}

class RefundTransaction extends TransactionEvent {
  final String transactionId;

  RefundTransaction(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}
