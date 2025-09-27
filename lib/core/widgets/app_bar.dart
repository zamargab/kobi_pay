import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';

class ClearAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ClearAppbar({
    super.key,
    required this.title,
    required this.widgets,
    required this.backArrowTap,
  });

  final String title;
  final List<Widget> widgets;
  final VoidCallback backArrowTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: InkWell(
        onTap: backArrowTap,
        child: Container(
          margin: EdgeInsets.only(left: isIOS ? 4.w : 2.w, bottom: 1.5.w),
          padding: EdgeInsets.all(isIOS ? 2.5.w : 1.5.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Icon(
            isIOS ? CupertinoIcons.chevron_back : Icons.arrow_back,
            size: isIOS ? 15.sp : 18.sp,
            color: Colors.black,
          ),
        ),
      ),
      actions: widgets,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: isIOS ? 14.sp : 13.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2E2E2E),
        ),
      ),
    );
  }
}
