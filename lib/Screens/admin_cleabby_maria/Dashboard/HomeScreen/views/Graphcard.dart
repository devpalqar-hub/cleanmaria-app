import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineChartWidget extends StatelessWidget {
   LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 211.h,
      width: 298.w, // Providing a fixed height
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show:false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 50),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text("Jan");
                    case 1:
                      return  Text("Feb");
                    case 2:
                      return Text("Mar");
                    case 3:
                      return  Text("Apr");
                    case 4:
                      return  Text("May");
                    case 5:
                      return Text("Jun");
                    default:
                      return const Text("");
                  }
                },
                reservedSize: 30,
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.blue, width: 1),
          ),
          minX: 0,
          maxX: 5,
          minY: 25,
          maxY: 29,
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 26),
                const FlSpot(0.5, 26.5),
                const FlSpot(1, 26.5),
                const FlSpot(1.5, 26.8),
                const FlSpot(2, 27.2),
                const FlSpot(2.5, 27.3),
                const FlSpot(3, 27.9),
                const FlSpot(3.5, 27.5),
                const FlSpot(4, 28),
                const FlSpot(4.5, 27.7),
                const FlSpot(5, 28.5),
              ],
              isCurved: true,
              color: Colors.blue,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }
}
