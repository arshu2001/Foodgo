import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomNavClipper(),
      child: Container(
        height: 80.h,
        color: AppTheme.primaryColor,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset(
                  currentIndex == 0
                      ? 'assets/images/icons/home.png'
                      : 'assets/images/icons/home_unselected.png',
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
                onPressed: () => onTap(0),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/icons/user.png',
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
                onPressed: () => onTap(1),
              ),
              SizedBox(width: 40.w), // Space for floating action button
              IconButton(
                icon: Image.asset(
                  'assets/images/icons/comment.png',
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
                onPressed: () => onTap(2),
              ),
              IconButton(
                icon: Image.asset(
                  currentIndex == 3
                      ? 'assets/images/icons/heart_selected.png'
                      : 'assets/images/icons/heart.png',
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
                onPressed: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0.35, 0);

    path.cubicTo(
      size.width * 0.40,
      0,
      size.width * 0.42,
      35,
      size.width * 0.50,
      35,
    );

    path.cubicTo(
      size.width * 0.58,
      35,
      size.width * 0.60,
      0,
      size.width * 0.65,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
