import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.desc,
    this.height,
    required this.svg,
    required this.title,
  });
  final String title, desc;
  final double? height;
  final String svg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1.h),
          SvgPicture.asset(svg, height: height ?? 12.h),
          SizedBox(height: 1.h),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 70.w,
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.desc,
    this.height,
    required this.svg,
    required this.title,
  });
  final String title, desc;
  final double? height;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1.h),
          SvgPicture.asset(svg, height: height ?? 12.h),

          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
