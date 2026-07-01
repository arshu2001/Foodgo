import 'package:flutter_riverpod/flutter_riverpod.dart';

class BurgerItem {
  final String id;
  final String imagePath;
  final String title;
  final String subtitle;
  final double rating;
  final bool isFavorite;
  final String category;

  BurgerItem({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.rating,
    this.isFavorite = false,
    required this.category,
  });

  BurgerItem copyWith({bool? isFavorite}) {
    return BurgerItem(
      id: id,
      imagePath: imagePath,
      title: title,
      subtitle: subtitle,
      rating: rating,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category,
    );
  }
}

class HomeState {
  final List<BurgerItem> burgers;
  final String searchQuery;

  HomeState({required this.burgers, this.searchQuery = ''});

  HomeState copyWith({List<BurgerItem>? burgers, String? searchQuery}) {
    return HomeState(
      burgers: burgers ?? this.burgers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<BurgerItem> get filteredBurgers {
    if (searchQuery.isEmpty) return burgers;
    return burgers
        .where((b) =>
            b.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            b.subtitle.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel()
      : super(HomeState(
          burgers: [
            BurgerItem(
              id: '1',
              imagePath: 'assets/images/Cheeseburger.png',
              title: 'Cheeseburger',
              subtitle: "Wendy's Burger",
              rating: 4.9,
              category: 'Classic',
            ),
            BurgerItem(
              id: '2',
              imagePath: 'assets/images/Hamburger.png',
              title: 'Hamburger',
              subtitle: 'Veggie Burger',
              rating: 4.8,
              category: 'Sliders',
            ),
            BurgerItem(
              id: '3',
              imagePath: 'assets/images/Hamburger1.png',
              title: 'Hamburger',
              subtitle: 'Chicken Burger',
              rating: 4.6,
              category: 'Combos',
            ),
            BurgerItem(
              id: '4',
              imagePath: 'assets/images/Hamburger2.png',
              title: 'Hamburger',
              subtitle: 'Fried Chicken Burger',
              rating: 4.5,
              category: 'Classic',
            ),
          ],
        ));

  void toggleFavorite(String id) {
    final updatedBurgers = state.burgers.map((item) {
      if (item.id == id) {
        return item.copyWith(isFavorite: !item.isFavorite);
      }
      return item;
    }).toList();
    state = state.copyWith(burgers: updatedBurgers);
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}
