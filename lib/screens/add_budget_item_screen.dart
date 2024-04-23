import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:budgeting_app/models/category.dart';
import 'package:budgeting_app/widgets/budget_form/amount_percent_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBudgetItemScreen extends StatefulWidget {
  final Category? initialCategory;
  final double? initialAmount;
  const AddBudgetItemScreen({
    super.key,
    this.initialCategory,
    this.initialAmount,
  });

  @override
  State<AddBudgetItemScreen> createState() => _AddBudgetItemScreenState();
}

class _AddBudgetItemScreenState extends State<AddBudgetItemScreen> {
  late Category? selectedCategy;
  late bool isPercent;
  late List<DropdownMenuEntry<Category>> menuItems;
  late TextEditingController amountController;
  late TextEditingController percentController;

  void handleOnAdd() {
    if (selectedCategy == null) {
      // TODO: show modal
      return;
    }
    // TODO: add check for valid ammount
    double? selectedAmount = double.tryParse(amountController.text);

    if (selectedAmount == null ||
        selectedAmount <= 0 ||
        selectedAmount >
            context.read<BudgetFormCubit>().state.remainingIncome) {
      // TODO: show modal
      return;
    }

    context
        .read<BudgetFormCubit>()
        .addCategory(selectedCategy!, selectedAmount);
    Navigator.of(context).pop();
  }

  void handleOnDelete() {
    Category? deletedCategory = widget.initialCategory ?? selectedCategy;
    if (deletedCategory == null) {
      // TODO: show modal
      return;
    }
    context.read<BudgetFormCubit>().deleteCategory(deletedCategory);
    Navigator.of(context).pop();
  }

  void handleOnEdit() {
    if (selectedCategy == null && widget.initialCategory == null) {
      // TODO: show modal
      return;
    }

    // TODO: add check for valid ammount
    double? selectedAmount = double.tryParse(amountController.text);
    if (selectedAmount == null ||
        selectedAmount <= 0 ||
        selectedAmount >
            context.read<BudgetFormCubit>().state.remainingIncome) {
      // TODO: show modal
      return;
    }

    context
        .read<BudgetFormCubit>()
        .editCategory(widget.initialCategory!, selectedCategy!, selectedAmount);
    Navigator.of(context).pop();
  }

  void updateValue(String? val) {
    if (isPercent) {
      double value = double.tryParse(percentController.text) ?? 0;
      double amount =
          (value / 100) * context.read<BudgetFormCubit>().state.income;

      amountController.text = amount.toStringAsFixed(2);
    } else {
      double value = double.tryParse(amountController.text) ?? 0;
      double percent =
          (value / context.read<BudgetFormCubit>().state.income) * 100;

      percentController.text = percent.toStringAsFixed(2);
    }
  }

  @override
  void initState() {
    super.initState();
    isPercent = false;
    selectedCategy = widget.initialCategory;
    menuItems = [];
    amountController = TextEditingController(text: "0.00");
    percentController = TextEditingController(text: "0.00");
    double? initialAmount = widget.initialAmount;
    if (initialAmount != null) {
      amountController.text = initialAmount.toString();
      percentController.text =
          ((initialAmount / context.read<BudgetFormCubit>().state.income) * 100)
              .toString();
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
    amountController.dispose();
    percentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Budget Item"),
        actions: [
          IconButton(
              onPressed: widget.initialCategory == null ? null : handleOnDelete,
              icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: DropdownMenu(
                hintText: "Select Category",
                width: 325,
                dropdownMenuEntries: menuItems,
                initialSelection: widget.initialCategory,
                onSelected: (value) => setState(
                  () {
                    selectedCategy = value!;
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
            child: Center(
              child: AmountPercentField(
                amountController: amountController,
                percentController: percentController,
                isPercent: isPercent,
                onChanged: updateValue,
                onPercent: (value) {
                  if (value == true) {
                    setState(() {
                      isPercent = value!;
                    });
                  }
                },
                onAmount: (value) {
                  if (value == true) {
                    setState(() {
                      isPercent = !value!;
                    });
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    widget.initialCategory == null ? handleOnAdd : handleOnEdit,
                child: widget.initialCategory == null
                    ? const Text('Add')
                    : const Text("Save Changes"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
