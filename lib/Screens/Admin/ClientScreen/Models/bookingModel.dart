class BookingModel {
  String? id;
  String? userId;
  String? type;
  int? areaSize;
  String? propertyType;
  bool? materialProvided;
  bool? isEco;
  String? status;
  String? createdAt;
  String? price;
  Customer? customer;
  List<MonthSchedules>? monthSchedules;
  BookingAddress? bookingAddress;
  SubscriptionType? subscriptionType;

  BookingModel(
      {this.id,
      this.userId,
      this.type,
      this.areaSize,
      this.propertyType,
      this.materialProvided,
      this.isEco,
      this.status,
      this.createdAt,
      this.price,
      this.customer,
      this.monthSchedules,
      this.bookingAddress,
      this.subscriptionType});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    areaSize = json['areaSize'];
    propertyType = json['propertyType'];
    materialProvided = json['materialProvided'];
    isEco = json['isEco'];
    status = json['status'];
    createdAt = json['createdAt'];
    price = json['price'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['monthSchedules'] != null) {
      monthSchedules = <MonthSchedules>[];
      json['monthSchedules'].forEach((v) {
        monthSchedules!.add(new MonthSchedules.fromJson(v));
      });
    }
    bookingAddress = json['bookingAddress'] != null
        ? new BookingAddress.fromJson(json['bookingAddress'])
        : null;
    subscriptionType = json['subscriptionType'] != null
        ? new SubscriptionType.fromJson(json['subscriptionType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['areaSize'] = this.areaSize;
    data['propertyType'] = this.propertyType;
    data['materialProvided'] = this.materialProvided;
    data['isEco'] = this.isEco;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['price'] = this.price;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.monthSchedules != null) {
      data['monthSchedules'] =
          this.monthSchedules!.map((v) => v.toJson()).toList();
    }
    if (this.bookingAddress != null) {
      data['bookingAddress'] = this.bookingAddress!.toJson();
    }
    if (this.subscriptionType != null) {
      data['subscriptionType'] = this.subscriptionType!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? email;
  String? phone;

  Customer({this.name, this.email, this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class MonthSchedules {
  int? weekOfMonth;
  int? dayOfWeek;
  String? time;

  MonthSchedules({this.weekOfMonth, this.dayOfWeek, this.time});

  MonthSchedules.fromJson(Map<String, dynamic> json) {
    weekOfMonth = json['weekOfMonth'];
    dayOfWeek = json['dayOfWeek'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekOfMonth'] = this.weekOfMonth;
    data['dayOfWeek'] = this.dayOfWeek;
    data['time'] = this.time;
    return data;
  }
}

class BookingAddress {
  String? specialInstructions;
  Address? address;

  BookingAddress({this.specialInstructions, this.address});

  BookingAddress.fromJson(Map<String, dynamic> json) {
    specialInstructions = json['specialInstructions'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialInstructions'] = this.specialInstructions;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? landmark;
  String? line1;
  String? line2;
  String? street;
  String? city;
  String? state;
  String? zip;

  Address(
      {this.landmark,
      this.line1,
      this.line2,
      this.street,
      this.city,
      this.state,
      this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    landmark = json['landmark'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['landmark'] = this.landmark;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    return data;
  }
}

class SubscriptionType {
  String? name;

  SubscriptionType({this.name});

  SubscriptionType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
