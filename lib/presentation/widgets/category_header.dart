import 'package:flutter/material.dart';

class CateggoryHeader extends StatelessWidget {
  const CateggoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          // TODO fix this to refererence a state
          icon: Icon(true ? Icons.arrow_drop_down : Icons.arrow_right_outlined),
        ),
        const Expanded(
          child: Text("Categories"),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Add Category"),
                  ),
                  body: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: null,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Your transaction must have a title.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: null,
                            decoration: InputDecoration(
                              labelText: "Limit",
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null ||
                                  double.tryParse(value)! <= 0) {
                                return 'Your transaction amount must be a positive value.';
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Add"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
