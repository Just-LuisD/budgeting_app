import 'package:budgeting_app/models/category.dart';
import 'package:budgeting_app/screens/add_budget_item_screen.dart';
import 'package:budgeting_app/widgets/budget_form/budget_item.dart';
import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';
import 'package:fl_chart/fl_chart.dart';
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

  void showBudgetItemForm({
    Category? editCategory,
    double? editAmount,
    Key? itemKey,
  }) {
    var deleteFunction;
    if (itemKey != null) {
      deleteFunction = () => {deleteCategory(itemKey)};
    } else {
      deleteFunction = null;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => AddBudgetItemScreen(
        onDelete: deleteFunction,
        onAdd: addBudgetItem,
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
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: AmountField(
                label: "Income",
                inputController: incomeInputController,
              ),
            ),
            SegmentedButton(
              showSelectedIcon: false,
              segments: [
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
        SizedBox(
          height: 175,
          child: PieChart(PieChartData(
            centerSpaceRadius: 0,
            sections: [
              if (income != null)
                PieChartSectionData(
                  titlePositionPercentageOffset: 0,
                  title: "Income",
                  value: income,
                  radius: 100,
                  showTitle: true,
                  color: Color.fromARGB(255, 203, 255, 119),
                )
              else
                PieChartSectionData(
                  titlePositionPercentageOffset: 0,
                  title: "Please Add Income",
                  value: 1,
                  radius: 100,
                  showTitle: true,
                  color: Color.fromARGB(255, 158, 157, 157),
                )
            ],
          )),
        ),
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: toggleCategories,
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  Spacer(),
                  IconButton(
                    alignment: AlignmentDirectional.centerEnd,
                    onPressed: showBudgetItemForm,
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              if (showCategories)
                if (budgetItems.isNotEmpty)
                  ...(budgetItems)
                else
                  Text("No Budget Items Found"),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: null,
          child: Text("Submit"),
        ),
      ]
          .map((child) => Padding(
                padding: EdgeInsets.all(10),
                child: child,
              ))
          .toList(),
    ));
  }
}
