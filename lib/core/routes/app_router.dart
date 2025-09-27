import 'package:go_router/go_router.dart';
import 'package:kobi_pay/features/transactions/data/models/transaction_model.dart';
import 'package:kobi_pay/features/transactions/presentation/pages/transaction_detail_page.dart';
import 'package:kobi_pay/features/transactions/presentation/pages/transaction_page.dart';

import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.transactioHistory,
      builder: (context, state) => const TransactionScreen(),
    ),

    GoRoute(
      path: RouteNames.transactioHistoryDetail,
      builder: (context, state) {
        final tx = state.extra as TransactionModel;
        return TransactionDetailPage(transactionId: tx.id);
      },
    ),
  ],
);
