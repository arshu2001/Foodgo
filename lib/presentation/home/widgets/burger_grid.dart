import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo/presentation/home/home_viewmodel.dart';
import 'package:foodgo/presentation/home/widgets/burger_cards.dart';


class BurgerGrid extends StatelessWidget {
  final List<BurgerItem> burgers;

  const BurgerGrid({
    super.key,
    required this.burgers,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 100.h,
      ),
      itemCount: burgers.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .73,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
      ),
      itemBuilder: (_, index) {
        return BurgerCard(
          burger: burgers[index],
        );
      },
    );
  }
}



class EmptyBurgerWidget extends StatelessWidget {
  final String searchQuery;
  final String category;

  const EmptyBurgerWidget({
    super.key,
    required this.searchQuery,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        searchQuery.isNotEmpty
            ? "No searched burger found"
            : "No ${category.toLowerCase()} burger found",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}