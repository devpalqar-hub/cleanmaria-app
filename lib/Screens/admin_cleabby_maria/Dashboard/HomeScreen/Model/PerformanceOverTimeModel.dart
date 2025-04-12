class PerformanceOverTimeModel {
  String? month;
  int? value;

  PerformanceOverTimeModel({this.month, this.value});

  PerformanceOverTimeModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['value'] = this.value;
    return data;
  }
}
