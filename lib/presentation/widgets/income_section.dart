import 'package:budgeting_app/data/repositories/income_repository_impl.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/progress_bar.dart';
import 'package:budgeting_app/presentation/widgets/income_header.dart';
import 'package:budgeting_app/presentation/widgets/income_list.dart';
import 'package:flutter/material.dart';

class IncomeSection extends StatefulWidget {
  final int budgetId;
  const IncomeSection({
    super.key,
    required this.budgetId,
  });

  @override
  State<IncomeSection> createState() => _IncomeSectionState();
}

class _IncomeSectionState extends State<IncomeSection> {
  bool _showList = true;
  IncomeRepositoryImpl incomeRepository = IncomeRepositoryImpl();

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  void _addIncome(Income income) {
    incomeRepository.insertIncome(income.copy(budgetId: widget.budgetId));
    setState(() {});
  }

  void _deleteIncome(int incomeId) {
    incomeRepository.deleteIncome(incomeId);
    setState(() {});
  }

  void _updateIncome(Income newIncome) {
    incomeRepository.updateIncome(newIncome);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProgressBar(
          label: "Expected Income",
          minVal: 0,
          maxVal: 100,
          value: 35,
          height: 20,
          color: Colors.green,
          backgroundColor: Colors.grey,
        ),
        IncomeHeader(
          showingList: _showList,
          onToggle: _toggleList,
          onAdd: _addIncome,
        ),
        if (_showList)
          FutureBuilder(
            future: incomeRepository.getBudgetIncome(widget.budgetId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return IncomeList(
                  incomeList: snapshot.data!,
                  deleteItem: _deleteIncome,
                  updateItem: _updateIncome,
                );
              }
              return Container();
            },
          )
      ],
    );
  }
}
