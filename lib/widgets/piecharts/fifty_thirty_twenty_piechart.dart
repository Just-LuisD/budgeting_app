import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FiftyThrityTwentyPiechart extends StatelessWidget {
  const FiftyThrityTwentyPiechart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(centerSpaceRadius: 0, sections: [
      PieChartSectionData(
        radius: 35,
        color: Color.fromARGB(255, 203, 255, 119),
        value: 20,
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
        color: Color.fromARGB(255, 255, 119, 119),
        value: 50,
        showTitle: false,
      ),
    ]));
  }
}
