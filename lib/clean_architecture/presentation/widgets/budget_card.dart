import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_event.dart';
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
      onTap: () {},
    );
  }
}
