import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobi_pay/core/constants/app_constants.dart';
import 'package:kobi_pay/core/constants/app_icons.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_bloc.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_event.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_state.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionTotalPayment extends StatelessWidget {
  const TransactionTotalPayment({super.key});

  final List<String> months = AppConstants.months;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            double total = 0.0;

            if (state is TransactionLoaded) {
              total = state.monthlyTotal;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total payment",
                  style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${total.toStringAsFixed(2)} ",
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: SvgPicture.asset(
                        AppIcons.dollar,
                        color: Color(0xFFE57373),
                        height: 15.sp,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            String selectedMonth = "May";
            if (state is TransactionLoaded) {
              selectedMonth = state.selectedMonth;
            } else if (state is TransactionInitial) {
              selectedMonth = state.selectedMonth;
            }

            return PopupMenuTheme(
              data: PopupMenuThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.w),
                ),
              ),
              child: PopupMenuButton<String>(
                color: Colors.white,
                onSelected: (month) {
                  context.read<TransactionBloc>().add(MonthSelected(month));
                },
                icon: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        selectedMonth,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context) {
                  return months
                      .map(
                        (month) => PopupMenuItem<String>(
                          value: month,
                          child: Text(
                            month,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 10.sp),
                          ),
                        ),
                      )
                      .toList();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
