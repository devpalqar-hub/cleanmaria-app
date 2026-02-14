class UsertimeSlotModel {
  String? time;
  bool? isAvailable;

  UsertimeSlotModel({this.time, this.isAvailable});

  UsertimeSlotModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
