import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo/presentation/home/home_viewmodel.dart';

import '../../../core/theme/app_theme.dart';

class BurgerCard extends ConsumerWidget {
  final BurgerItem burger;

  const BurgerCard({
    super.key,
    required this.burger,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 4,
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      burger.imagePath,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  burger.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(burger.subtitle),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      burger.rating.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(homeViewModelProvider.notifier)
                    .toggleFavorite(burger.id);
              },
              child: Icon(
                burger.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: burger.isFavorite
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}