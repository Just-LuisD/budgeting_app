import 'package:flutter/material.dart';
import "package:fl_chart/fl_chart.dart";

class EightyTwentyPiechart extends StatelessWidget {
  const EightyTwentyPiechart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(
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
  }
}
