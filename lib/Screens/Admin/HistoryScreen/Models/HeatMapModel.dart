class HeatmapDay {
  final DateTime date;
  final int bookingCount;

  HeatmapDay({
    required this.date,
    required this.bookingCount,
  });

  factory HeatmapDay.fromJson(Map<String, dynamic> json) {
    return HeatmapDay(
      date: DateTime.parse(json['date']),
      bookingCount: json['bookingCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date.toIso8601String(),
      "bookingCount": bookingCount,
    };
  }
}

class HeatmapData {
  final int year;
  final int month;
  final String staffId;
  final dynamic staffInfo; // may be null 
  final int totalBookings;
  final Map<String, dynamic> statusBreakdown;
  final List<HeatmapDay> heatmapDays;
  final String monthName;
  final int daysInMonth;

  HeatmapData({
    required this.year,
    required this.month,
    required this.staffId,
    required this.staffInfo,
    required this.totalBookings,
    required this.statusBreakdown,
    required this.heatmapDays,
    required this.monthName,
    required this.daysInMonth,
  });

  factory HeatmapData.fromJson(Map<String, dynamic> json) {
    return HeatmapData(
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      staffId: json['staffId'] ?? "",
      staffInfo: json['staffInfo'],
      totalBookings: json['totalBookings'] ?? 0,
      statusBreakdown: json['statusBreakdown'] ?? {},
      heatmapDays: (json['heatmapData'] as List)
          .map((e) => HeatmapDay.fromJson(e))
          .toList(),
      monthName: json['monthName'] ?? "",
      daysInMonth: json['daysInMonth'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "month": month,
      "staffId": staffId,
      "staffInfo": staffInfo,
      "totalBookings": totalBookings,
      "statusBreakdown": statusBreakdown,
      "heatmapData": heatmapDays.map((e) => e.toJson()).toList(),
      "monthName": monthName,
      "daysInMonth": daysInMonth,
    };
  }
}
