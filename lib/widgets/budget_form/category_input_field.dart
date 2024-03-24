import 'package:budgeting_app/models/category.dart';
import 'package:budgeting_app/widgets/budget_form/percent_field.dart';
import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';
import 'package:flutter/material.dart';

class CategoryInputField extends StatefulWidget {
  const CategoryInputField({
    super.key,
  });

  @override
  State<CategoryInputField> createState() => _CategoryInputFieldState();
}

class _CategoryInputFieldState extends State<CategoryInputField> {
  late Category? selectedCategy;
  late bool percent;
  late List<DropdownMenuEntry<Category>> menuItems;

  @override
  void initState() {
    super.initState();
    percent = false;
    selectedCategy = null;
    menuItems = [];
    for (Category category in defaultCategories) {
      if (!category.isIncome) {
        menuItems.add(
          DropdownMenuEntry(
            value: category,
            label: category.name,
            leadingIcon: Image.asset(
              category.image,
              scale: 2,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: percent
                  ? PercentField(
                      inputController: TextEditingController(),
                      label: "Percentage",
                    )
                  : AmountField(
                      inputController: TextEditingController(),
                      label: "Amount",
                    ),
            ),
            SegmentedButton(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: "\$",
                  icon: Text("\$"),
                ),
                ButtonSegment(
                  value: "%",
                  icon: Text("%"),
                ),
              ],
              selected: percent ? {"%"} : {"\$"},
              onSelectionChanged: (newSelection) {
                setState(() {
                  percent = newSelection.first == "%";
                });
              },
            ),
          ],
        ),
        DropdownMenu(
          hintText: "Select Category",
          width: 200,
          dropdownMenuEntries: menuItems,
          onSelected: (value) => setState(
            () {
              selectedCategy = value!;
            },
          ),
        ),
      ],
    );
  }
}
