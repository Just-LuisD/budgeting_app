import 'package:budgeting_app/models/category.dart';
import 'package:budgeting_app/screens/add_budget_item_screen.dart';
import 'package:budgeting_app/widgets/budget_form/budget_item.dart';
import 'package:budgeting_app/widgets/budget_form/budget_creation_piechart.dart';
import 'package:budgeting_app/widgets/budget_form/budget_items_view.dart';
import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';
import 'package:flutter/material.dart';

enum IncomeType { netIncome, grossIncome }

class BudgetForm extends StatefulWidget {
  const BudgetForm({super.key});

  @override
  State<BudgetForm> createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  late TextEditingController incomeInputController;
  late IncomeType selectedIncomeType;
  late bool showCategories;
  late List<BudgetItem> budgetItems;

  @override
  void initState() {
    super.initState();
    showCategories = true;
    selectedIncomeType = IncomeType.netIncome;
    incomeInputController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    budgetItems = [];
  }

  void toggleCategories() {
    setState(() {
      showCategories = !showCategories;
    });
  }

  void deleteCategory(Key key) {
    setState(() {
      budgetItems = budgetItems.where((element) => element.key != key).toList();
    });
  }

  void onEditCategory(
    Category category,
    double amount,
    bool isPercent,
    Key replaceKey,
  ) {
    double itemAmount;
    double income = double.tryParse(incomeInputController.text) ?? 0;
    if (isPercent) {
      itemAmount = (amount / 100) * income;
    } else {
      itemAmount = amount;
    }

    var key = UniqueKey();
    BudgetItem newItem = BudgetItem(
      key: key,
      category: category,
      amount: itemAmount,
      onEdit: (Category c, double d) => {
        showBudgetItemForm(
          editCategory: c,
          editAmount: d,
          itemKey: key,
        ),
      },
    );

    setState(() {
      var index =
          budgetItems.indexWhere((element) => element.key == replaceKey);
      var updatedList = [...budgetItems];
      updatedList[index] = newItem;
      budgetItems = updatedList;
    });
  }

  void showBudgetItemForm({
    Category? editCategory,
    double? editAmount,
    Key? itemKey,
  }) {
    double? income = double.tryParse(incomeInputController.text);
    if (income == null || income <= 0) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  "Please Enter Your Income",
                ),
                content: Text(
                  "You cannod add budget items before providing your monthly income.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text("Dismiss"),
                  ),
                ],
              ));
      return;
    }

    var deleteFunction;
    var editFunction;
    if (itemKey != null) {
      deleteFunction = () => {deleteCategory(itemKey)};
      editFunction =
          (Category c, double d, bool b) => {onEditCategory(c, d, b, itemKey)};
    } else {
      deleteFunction = null;
      editFunction = null;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => AddBudgetItemScreen(
        onDelete: deleteFunction,
        onAdd: addBudgetItem,
        onEdit: editFunction,
        initialCategory: editCategory,
        initialAmount: editAmount,
      ),
    );
  }

  void addBudgetItem(Category category, double amount, bool isPercent) {
    double itemAmount;
    double income = double.tryParse(incomeInputController.text) ?? 0;
    if (isPercent) {
      itemAmount = (amount / 100) * income;
    } else {
      itemAmount = amount;
    }

    var key = UniqueKey();
    BudgetItem newItem = BudgetItem(
      key: key,
      category: category,
      amount: itemAmount,
      onEdit: (Category c, double d) => {
        showBudgetItemForm(
          editCategory: c,
          editAmount: d,
          itemKey: key,
        ),
      },
    );
    setState(() {
      budgetItems = [newItem, ...budgetItems];
    });
  }

  @override
  Widget build(BuildContext context) {
    double? income = double.tryParse(incomeInputController.text);
    return Form(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Expanded(
                  child: AmountField(
                    label: "Income",
                    inputController: incomeInputController,
                  ),
                ),
                SegmentedButton(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      label: Text("Net"),
                      value: IncomeType.netIncome,
                    ),
                    ButtonSegment(
                      label: Text("Gross"),
                      value: IncomeType.grossIncome,
                    ),
                  ],
                  selected: {selectedIncomeType},
                  onSelectionChanged: (Set<IncomeType> newSelection) {
                    setState(() {
                      selectedIncomeType = newSelection.first;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SizedBox(
              height: 150,
              child: BudgetCreationPiechart(
                income: income,
                budgetItems: budgetItems,
              ),
            ),
          ),
          BudgetItemsView(
            toggleCategories: toggleCategories,
            showBudgetItemForm: showBudgetItemForm,
            showCategories: showCategories,
            budgetItems: budgetItems,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: null,
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
