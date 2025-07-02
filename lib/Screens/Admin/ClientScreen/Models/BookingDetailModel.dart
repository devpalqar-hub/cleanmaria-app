class BookingDetailModel {
  String? id;
  String? userId;
  String? type;
  int? areaSize;
  int? noOfRooms;
  int? noOfBathRooms;
  String? propertyType;
  bool? materialProvided;
  bool? isEco;
  String? status;
  String? price;
  String? createdAt;
  Customer? customer;
  BookingAddress? bookingAddress;
  Service? service;
  String? reccuingType;
  String? date;
  String? paymentMethod;
  List<MonthSchedules>? monthSchedules;
  List<Transactions>? transactions;

  BookingDetailModel(
      {this.id,
      this.userId,
      this.type,
      this.areaSize,
      this.noOfRooms,
      this.noOfBathRooms,
      this.propertyType,
      this.date,
      this.materialProvided,
      this.isEco,
      this.status,
      this.price,
      this.createdAt,
      this.reccuingType,
      this.customer,
      this.bookingAddress,
      this.service,
      this.monthSchedules,
      this.transactions,
      this.paymentMethod,
      });

  BookingDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    areaSize = json['areaSize'];
    noOfRooms = json['noOfRooms'];
    noOfBathRooms = json['noOfBathRooms'];
    propertyType = json['propertyType'];
    materialProvided = json['materialProvided'];
    paymentMethod=json['paymentMethod'];
    isEco = json['isEco'];
    status = json['status'];
    price = json['price'];
    date = json['date'];
    createdAt = json['createdAt'];
    reccuingType = (json['recurringType'] == null)
        ? ""
        : json['recurringType']["name"] ?? "";
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    bookingAddress = json['bookingAddress'] != null
        ? new BookingAddress.fromJson(json['bookingAddress'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['monthSchedules'] != null) {
      monthSchedules = <MonthSchedules>[];
      json['monthSchedules'].forEach((v) {
        monthSchedules!.add(new MonthSchedules.fromJson(v));
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
    data['areaSize'] = this.areaSize;
    data['noOfRooms'] = this.noOfRooms;
    data['noOfBathRooms'] = this.noOfBathRooms;
    data['propertyType'] = this.propertyType;
    data['materialProvided'] = this.materialProvided;
    data['isEco'] = this.isEco;
    data['status'] = this.status;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
     data['paymentMethod'] = paymentMethod;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.bookingAddress != null) {
      data['bookingAddress'] = this.bookingAddress!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.monthSchedules != null) {
      data['monthSchedules'] =
          this.monthSchedules!.map((v) => v.toJson()).toList();
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

class Transactions {
  String? status;
  String? paymentMethod;
  String? createdAt;
  String? transactionType;

  Transactions(
      {this.status, this.paymentMethod, this.createdAt, this.transactionType});

  Transactions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    createdAt = json['createdAt'];
    transactionType = json['transactionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    data['createdAt'] = this.createdAt;
    data['transactionType'] = this.transactionType;
    return data;
  }
}
