import 'package:budgeting_app/domain/entities/income.dart';
import 'package:flutter/material.dart';

class IncomeList extends StatelessWidget {
  final List<Income> incomeList;
  const IncomeList({
    super.key,
    required this.incomeList,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: incomeList.length,
        itemBuilder: (context, idx) {
          return IncomeItem(income: incomeList[idx]);
        },
      ),
    );
  }
}

class IncomeItem extends StatelessWidget {
  final Income income;
  const IncomeItem({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(income.title),
      subtitle: Text(income.amount.toString()),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
