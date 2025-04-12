class BookingModel {
  String? id;
  String? userId;
  String? type;
  String? serviceId;
  String? subscriptionTypeId;
  int? areaSize;
  String? propertyType;
  bool? materialProvided;
  bool? isEco;
  String? status;
  String? price;
  Customer? customer;
  Service? service;
  List<MonthSchedules>? monthSchedules;
  BookingAddress? bookingAddress;
  SubscriptionType? subscriptionType;

  BookingModel(
      {this.id,
      this.userId,
      this.type,
      this.serviceId,
      this.subscriptionTypeId,
      this.areaSize,
      this.propertyType,
      this.materialProvided,
      this.isEco,
      this.status,
      this.price,
      this.customer,
      this.service,
      this.monthSchedules,
      this.bookingAddress,
      this.subscriptionType});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    serviceId = json['serviceId'];
    subscriptionTypeId = json['subscriptionTypeId'];
    areaSize = json['areaSize'];
    propertyType = json['propertyType'];
    materialProvided = json['materialProvided'];
    isEco = json['isEco'];
    status = json['status'];
    price = json['price'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
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
    data['serviceId'] = this.serviceId;
    data['subscriptionTypeId'] = this.subscriptionTypeId;
    data['areaSize'] = this.areaSize;
    data['propertyType'] = this.propertyType;
    data['materialProvided'] = this.materialProvided;
    data['isEco'] = this.isEco;
    data['status'] = this.status;
    data['price'] = this.price;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
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
  String? description;
  int? durationMinutes;
  String? basePrice;
  String? bathroomRate;
  String? roomRate;
  String? squareFootPrice;
  bool? isActive;

  Service(
      {this.id,
      this.name,
      this.description,
      this.durationMinutes,
      this.basePrice,
      this.bathroomRate,
      this.roomRate,
      this.squareFootPrice,
      this.isActive});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    durationMinutes = json['durationMinutes'];
    basePrice = json['base_price'];
    bathroomRate = json['bathroom_rate'];
    roomRate = json['room_rate'];
    squareFootPrice = json['square_foot_price'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['durationMinutes'] = this.durationMinutes;
    data['base_price'] = this.basePrice;
    data['bathroom_rate'] = this.bathroomRate;
    data['room_rate'] = this.roomRate;
    data['square_foot_price'] = this.squareFootPrice;
    data['isActive'] = this.isActive;
    return data;
  }
}

class MonthSchedules {
  String? id;
  String? bookingId;
  int? weekOfMonth;
  int? dayOfWeek;
  String? time;
  String? createdAt;
  String? updatedAt;

  MonthSchedules(
      {this.id,
      this.bookingId,
      this.weekOfMonth,
      this.dayOfWeek,
      this.time,
      this.createdAt,
      this.updatedAt});

  MonthSchedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    weekOfMonth = json['weekOfMonth'];
    dayOfWeek = json['dayOfWeek'];
    time = json['time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = this.bookingId;
    data['weekOfMonth'] = this.weekOfMonth;
    data['dayOfWeek'] = this.dayOfWeek;
    data['time'] = this.time;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class BookingAddress {
  String? id;
  String? bookingId;
  String? addressId;
  String? specialInstructions;
  String? createdAt;

  BookingAddress(
      {this.id,
      this.bookingId,
      this.addressId,
      this.specialInstructions,
      this.createdAt});

  BookingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    addressId = json['addressId'];
    specialInstructions = json['specialInstructions'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = this.bookingId;
    data['addressId'] = this.addressId;
    data['specialInstructions'] = this.specialInstructions;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class SubscriptionType {
  String? id;
  String? name;
  String? description;
  int? recurringFrequency;
  String? availableDiscount;

  SubscriptionType(
      {this.id,
      this.name,
      this.description,
      this.recurringFrequency,
      this.availableDiscount});

  SubscriptionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    recurringFrequency = json['recurringFrequency'];
    availableDiscount = json['available_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['recurringFrequency'] = this.recurringFrequency;
    data['available_discount'] = this.availableDiscount;
    return data;
  }
}
