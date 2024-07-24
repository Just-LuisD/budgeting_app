import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';

class IncomeHeader extends StatelessWidget {
  final Function onSubmit;
  const IncomeHeader({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          // TODO fix this to refererence a state
          icon: Icon(true ? Icons.arrow_drop_down : Icons.arrow_right_outlined),
        ),
        const Expanded(
          child: Text("Income"),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return IncomeForm(onSubmit: onSubmit);
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
