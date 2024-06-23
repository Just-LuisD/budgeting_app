import 'package:budgeting_app/clean_architecture/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/screens/budget_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetCard extends StatelessWidget {
  final Budget budget;

  const BudgetCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(budget.name),
      subtitle: Text('Income: \$${budget.income.toStringAsFixed(2)}'),
      trailing: IconButton(
          onPressed: () {
            context.read<BudgetBloc>().add(DeleteBudget(budget.id!));
          },
          icon: const Icon(Icons.delete)),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => BudgetBloc(BudgetRepositoryImpl()),
              child: BudgetFormScreen(
                budget: budget,
              ),
            ),
          ),
        );
        if (result == true) {
          context.read<BudgetBloc>().add(FetchBudgets());
        }
      },
    );
  }
}
