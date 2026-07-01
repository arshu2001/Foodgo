import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Foodgo",
              style: AppTheme.lobsterTitle.copyWith(
                fontSize: 45.sp,
                color: AppTheme.blackcolor,
                height: 1.35,
              ),
            ),
            Text(
              "Order your favourite food!",
              style: TextStyle(
                fontSize: 18.spMin,
                color: AppTheme.textgray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 25.r,
          backgroundImage:
              const AssetImage("assets/images/Mask group.png"),
        ),
      ],
    );
  }
}