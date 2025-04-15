class PerformanceOverTimeModel {
  String? month;
  int? value;

  PerformanceOverTimeModel({this.month, this.value});

  PerformanceOverTimeModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['value'] = value;
    return data;
  }
}
