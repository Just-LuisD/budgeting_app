import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RandomPiechart extends StatelessWidget {
  const RandomPiechart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(centerSpaceRadius: 0, sections: [
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
  }
}
