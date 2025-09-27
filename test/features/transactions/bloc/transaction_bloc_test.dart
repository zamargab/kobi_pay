import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kobi_pay/features/transactions/data/models/transaction_model.dart';

import 'package:kobi_pay/features/transactions/logic/bloc/transaction_bloc.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_event.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/mockTransactionRepository.dart';

void main() {
  late MockTransactionRepository repository;
  late TransactionBloc bloc;

  final fakeTransactions = [
    TransactionModel(
      id: '1',
      icon: 'icon',
      title: 'Payment',
      date: DateTime(2025, 9, 1),
      amount: 1000,
      status: 'completed',
      paymentMethod: 'Card',
    ),
  ];

  setUp(() {
    repository = MockTransactionRepository();
    bloc = TransactionBloc(repository: repository);
  });

  blocTest<TransactionBloc, TransactionState>(
    'emits [Loading, Loaded] when LoadTransactions succeeds',
    build: () {
      when(
        () => repository.getTransactions(),
      ).thenAnswer((_) async => fakeTransactions);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTransactions()),
    expect: () => [
      isA<TransactionLoading>(),
      isA<TransactionLoaded>().having(
        (s) => s.transactions.length,
        'transactions length',
        1,
      ),
    ],
  );

  blocTest<TransactionBloc, TransactionState>(
    'emits [Loading, Error] when LoadTransactions fails',
    build: () {
      when(() => repository.getTransactions()).thenThrow(Exception('fail'));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTransactions()),
    expect: () => [isA<TransactionLoading>(), isA<TransactionError>()],
  );

  blocTest<TransactionBloc, TransactionState>(
    'emits updated state on RefundTransaction',
    build: () {
      return bloc;
    },
    seed: () => TransactionLoaded(fakeTransactions, selectedMonth: 'September'),
    act: (bloc) => bloc.add(RefundTransaction('1')),
    expect: () => [
      isA<TransactionLoaded>().having(
        (s) => s.transactions.first.status,
        'status',
        'refunded',
      ),
    ],
  );
}
