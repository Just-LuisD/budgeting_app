import 'package:budgeting_app/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/presentation/blocs/budget_event.dart';
import 'package:budgeting_app/presentation/blocs/budget_state.dart';
import 'package:budgeting_app/presentation/widgets/budget_card.dart';
import 'package:budgeting_app/presentation/widgets/budget_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetListScreen extends StatelessWidget {
  const BudgetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        centerTitle: true,
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            final budgets = state.budgets;
            return budgets.isEmpty
                ? const Center(child: Text('No budgets available'))
                : ListView.builder(
                    itemCount: budgets.length,
                    itemBuilder: (context, index) {
                      final budget = budgets[index];
                      return BudgetCard(
                        key: UniqueKey(),
                        budget: budget,
                      );
                    },
                  );
          } else if (state is BudgetError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => BudgetBloc(BudgetRepositoryImpl()),
                child: BudgetModal(),
              );
            },
          ).then((value) {
            context.read<BudgetBloc>().add(FetchBudgets());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
