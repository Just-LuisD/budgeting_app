import 'package:flutter/material.dart';
import "package:fl_chart/fl_chart.dart";

enum BudgetTemplateType {
  fiftyThirtyTwenty,
  eightyTwenty,
  custom,
}

class BudgetCard extends StatelessWidget {
  final BudgetTemplateType type;
  const BudgetCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    String title;
    PieChart icon;
    switch (type) {
      case BudgetTemplateType.fiftyThirtyTwenty:
        title = "50/30/20 Template";
        icon = PieChart(PieChartData(
          centerSpaceRadius: 0,
          sections: [
            PieChartSectionData(
              radius: 35,
              value: 50,
              showTitle: false,
              color: const Color.fromARGB(255, 255, 119, 119),
            ),
            PieChartSectionData(
              radius: 35,
              value: 30,
              showTitle: false,
              color: Color.fromARGB(255, 119, 241, 255),
            ),
            PieChartSectionData(
              radius: 35,
              value: 20,
              showTitle: false,
              color: Color.fromARGB(255, 142, 255, 119),
            ),
          ],
        ));
        break;
      case BudgetTemplateType.eightyTwenty:
        title = "80/20 Template";
        icon = PieChart(PieChartData(
          centerSpaceRadius: 0,
          sections: [
            PieChartSectionData(
              value: 80,
              radius: 35,
              showTitle: false,
              color: Color.fromARGB(255, 255, 119, 119),
            ),
            PieChartSectionData(
              value: 20,
              radius: 35,
              showTitle: false,
              color: Color.fromARGB(255, 142, 255, 119),
            ),
          ],
        ));
        break;
      case BudgetTemplateType.custom:
        title = "Custom";
        icon = PieChart(PieChartData(centerSpaceRadius: 0, sections: [
          PieChartSectionData(
            radius: 35,
            color: Color.fromARGB(255, 203, 255, 119),
            value: 50,
            showTitle: false,
          ),
          PieChartSectionData(
            radius: 35,
            color: Color.fromARGB(255, 119, 255, 223),
            value: 30,
            showTitle: false,
          ),
          PieChartSectionData(
            radius: 35,
            color: Color.fromARGB(255, 255, 119, 207),
            value: 20,
            showTitle: false,
          ),
          PieChartSectionData(
            radius: 35,
            color: Color.fromARGB(255, 255, 210, 119),
            value: 20,
            showTitle: false,
          ),
          PieChartSectionData(
            radius: 35,
            color: Color.fromARGB(255, 128, 119, 255),
            value: 25,
            showTitle: false,
          ),
          PieChartSectionData(
            radius: 35,
            color: Color.fromARGB(255, 255, 119, 119),
            value: 70,
            showTitle: false,
          ),
        ]));
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        surfaceTintColor: Color.fromARGB(110, 255, 254, 254),
        elevation: 8,
        color: Color.fromARGB(255, 210, 185, 224),
        child: Container(
          width: 300,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(title),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(right: 16),
                constraints: BoxConstraints.tight(Size(100, 100)),
                child: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
