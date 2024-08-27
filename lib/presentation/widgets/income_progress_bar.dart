import 'package:budgeting_app/presentation/bloc/budget_details_bloc.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeProgressBar extends StatefulWidget {
  const IncomeProgressBar({
    super.key,
  });

  @override
  State<IncomeProgressBar> createState() => _IncomeProgressBarState();
}

class _IncomeProgressBarState extends State<IncomeProgressBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
      buildWhen: (previous, current) =>
          previous.income != current.income ||
          previous.budget?.income != current.budget?.income ||
          previous.status != current.status ||
          previous.totalSpent != current.totalSpent,
      builder: (context, state) {
        if (state.status == BudgetDetailsStatus.success) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${curencyFormatter.format(state.totalSpent / 100)} Spent",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              ProgressBar(
                minVal: 0,
                maxVal: state.budget!.income,
                value: state.totalSpent,
                height: 15,
                color: Colors.green,
                backgroundColor: Colors.grey,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
