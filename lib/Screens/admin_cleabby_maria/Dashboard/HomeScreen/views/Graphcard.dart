import 'dart:convert';
import 'package:cleanby_maria/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LineChartWidget extends StatefulWidget {
  final String startDate;
  final String endDate;

  const LineChartWidget({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<FlSpot> chartSpots = [];
  bool isLoading = true;

  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }
  

Future<Map<String, String>> getAuthHeader() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}


  Future<void> fetchChartData() async {
  final url = Uri.parse(
    '$baseUrl/analytics/bookings-over-time?startDate=${widget.startDate}&endDate=${widget.endDate}',
  );

  try {
    final headers = await getAuthHeader();
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];

      setState(() {
        chartSpots = data.asMap().entries.map((entry) {
          int index = months.indexOf(entry.value['month']);
          double value = double.tryParse(entry.value['value'].toString()) ?? 0.0;
          return FlSpot(index.toDouble(), value);
        }).toList();
        isLoading = false;
      });

    } else {
      print("API error: ${response.statusCode} ${response.body}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Exception: $e");
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 211.h,
      width: 298.w,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < months.length) {
                          return Text(months[index]);
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: chartSpots.isEmpty
                    ? 10
                    : chartSpots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 1,
                lineBarsData: [
                  LineChartBarData(
                    spots: chartSpots,
                    isCurved: true,
                    color: Colors.blue,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
