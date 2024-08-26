import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_bloc.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_event.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/widgets/category_header.dart';
import 'package:budgeting_app/presentation/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  bool _showList = true;

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  void _addCategory(Category category) {
    context
        .read<BudgetDetailsBloc>()
        .add(AddCategoryEvent(newCategory: category));
  }

  void _deleteCategory(int categoryId) {
    context
        .read<BudgetDetailsBloc>()
        .add(DeleteCategoryEvent(categoryId: categoryId));
  }

  void _updateCategory(Category newCategory) {
    context
        .read<BudgetDetailsBloc>()
        .add(UpdateCategoryEvent(updatedCategory: newCategory));
  }

  int _getTotal(int categoryId) {
    final expenses = context.read<BudgetDetailsBloc>().state.expenses;
    int total = 0;
    for (Expense expense in expenses) {
      if (expense.categoryId == categoryId) {
        total += expense.amount;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CateggoryHeader(
          showingList: _showList,
          onToggle: _toggleList,
          onAdd: _addCategory,
        ),
        if (_showList)
          BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
            buildWhen: (previous, current) =>
                previous.categories != current.categories,
            builder: (context, state) {
              return CategoryList(
                categories: state.categories,
                deleteItem: _deleteCategory,
                updateItem: _updateCategory,
                getItemTotal: _getTotal,
              );
            },
          ),
      ],
    );
  }
}
