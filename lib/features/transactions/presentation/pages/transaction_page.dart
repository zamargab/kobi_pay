import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kobi_pay/core/constants/app_icons.dart';
import 'package:kobi_pay/core/routes/route_names.dart';
import 'package:kobi_pay/core/widgets/app_bar.dart';
import 'package:kobi_pay/core/widgets/loading_states.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_bloc.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_state.dart';
import 'package:kobi_pay/features/transactions/presentation/widgets/pop_up.dart';
import 'package:sizer/sizer.dart';
import '../widgets/widgets.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  bool isIOS() => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = isIOS() ? 6.w : 5.w;
    final verticalPadding = isIOS() ? 3.h : 2.h;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: ClearAppbar(
        title: "History",
        widgets: [PopUp()],
        backArrowTap: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TransactionLoaded) {
                final transactions = state.monthFilteredTransactions;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TransactionCompanyInfo(),
                      SizedBox(height: 4.5.h),
                      TransactionTotalPayment(),
                      SizedBox(height: 3.h),
                      TransactionChart(),
                      SizedBox(height: 4.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Transaction",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      transactions.isEmpty
                          ? EmptyState(
                              desc: "Your transactions will be displayed here",
                              svg: AppIcons.emptyWallet,
                              title: "No transactions",
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                final data = transactions[index];
                                return InkWell(
                                  onTap: () {
                                    context.push(
                                      RouteNames.transactioHistoryDetail,
                                      extra: data,
                                    );
                                  },
                                  child: TransactionCard(transaction: data),
                                );
                              },
                            ),
                    ],
                  ),
                );
              } else if (state is TransactionError) {
                return EmptyState(
                  desc: state.message,
                  svg: AppIcons.error,
                  title: "Error",
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
