import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kobi_pay/core/constants/app_icons.dart';
import 'package:kobi_pay/core/widgets/buttons.dart';
import 'package:sizer/sizer.dart';

class RefundConfirmation extends StatelessWidget {
  const RefundConfirmation({super.key, required this.refund});
  final VoidCallback refund;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 2.h),
          SvgPicture.asset(AppIcons.question, height: 9.h),
          SizedBox(height: 2.h),
          Text(
            "Are you sure you want to apply for a refund?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlineButtonCustom(
                  text: "Cancel",
                  onPressed: () => context.pop(),
                  outlineColor: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GradientButton(text: "Proceed", onPressed: refund),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
