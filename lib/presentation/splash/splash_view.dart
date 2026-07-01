import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 30,
            bottom: 150,
            child: Text(
              'Foodgo',
              style: GoogleFonts.lobster(
                fontSize: 85.sp,
                fontWeight: FontWeight.w400,
                height: 1.35,
                letterSpacing: 0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 30,
            child: GestureDetector(
              onTap: () {
                context.go('/login');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/stat_now.png',
                      width: 40.h,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Start Now',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
