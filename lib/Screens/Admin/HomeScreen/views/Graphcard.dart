import 'package:cleanby_maria/Screens/Admin/HomeScreen/Services/homeController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});

  final HomeController hctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 211.h,
          child: hctrl.isChartLoader.value
              ? const Center(child: CircularProgressIndicator())
              : LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 20,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < hctrl.GraphData.length) {
                              return Text(
                                hctrl.GraphData[index].month!,
                                style: TextStyle(fontSize: 10.sp),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 12,
                    minY: 0,
                    maxY: 30,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (int i = 0; i < hctrl.GraphData.length; i++)
                            FlSpot(
                              i.toDouble(),
                              hctrl.GraphData[i].value!.toDouble(),
                            )
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        dotData: const FlDotData(show: false),
                        barWidth: 1,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
