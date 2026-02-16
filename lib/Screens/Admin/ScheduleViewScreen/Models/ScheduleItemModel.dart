class ScheduleItemModel {
  String? id;
  String? staffId;
  String? serviceId;
  String? bookingId;
  String? startTime;
  String? endTime;
  String? status;
  bool? isSkipped;
  String? createdAt;
  String? updatedAt;
  Staff? staff;
  Booking? booking;

  ScheduleItemModel(
      {this.id,
      this.staffId,
      this.serviceId,
      this.bookingId,
      this.startTime,
      this.endTime,
      this.status,
      this.isSkipped,
      this.createdAt,
      this.updatedAt,
      this.staff,
      this.booking});

  ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staffId'];
    serviceId = json['serviceId'];
    bookingId = json['bookingId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    isSkipped = json['isSkipped'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['isSkipped'] = this.isSkipped;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

  Staff({this.id, this.name, this.email});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Booking {
  String? id;
  String? status;
  String? paymentMethod;
  Customer? customer;
  Service? service;

  Booking(
      {this.id, this.status, this.paymentMethod, this.customer, this.service});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? name;
  String? email;
  String? phone;

  Customer({this.id, this.name, this.email, this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
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
