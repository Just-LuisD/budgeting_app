import 'package:budgeting_app/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/presentation/blocs/budget_event.dart';
import 'package:budgeting_app/presentation/screens/budget_list_screen.dart';
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
    return BlocProvider(
      create: (context) =>
          BudgetBloc(BudgetRepositoryImpl())..add(FetchBudgets()),
      child: const BudgetListScreen(),
    );
  }
}
