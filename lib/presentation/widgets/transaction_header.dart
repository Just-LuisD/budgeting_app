import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/transaction_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TransactionHeader extends StatelessWidget {
  final bool showingList;
  final Function onToggle;
  final void Function(Expense) addExpense;
  final void Function(Income) addIncome;
  final Future<List<Category>> Function() getCategories;

  const TransactionHeader({
    super.key,
    required this.showingList,
    required this.onToggle,
    required this.addExpense,
    required this.addIncome,
    required this.getCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onToggle();
          },
          icon: Icon(showingList == true
              ? Icons.arrow_drop_down
              : Icons.arrow_right_outlined),
        ),
        const Expanded(
          child: Text("Transactions"),
        ),
        IconButton(
          onPressed: () {
            getCategories().then(
              (categories) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: TransactionBottomSheet(
                      addExpense: addExpense,
                      addIncome: addIncome,
                      categories: categories,
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
