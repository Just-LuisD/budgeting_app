import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final curencyFormatter = NumberFormat.simpleCurrency();

class ProgressBar extends StatelessWidget {
  final String label;
  final int minVal;
  final int maxVal;
  final int value;
  final double height;
  final Color color;
  final Color? backgroundColor;

  const ProgressBar({
    super.key,
    required this.label,
    required this.minVal,
    required this.maxVal,
    required this.value,
    required this.height,
    required this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double barWidth = MediaQuery.sizeOf(context).width - 50;
    double percantage = (value - minVal) / (maxVal - minVal);
    if (percantage > 0 && percantage < 0.03) {
      percantage = 0.03;
    }
    return SizedBox(
      width: barWidth,
      child: Column(
        children: [
          Text("$label: ${curencyFormatter.format(value / 100)}"),
          Container(
            alignment: Alignment.center,
            width: barWidth,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(height),
                left: Radius.circular(height),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: percantage * barWidth,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(height),
                      right: Radius.circular(
                          percantage * barWidth == barWidth ? height : 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: barWidth,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    curencyFormatter.format(minVal / 100),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    curencyFormatter.format(maxVal / 100),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
