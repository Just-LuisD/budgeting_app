import 'package:budgeting_app/clean_architecture/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_state.dart';
import 'package:budgeting_app/clean_architecture/presentation/screens/add_budget_screen.dart';
import 'package:budgeting_app/clean_architecture/presentation/widgets/budget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgets'),
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            final budgets = state.budgets;
            return budgets.isEmpty
                ? Center(child: Text('No budgets available'))
                : ListView.builder(
                    itemCount: budgets.length,
                    itemBuilder: (context, index) {
                      final budget = budgets[index];
                      return BudgetCard(
                        key: Key(budget.id!.toString()),
                        budget: budget,
                      );
                    },
                  );
          } else if (state is BudgetError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => BudgetBloc(BudgetRepositoryImpl()),
                      child: AddBudgetScreen(),
                    )),
          );
          if (result == true) {
            context.read<BudgetBloc>().add(FetchBudgets());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
