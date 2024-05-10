import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/src/app_exports.dart';
import 'package:weight_tracker/src/core/utils/get_months_color.dart';

import '../../../../config/themes/app_colors.dart';

class WeightChart extends StatelessWidget {
  final List<WeightModel?> weights;
  final int numMonths;

  const WeightChart(
      {super.key, required this.weights, required this.numMonths});

  @override
  Widget build(BuildContext context) {
    // Filter weights based on the last numMonths
    final now = DateTime.now();
    final filteredWeights = weights.where((weight) {
      final diffInMonths = now.difference(weight!.date!).inDays ~/ 30;
      return diffInMonths < numMonths;
    }).toList();

    Map<int, List<WeightModel?>> weightsByMonth = {};
    for (var weight in filteredWeights) {
      int monthIndex =
          numMonths - 1 - (now.difference(weight!.date!).inDays ~/ 30);
      weightsByMonth.putIfAbsent(monthIndex, () => []).add(weight);
    }

    List<double> averageWeights = [];
    for (int i = 0; i < numMonths; i++) {
      List<WeightModel?> monthWeights = weightsByMonth[i] ?? [];
      double totalWeight =
          monthWeights.fold(0, (prev, weight) => prev + weight!.weight!);
      double averageWeight =
          monthWeights.isNotEmpty ? totalWeight / monthWeights.length : 0;
      averageWeights.add(averageWeight);
    }

    // Create FlSpots for the chart
    List<FlSpot> spots = averageWeights
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();

    // Determine min and max weight for y-axis
    double minWeight = averageWeights.reduce((a, b) => a < b ? a : b);
    double maxWeight = averageWeights.reduce((a, b) => a > b ? a : b);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const ReusableText(text: 'Weight Chart'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ReusableText(
                    text: 'Average weight over the last $numMonths months'),
                AspectRatio(
                  aspectRatio: 1,
                  child: LineChart(
                    LineChartData(
                      borderData:
                          FlBorderData(show: true, border: AppBorders.all),
                      minX: 0,
                      maxX: numMonths.toDouble() - 1,
                      minY: minWeight,
                      maxY: maxWeight,
                      lineTouchData: const LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.blue,
                          dotData: const FlDotData(
                            show: true,
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          axisNameWidget: const ReusableText(
                            text: 'Months',
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              int monthIndex = value.toInt();
                              if (monthIndex >= 0 && monthIndex < numMonths) {
                                return ReusableText(
                                  text: monthIndex.toString(),
                                );
                                // Display month index (0, 1, 2, etc.)
                              }
                              return Container();
                            },
                            reservedSize: 20,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameWidget:
                              const ReusableText(text: 'Weight (kg)'),
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return ReusableText(
                                text: '${value.toInt()} kg',
                              );
                            },
                            reservedSize: 32,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return ReusableText(
                                text: getMonthLabel(value.toInt()),
                              );
                            },
                            reservedSize: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const ReusableText(text: ' weight changes per Days'),
                AspectRatio(
                  aspectRatio: 1,
                  child: MonthlyWeightChartPage(weightEntries: weights),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 10,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int i = 0; i < numMonths; i++)
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 15,
                            color: getMonthColor(i),
                            child: Center(
                              child: ReusableText(
                                text: getMonthLabel(i),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MonthlyWeightChartPage extends StatelessWidget {
  final List<WeightModel?> weightEntries;

  const MonthlyWeightChartPage({super.key, required this.weightEntries});

  @override
  Widget build(BuildContext context) {
    final Map<int, List<FlSpot>> monthlyData = {};

    for (var entry in weightEntries) {
      final month = entry!.date!.month;
      final day = entry.date!.day.toDouble();
      final weight = entry.weight;

      monthlyData.putIfAbsent(month, () => []).add(FlSpot(day, weight!));
    }

    final lineBarsData = monthlyData.entries.map((entry) {
      final monthIndex = entry.key;
      final spots = entry.value;
      final color = getMonthColor(monthIndex);

      return LineChartBarData(
        spots: spots,
        isCurved: true,
        barWidth: 2,
        color: color,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        showingIndicators: [spots.length - 1],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: true, border: AppBorders.all),
          minX: 1,
          maxX: 31, // Assuming maximum 31 days in a month
          minY: 0,

          maxY: weightEntries
              .map((e) => e!.weight)
              .reduce((a, b) => a! > b! ? a : b), // Find max weight
          lineBarsData: lineBarsData,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: const ReusableText(text: 'Day'),
              axisNameSize: 19,
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 23,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
            leftTitles: AxisTitles(
              axisNameWidget: const ReusableText(text: 'Weight (kg)'),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  return ReusableText(
                    text: '${value.toInt()} kg',
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(
            show: true,
          ),
        ),
      ),
    );
  }
}
