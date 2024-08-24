import 'package:budgeting_app/data/repositories/income_repository_impl.dart';
import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class IncomeProgressBar extends StatefulWidget {
  final Budget budget;
  const IncomeProgressBar({
    super.key,
    required this.budget,
  });

  @override
  State<IncomeProgressBar> createState() => _IncomeProgressBarState();
}

class _IncomeProgressBarState extends State<IncomeProgressBar> {
  IncomeRepositoryImpl incomeRepository = IncomeRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder(
          future: incomeRepository.getTotalIncome(widget.budget.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ProgressBar(
                label: "Income",
                minVal: 0,
                maxVal: widget.budget.income,
                value: snapshot.data!,
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
