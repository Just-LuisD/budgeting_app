import 'package:budgeting_app/domain/entities/income.dart';
import 'package:flutter/material.dart';

class IncomeList extends StatelessWidget {
  final List<Income> incomeList;
  final void Function(int) deleteItem;
  const IncomeList({
    super.key,
    required this.incomeList,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return incomeList.isEmpty
        ? const Text("No Income Found")
        : Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: incomeList.length,
              itemBuilder: (context, idx) {
                return IncomeItem(
                  income: incomeList[idx],
                  onDelete: deleteItem,
                );
              },
            ),
          );
  }
}

class IncomeItem extends StatelessWidget {
  final Income income;
  final void Function(int) onDelete;
  const IncomeItem({
    super.key,
    required this.income,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(income.title),
      subtitle: Text(income.amount.toString()),
      trailing: IconButton(
        onPressed: () {
          onDelete(income.id!);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
