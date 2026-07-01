import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo/presentation/home/home_viewmodel.dart';

import '../../../core/theme/app_theme.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                )
              ],
            ),
            child: TextField(
              onChanged: (value) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .updateSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Image.asset(
                    "assets/images/icons/search.png",
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Container(
          height: 60.h,
          width: 60.h,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: const Icon(Icons.tune, color: Colors.white),
        )
      ],
    );
  }
}