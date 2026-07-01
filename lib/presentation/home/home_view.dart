import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo/presentation/home/widgets/burger_grid.dart';
import 'package:foodgo/presentation/home/widgets/home_categories.dart';
import 'package:foodgo/presentation/home/widgets/home_header.dart';
import 'package:foodgo/presentation/home/widgets/home_search_bar.dart';
import 'home_viewmodel.dart';
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedCategory = 0;

  final categories = [
    'All',
    'Combos',
    'Sliders',
    'Classic',
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    final selected = categories[selectedCategory];

    var burgers = state.filteredBurgers;

    if (selected != "All") {
      burgers =
          burgers.where((e) => e.category == selected).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: Column(
            children: [

              const HomeHeader(),

              SizedBox(height: 20.h),

              HomeSearchBar(),

              SizedBox(height: 20.h),

              HomeCategories(
                categories: categories,
                selectedIndex: selectedCategory,
                onChanged: (index) {
                  setState(() {
                    selectedCategory = index;
                  });
                },
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: burgers.isEmpty
                    ? EmptyBurgerWidget(
                        searchQuery: state.searchQuery,
                        category: selected,
                      )
                    : BurgerGrid(
                        burgers: burgers,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}