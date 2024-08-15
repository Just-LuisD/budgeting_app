import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final curencyFormatter = NumberFormat.simpleCurrency();

class IncomeList extends StatelessWidget {
  final List<Income> incomeList;
  final void Function(int) deleteItem;
  final void Function(Income) updateItem;
  const IncomeList({
    super.key,
    required this.incomeList,
    required this.deleteItem,
    required this.updateItem,
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
                  onUpdate: updateItem,
                );
              },
            ),
          );
  }
}

class IncomeItem extends StatelessWidget {
  final Income income;
  final void Function(int) onDelete;
  final void Function(Income) onUpdate;
  const IncomeItem({
    super.key,
    required this.income,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(income.title),
      subtitle: Text(curencyFormatter.format(income.amount / 100)),
      trailing: IconButton(
        onPressed: () {
          onDelete(income.id!);
        },
        icon: const Icon(Icons.delete),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: IncomeForm(
                onSubmit: onUpdate,
                income: income,
              ),
            );
          },
        );
      },
    );
  }
}
