class PerformanceAnalystModel {
  int? avgBookingPerDay;
  int? avgStaffPerBooking;
  int? canceledBookings;

  PerformanceAnalystModel(
      {this.avgBookingPerDay, this.avgStaffPerBooking, this.canceledBookings});

  PerformanceAnalystModel.fromJson(Map<String, dynamic> json) {
    avgBookingPerDay = json['avgBookingPerDay'];
    avgStaffPerBooking = json['avgStaffPerBooking'];
    canceledBookings = json['canceledBookings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avgBookingPerDay'] = avgBookingPerDay;
    data['avgStaffPerBooking'] = avgStaffPerBooking;
    data['canceledBookings'] = canceledBookings;
    return data;
  }
}
