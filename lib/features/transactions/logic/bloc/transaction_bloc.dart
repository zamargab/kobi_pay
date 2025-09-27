import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobi_pay/core/constants/app_constants.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../data/models/transaction_model.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc({required this.repository})
    : super(const TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<MonthSelected>(_onMonthSelected);
    on<RefundTransaction>(_onRefundTransaction);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    try {
      final transactions = await repository.getTransactions();

      final now = DateTime.now();
      const months = AppConstants.months;
      final currentMonth = months[now.month - 1];

      emit(TransactionLoaded(transactions, selectedMonth: currentMonth));
    } catch (_) {
      emit(const TransactionError('Failed to load transactions'));
    }
  }

  void _onMonthSelected(MonthSelected event, Emitter<TransactionState> emit) {
    if (state is TransactionLoaded) {
      final s = state as TransactionLoaded;
      emit(TransactionLoaded(s.transactions, selectedMonth: event.month));
    }
  }

  void _onRefundTransaction(
    RefundTransaction event,
    Emitter<TransactionState> emit,
  ) {
    if (state is TransactionLoaded) {
      final s = state as TransactionLoaded;
      final updated = s.transactions.map((t) {
        if (t.id == event.transactionId) {
          return TransactionModel(
            id: t.id,
            icon: t.icon,
            title: t.title,
            date: t.date,
            amount: t.amount,
            status: 'refunded',
            paymentMethod: t.paymentMethod,
          );
        }
        return t;
      }).toList();

      emit(TransactionLoaded(updated, selectedMonth: s.selectedMonth));
    }
  }
}
