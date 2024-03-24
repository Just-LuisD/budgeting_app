import 'package:budgeting_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:budgeting_app/widgets/budget_form/percent_field.dart';
import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';

class AddBudgetItemScreen extends StatefulWidget {
  final Function(Category, double, bool) onAdd;
  final void Function()? onDelete;
  final Category? initialCategory;
  final double? initialAmount;
  const AddBudgetItemScreen({
    super.key,
    required this.onAdd,
    required this.onDelete,
    this.initialCategory,
    this.initialAmount,
  });

  @override
  State<AddBudgetItemScreen> createState() => _AddBudgetItemScreenState();
}

class _AddBudgetItemScreenState extends State<AddBudgetItemScreen> {
  late Category? selectedCategy;
  late bool percent;
  late List<DropdownMenuEntry<Category>> menuItems;
  late TextEditingController amoutPrecentController;

  void handleOnAdd() {
    if (selectedCategy == null) {
      // TODO: show modal
      return;
    }
    // TODO: add check for balid ammount
    double? selectedAmount = double.tryParse(amoutPrecentController.text);
    if (selectedAmount == null ||
        selectedAmount <= 0 ||
        (selectedAmount > 100 && percent)) {
      // TODO: show modal
      return;
    }
    widget.onAdd(
      selectedCategy!,
      selectedAmount,
      percent,
    );
    Navigator.of(context).pop();
  }

  void handleOnDelete() {
    widget.onDelete!();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    percent = false;
    selectedCategy = null;
    menuItems = [];
    amoutPrecentController = TextEditingController();
    if (widget.initialAmount != null) {
      amoutPrecentController.text = widget.initialAmount.toString();
    }
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
  void dispose() {
    amoutPrecentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Budget Item"),
        actions: [
          IconButton(
              onPressed: widget.onDelete == null ? null : handleOnDelete,
              icon: Icon(Icons.delete))
        ],
      ),
      body: ListView(
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
                  initialSelection: widget.initialCategory,
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
                          inputController: amoutPrecentController,
                          label: "Percentage",
                        )
                      : AmountField(
                          inputController: amoutPrecentController,
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
                onPressed: handleOnAdd,
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
