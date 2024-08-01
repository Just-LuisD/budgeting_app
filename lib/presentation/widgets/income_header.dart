import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';

class IncomeHeader extends StatelessWidget {
  final bool showingList;
  final Function onToggle;
  final void Function(Income) onAdd;
  const IncomeHeader({
    super.key,
    required this.showingList,
    required this.onToggle,
    required this.onAdd,
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
          child: Text("Income"),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24))),
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: IncomeForm(
                    onSubmit: onAdd,
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
