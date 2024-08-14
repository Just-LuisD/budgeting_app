import 'package:flutter/material.dart';

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
    final percantage = (value - minVal) / (maxVal - minVal);
    return SizedBox(
      width: barWidth,
      child: Column(
        children: [
          Text("$label: \$${value}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height,
                width: percantage * barWidth,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(height)),
                ),
              ),
              Container(
                height: height,
                width: (1 - percantage) * barWidth,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(height),
                    left: Radius.circular(value > 0 ? 0 : height),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: barWidth,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    minVal.toString(),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    maxVal.toString(),
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
