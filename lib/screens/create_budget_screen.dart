import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:budgeting_app/widgets/budget_form/budget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBudgetScreen extends StatelessWidget {
  const CreateBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetFormCubit(),
      child: const Scaffold(
        body: BudgetForm(),
      ),
    );
  }
}
