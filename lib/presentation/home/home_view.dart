import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_theme.dart';
import 'home_viewmodel.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'home_viewmodel.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'Combos', 'Sliders', 'Classic'];

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    final selectedCategory = _categories[_selectedCategoryIndex];

    var displayBurgers = homeState.filteredBurgers;
    if (selectedCategory != 'All') {
      displayBurgers =
          displayBurgers.where((b) => b.category == selectedCategory).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildHeader(),
              SizedBox(height: 20.h),
              _buildSearchBar(),
              SizedBox(height: 20.h),
              _buildCategories(),
              SizedBox(height: 20.h),
              Expanded(
                child: displayBurgers.isEmpty
                    ? Center(
                        child: Text(
                          homeState.searchQuery.isNotEmpty
                              ? 'No searched burger found'
                              : 'No ${selectedCategory.toLowerCase()} burger found',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : _buildBurgerGrid(displayBurgers),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foodgo',
              style: AppTheme.lobsterTitle.copyWith(
                  color: AppTheme.blackcolor, fontSize: 45.sp, height: 1.35),
            ),
            Text(
              'Order your favourite food!',
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
          backgroundImage: const AssetImage('assets/images/Mask group.png'),
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
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
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .updateSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: const Color(0xFF3C2F2F),
                    fontSize: 18.spMin,
                    fontWeight: FontWeight.w500),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Image.asset('assets/images/search.png',
                      width: 20.w, height: 20.h),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15.h),
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
          child: Center(
            child: Image.asset(
              'assets/images/settings-sliders.png',
              width: 24.w,
              height: 24.h,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 15.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBurgerGrid(List<BurgerItem> burgers) {
    return GridView.builder(
      padding: EdgeInsets.only(
          bottom: 100.h,
          top: 20.h,
          left: 5.h,
          right: 5.h), // padding for bottom nav
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
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.blackcolor,
                        height: 1.35,
                      ),
                    ),
                    Text(
                      burger.subtitle,
                      style: TextStyle(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF3C2F2F),
                        height: 1.39,
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
                            fontSize: 16.spMin,
                            fontWeight: FontWeight.w500,
                            height: 1.35,
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
