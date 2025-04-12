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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avgBookingPerDay'] = this.avgBookingPerDay;
    data['avgStaffPerBooking'] = this.avgStaffPerBooking;
    data['canceledBookings'] = this.canceledBookings;
    return data;
  }
}
