import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class HomeCategories extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onChanged;

  const HomeCategories({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final selected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              margin: EdgeInsets.only(right: 15.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: selected
                    ? AppTheme.primaryColor
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color:
                        selected ? Colors.white : Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}