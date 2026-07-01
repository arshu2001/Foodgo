import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_theme.dart';
import '../home/home_viewmodel.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final favoriteBurgers =
        homeState.burgers.where((b) => b.isFavorite).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorites',
          style: TextStyle(
            color: AppTheme.blackcolor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: favoriteBurgers.isEmpty
            ? Center(
                child: Text(
                  'No favorites yet!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              )
            : _buildBurgerGrid(favoriteBurgers, ref),
      ),
    );
  }

  Widget _buildBurgerGrid(List<BurgerItem> burgers, WidgetRef ref) {
    return GridView.builder(
      padding: EdgeInsets.only(
          bottom: 100.h,
          top: 20.h,
          left: 20.w,
          right: 20.w), // matching padding
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.73,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
      ),
      itemCount: burgers.length,
      itemBuilder: (context, index) {
        final burger = burgers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 3,
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          burger.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      burger.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      burger.subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: AppTheme.primaryColor, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          burger.rating.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(homeViewModelProvider.notifier)
                        .toggleFavorite(burger.id);
                  },
                  child: Icon(
                    burger.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: burger.isFavorite
                        ? AppTheme.secondaryColor
                        : Colors.grey.shade400,
                    size: 24.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
