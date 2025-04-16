class HistoryModel {
  String? id;
  String? staffId;
  String? serviceId;
  String? bookingId;
  String? startTime;
  String? endTime;
  String? status;
  String? createdAt;
  Staff? staff;
  Booking? booking;

  HistoryModel(
      {this.id,
      this.staffId,
      this.serviceId,
      this.bookingId,
      this.startTime,
      this.endTime,
      this.status,
      this.createdAt,
      this.staff,
      this.booking});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staffId'];
    serviceId = json['serviceId'];
    bookingId = json['bookingId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    createdAt = json['createdAt'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staffId'] = this.staffId;
    data['serviceId'] = this.serviceId;
    data['bookingId'] = this.bookingId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Staff {
  String? id;
  String? name;
  String? email;
  String? phone;

  Staff({this.id, this.name, this.email});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data["phone"] = this.phone;
    return data;
  }
}

class Booking {
  String? id;
  String? status;
  Staff? customer;
  Service? service;

  Booking({this.id, this.status, this.customer, this.service});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    customer =
        json['customer'] != null ? new Staff.fromJson(json['customer']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  String? id;
  String? name;

  Service({this.id, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
