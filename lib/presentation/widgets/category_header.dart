import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/presentation/widgets/category_form.dart';
import 'package:flutter/material.dart';

class CateggoryHeader extends StatelessWidget {
  final bool showingList;
  final Function onToggle;
  final void Function(Category) onAdd;

  const CateggoryHeader({
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
          child: Text("Categories"),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CategoryForm(
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
