import 'package:budgeting_app/domain/entities/income.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
          buildWhen: (previous, current) =>
              previous.income != current.income ||
              previous.budget?.income != current.budget?.income,
          builder: (context, state) {
            int totalIncome = 0;
            for (Income income in state.income) {
              totalIncome += income.amount;
            }
            if (state.status == BudgetDetailsStatus.success) {
              return ProgressBar(
                label: "Income",
                minVal: 0,
                maxVal: state.budget!.income,
                value: totalIncome,
                height: 20,
                color: Colors.green,
                backgroundColor: Colors.grey,
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
