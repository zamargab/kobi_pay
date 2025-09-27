import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kobi_pay/core/constants/app_icons.dart';
import 'package:kobi_pay/core/utils/format_date_time.dart';
import 'package:kobi_pay/core/utils/string_utils.dart';
import 'package:kobi_pay/core/widgets/app_bar.dart';
import 'package:kobi_pay/core/widgets/dialogs.dart';
import 'package:kobi_pay/core/widgets/buttons.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_bloc.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_event.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_state.dart';
import 'package:kobi_pay/features/transactions/presentation/widgets/refund_confirmation.dart';
import 'package:kobi_pay/features/transactions/presentation/widgets/transaction_company_info.dart';
import 'package:kobi_pay/features/transactions/presentation/widgets/transaction_detail_box.dart';
import 'package:sizer/sizer.dart';

class TransactionDetailPage extends StatelessWidget {
  final String transactionId;

  const TransactionDetailPage({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClearAppbar(
        title: "Transaction Detail",
        widgets: [],
        backArrowTap: () => context.pop(),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoaded) {
            final transaction = state.transactions.firstWhere(
              (t) => t.id == transactionId,
            );

            return Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Center(child: TransactionCompanyInfo()),
                  SizedBox(height: 3.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transaction.amount.toString(),
                        style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: SvgPicture.asset(
                          AppIcons.dollar,
                          color: Color(0xFFE57373),
                          height: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        TransactionDetailBox(
                          title: "Payment",
                          value: StringUtils.capitalizeFirstLetter(
                            transaction.title,
                          ),
                        ),
                        TransactionDetailBox(
                          title: "Status",
                          value: StringUtils.capitalizeFirstLetter(
                            transaction.status,
                          ),
                          valuetextColor: transaction.status == 'successful'
                              ? Colors.green
                              : transaction.status == 'refunded'
                              ? Colors.orange
                              : Colors.red,
                        ),
                        TransactionDetailBox(
                          title: "Method",
                          value: StringUtils.capitalizeFirstLetter(
                            transaction.paymentMethod,
                          ),
                        ),
                        TransactionDetailBox(
                          title: "Date",
                          value: formatDateTime(transaction.date),
                        ),
                      ],
                    ),
                  ),

                  Expanded(child: SizedBox(height: 3.h)),

                  GradientButton(
                    isEnabled: transaction.status != 'refunded',
                    text: "Apply for refund",
                    onPressed: () {
                      AppDialogs.show(
                        context: context,
                        child: RefundConfirmation(
                          refund: () {
                            context.pop();
                            context.read<TransactionBloc>().add(
                              RefundTransaction(transaction.id),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const Center(child: Text("Transaction not found"));
        },
      ),
    );
  }
}
