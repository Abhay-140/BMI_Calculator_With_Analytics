import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/bmi_record.dart';

class BmiChart extends StatelessWidget {
  final List<BmiRecord> records;

  const BmiChart({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.length < 2) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Not enough data for chart."),
      );
    }

    final reversedRecords = records.reversed.toList();
    final spots = reversedRecords
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.bmi))
        .toList();

    // Calculate dynamic maxY
    final double maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final double adjustedMaxY = (maxY + 5).ceilToDouble(); // Some padding

    return SizedBox(
      height: 280,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: adjustedMaxY,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.black87,
                  getTooltipItems: (spots) {
                    return spots.map((spot) {
                      return LineTooltipItem(
                        'BMI: ${spot.y.toStringAsFixed(1)}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // hide index labels
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 5,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                ),
                getDrawingVerticalLine: (_) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    ],
                  ),
                  spots: spots,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 700),
          ),
        ),
      ),
    );
  }
}
