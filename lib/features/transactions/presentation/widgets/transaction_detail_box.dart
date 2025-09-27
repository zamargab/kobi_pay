import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransactionDetailBox extends StatelessWidget {
  const TransactionDetailBox({
    super.key,
    required this.title,
    required this.value,
    this.valuetextColor,
  });
  final String title, value;
  final Color? valuetextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: valuetextColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
