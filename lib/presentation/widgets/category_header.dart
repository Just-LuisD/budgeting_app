import 'package:budgeting_app/presentation/widgets/category_form.dart';
import 'package:flutter/material.dart';

class CateggoryHeader extends StatelessWidget {
  final bool showingList;
  final Function onToggle;

  const CateggoryHeader({
    super.key,
    required this.showingList,
    required this.onToggle,
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
          child: Text("Categories"),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return CategoryForm();
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
