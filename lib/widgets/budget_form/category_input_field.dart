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
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          height: 60,
          child: SegmentedButton(
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              DropdownMenu(
                hintText: "Select Category",
                width: 220,
                dropdownMenuEntries: menuItems,
                onSelected: (value) => setState(
                  () {
                    selectedCategy = value!;
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {},
              child: Text('Add'),
            ),
          ),
        ),
      ],
    );
  }
}
