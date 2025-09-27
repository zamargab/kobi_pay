import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kobi_pay/core/constants/app_icons.dart';
import 'package:sizer/sizer.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: PopupMenuThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
      ),
      child: PopupMenuButton(
        color: Colors.white,
        onSelected: (value) async {},
        icon: SvgPicture.asset(AppIcons.elipsis),
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(
              value: '1',
              child: Text(
                'Generate Statement',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 9.sp),
              ),
            ),
            PopupMenuItem(
              value: '1',
              child: Text(
                'Report Merchant',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 9.sp),
              ),
            ),
          ];
        },
      ),
    );
  }
}
