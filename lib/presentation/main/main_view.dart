import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_theme.dart';
import '../home/home_view.dart';
import '../favorites/favorites_view.dart';
import 'bottomnav/custom_bottom_nav.dart';

class MainView extends StatefulWidget {
  final int initialIndex;
  const MainView({super.key, this.initialIndex = 0});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Needed to let the body extend behind the bottom nav
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeView(),
          Container(
            color: Colors.white,
            child: const Center(child: Text('User Profile Placeholder')),
          ),
          Container(
            color: Colors.white,
            child: const Center(child: Text('Comments Placeholder')),
          ),
          const FavoritesView(),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryColor,
        shape: const CircleBorder(),
        elevation: 4,
        child: Image.asset('assets/images/plus.png', width: 24.w, height: 24.h),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
