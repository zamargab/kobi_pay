import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransactionCompanyInfo extends StatelessWidget {
  const TransactionCompanyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 8.w,
          backgroundImage: const AssetImage('assets/images/netflix.png'),
        ),
        SizedBox(height: 1.h),
        Text(
          "Netflix",
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          "Production Company",
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
