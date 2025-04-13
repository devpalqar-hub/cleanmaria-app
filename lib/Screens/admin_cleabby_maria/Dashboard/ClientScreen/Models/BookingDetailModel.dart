class BookingDetail {
  bool? status;
  String? message;
  Data? data;

  BookingDetail({this.status, this.message, this.data});

  BookingDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Service? service;
  BookingAddress? bookingAddress;
  List<BookingLogs>? bookingLogs;
  List<Transactions>? transactions;

  Data(
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
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.service,
      this.bookingAddress,
      this.bookingLogs,
      this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    bookingAddress = json['bookingAddress'] != null
        ? new BookingAddress.fromJson(json['bookingAddress'])
        : null;
    if (json['bookingLogs'] != null) {
      bookingLogs = <BookingLogs>[];
      json['bookingLogs'].forEach((v) {
        bookingLogs!.add(new BookingLogs.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.bookingAddress != null) {
      data['bookingAddress'] = this.bookingAddress!.toJson();
    }
    if (this.bookingLogs != null) {
      data['bookingLogs'] = this.bookingLogs!.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
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
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
      this.name,
      this.description,
      this.durationMinutes,
      this.basePrice,
      this.bathroomRate,
      this.roomRate,
      this.squareFootPrice,
      this.isActive,
      this.createdAt,
      this.updatedAt});

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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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

class BookingLogs {
  String? id;
  String? bookingId;
  String? status;
  String? changedAt;
  String? changedBy;
  User? user;

  BookingLogs(
      {this.id,
      this.bookingId,
      this.status,
      this.changedAt,
      this.changedBy,
      this.user});

  BookingLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    status = json['status'];
    changedAt = json['changedAt'];
    changedBy = json['changedBy'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = this.bookingId;
    data['status'] = this.status;
    data['changedAt'] = this.changedAt;
    data['changedBy'] = this.changedBy;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
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

class Transactions {
  String? id;
  String? bookingId;
  String? amount;
  String? currency;
  String? status;
  String? paymentMethod;
  String? transactionType;
  String? createdAt;
  String? updatedAt;

  Transactions(
      {this.id,
      this.bookingId,
      this.amount,
      this.currency,
      this.status,
      this.paymentMethod,
      this.transactionType,
      this.createdAt,
      this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    transactionType = json['transactionType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = this.bookingId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    data['transactionType'] = this.transactionType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}