import 'package:flutter/material.dart';
import 'package:groceries_appp/providers/main_navigation.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';

// Main entry point of the application
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: GroceryApp(),
    ),
  );
}
// Main application widget
class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GroceryMart',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MainNavigation(),
    );
  }
}

