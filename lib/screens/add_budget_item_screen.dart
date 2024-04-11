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
  late TextEditingController amoutController;
  late TextEditingController percentController;
  late double amount;
  late double percent;

  void handleOnAdd() {
    if (selectedCategy == null) {
      // TODO: show modal
      return;
    }
    // TODO: add check for valid ammount
    double? selectedAmount = double.tryParse(amoutController.text);
    if (selectedAmount == null ||
        selectedAmount <= 0 ||
        (selectedAmount > 100 && isPercent)) {
      // TODO: show modal
      return;
    }

    if (isPercent) {
      selectedAmount = selectedAmount / 100;
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
    // TODO: add check for balid ammount
    double? selectedAmount = double.tryParse(amoutController.text);
    if (selectedAmount == null ||
        selectedAmount <= 0 ||
        (selectedAmount > 100 && isPercent)) {
      // TODO: show modal
      return;
    }
    if (isPercent) {
      selectedAmount = selectedAmount / 100;
    }
    context
        .read<BudgetFormCubit>()
        .editCategory(widget.initialCategory!, selectedCategy!, selectedAmount);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    isPercent = false;
    percent = 0;
    amount = 0;
    selectedCategy = widget.initialCategory;
    menuItems = [];
    amoutController = TextEditingController();
    percentController = TextEditingController();
    double? initialAmount = widget.initialAmount;
    if (initialAmount != null) {
      if (initialAmount < 1) {
        percentController.text = initialAmount.toString();
        amoutController.text =
            (initialAmount * context.read<BudgetFormCubit>().state.income)
                .toString();
      } else {
        amoutController.text = initialAmount.toString();
        percentController.text =
            ((initialAmount / context.read<BudgetFormCubit>().state.income) *
                    100)
                .toString();
      }
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
    amoutController.dispose();
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 26),
            child: Center(
              child: AmountPercentField(),
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
