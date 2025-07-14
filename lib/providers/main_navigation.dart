import 'package:flutter/material.dart';
import 'package:groceries_appp/screens/cart_screen.dart';
import 'package:groceries_appp/screens/favourites_screen.dart';
import 'package:groceries_appp/screens/home_screen.dart';
import 'package:groceries_appp/screens/profile_screen.dart';
import 'package:groceries_appp/screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart'; 

// MainNavigation widget that provides a bottom navigation bar for the app
class MainNavigation extends StatelessWidget {
  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: pages[navigation.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigation.selectedIndex,
        onTap: navigation.changePage,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
