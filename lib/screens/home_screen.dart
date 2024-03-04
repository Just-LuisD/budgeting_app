import 'package:budgeting_app/screens/budget_screen.dart';
import 'package:budgeting_app/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget scaffoldBody;
    switch (currentPageIndex) {
      case 1:
        scaffoldBody = const TransactionsScreen();
      case 2:
        scaffoldBody = const BudgetScreen();
      default:
        scaffoldBody = const Text("Homescreen place holder");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Some clever title'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: scaffoldBody,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Transactions',
            selectedIcon: Icon(Icons.monetization_on),
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Budget',
            selectedIcon: Icon(Icons.pie_chart),
          ),
        ],
      ),
    );
  }
}
