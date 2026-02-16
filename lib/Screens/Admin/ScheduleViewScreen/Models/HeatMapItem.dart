class HeatMapItem {
  String? date;
  int? bookingCount;

  HeatMapItem({this.date, this.bookingCount});

  HeatMapItem.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    bookingCount = json['bookingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['bookingCount'] = this.bookingCount;
    return data;
  }
}
