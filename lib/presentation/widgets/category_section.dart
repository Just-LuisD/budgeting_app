import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_bloc.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_event.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/widgets/category_form.dart';
import 'package:budgeting_app/presentation/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
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
    return BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
      buildWhen: (previous, current) =>
          previous.categories != current.categories,
      builder: (context, state) {
        return Stack(
          children: [
            CategoryList(
              categories: state.categories,
              deleteItem: _deleteCategory,
              updateItem: _updateCategory,
              getItemTotal: _getTotal,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
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
                          onSubmit: _addCategory,
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
