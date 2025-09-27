import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_bloc.dart';
import 'package:kobi_pay/features/transactions/logic/bloc/transaction_state.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionChart extends StatelessWidget {
  const TransactionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TransactionLoaded) {
          final totals = state.statusTotals;
          final totalAmount = totals.values.fold(0.0, (a, b) => a + b);

          return Column(
            children: [
              SizedBox(
                height: 30.h,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        centerSpaceRadius: 20.w,
                        sectionsSpace: 0,
                        sections: [
                          if (totals["successful"]! > 0)
                            PieChartSectionData(
                              showTitle: false,
                              color: const Color(0xFF46d49c),
                              value: totals["successful"],
                              radius: 11.w,
                            ),
                          if (totals["failed"]! > 0)
                            PieChartSectionData(
                              showTitle: false,
                              color: const Color(0xFFE57373),
                              value: totals["failed"],
                              radius: 11.w,
                            ),
                          if (totals["refunded"]! > 0)
                            PieChartSectionData(
                              showTitle: false,
                              color: const Color(0xFFFFB74D),
                              value: totals["refunded"],
                              radius: 11.w,
                            ),
                        ],
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                totalAmount.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.w, top: 0.4.h),
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Netflix Expenses",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIndicators("Success", const Color(0xFF46d49c)),
                    _buildIndicators("Failed", const Color(0xFFE57373)),
                    _buildIndicators("Refunded", const Color(0xFFFFB74D)),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildIndicators(String label, Color color) {
    return Row(
      children: [
        Container(width: 2.w, height: 2.w, color: color),
        SizedBox(width: 1.w),
        Text(label, style: TextStyle(fontSize: 9.sp)),
      ],
    );
  }
}
