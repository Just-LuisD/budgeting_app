import 'package:budgeting_app/clean_architecture/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/clean_architecture/data/repositories/expense_repository_impl.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/screens/budget_list_screen.dart';
import 'package:budgeting_app/clean_architecture/presentation/screens/expense_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        scaffoldBody = BlocProvider(
          create: (context) {
            return ExpenseBloc(ExpenseRepositoryImpl())..add(FetchExpenses(1));
          },
          child: const ExpenseListScreen(),
        );
      case 2:
        scaffoldBody = BlocProvider(
          create: (context) =>
              BudgetBloc(BudgetRepositoryImpl())..add(FetchBudgets()),
          child: const BudgetListScreen(),
        );
      default:
        scaffoldBody = Text("Home Screen Placeholder");
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
