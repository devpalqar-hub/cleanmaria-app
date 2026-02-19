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
  String? date;
  String? paymentMethod;
  String? reccuingType;

  Customer? customer;
  BookingAddress? bookingAddress;
  Service? service;

  List<MonthSchedules>? monthSchedules;
  List<Transactions>? transactions;

  /// NEW FIELD
  NextSchedule? nextSchedule;

  BookingDetailModel({
    this.id,
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
    this.nextSchedule,
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
    paymentMethod = json['paymentMethod'];
    isEco = json['isEco'];
    status = json['status'];
    price = json['price'];
    date = json['date'];
    createdAt = json['createdAt'];

    reccuingType = (json['recurringType'] == null)
        ? "One Time"
        : json['recurringType']["name"] ?? "";

    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;

    bookingAddress = json['bookingAddress'] != null
        ? BookingAddress.fromJson(json['bookingAddress'])
        : null;

    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;

    /// MONTH SCHEDULES
    if (json['monthSchedules'] != null) {
      monthSchedules = <MonthSchedules>[];
      json['monthSchedules'].forEach((v) {
        monthSchedules!.add(MonthSchedules.fromJson(v));
      });
    }

    /// TRANSACTIONS
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }

    /// NEXT SCHEDULE (NEW)
    nextSchedule = json['nextSchedule'] != null
        ? NextSchedule.fromJson(json['nextSchedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['userId'] = userId;
    data['type'] = type;
    data['areaSize'] = areaSize;
    data['noOfRooms'] = noOfRooms;
    data['noOfBathRooms'] = noOfBathRooms;
    data['propertyType'] = propertyType;
    data['materialProvided'] = materialProvided;
    data['isEco'] = isEco;
    data['status'] = status;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['date'] = date;
    data['paymentMethod'] = paymentMethod;

    if (customer != null) {
      data['customer'] = customer!.toJson();
    }

    if (bookingAddress != null) {
      data['bookingAddress'] = bookingAddress!.toJson();
    }

    if (service != null) {
      data['service'] = service!.toJson();
    }

    if (monthSchedules != null) {
      data['monthSchedules'] = monthSchedules!.map((v) => v.toJson()).toList();
    }

    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }

    if (nextSchedule != null) {
      data['nextSchedule'] = nextSchedule!.toJson();
    }

    return data;
  }
}

////////////////////////////////////////////////////////////
/// NEXT SCHEDULE MODEL
////////////////////////////////////////////////////////////

class NextSchedule {
  String? id;
  String? startTime;
  String? endTime;
  String? status;
  StaffMini? staff;

  NextSchedule({
    this.id,
    this.startTime,
    this.endTime,
    this.status,
    this.staff,
  });

  NextSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    staff = json['staff'] != null ? StaffMini.fromJson(json['staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['status'] = status;

    if (staff != null) {
      data['staff'] = staff!.toJson();
    }

    return data;
  }

  /// Helper getters
  DateTime? get startDate =>
      startTime != null ? DateTime.tryParse(startTime!) : null;

  DateTime? get endDate => endTime != null ? DateTime.tryParse(endTime!) : null;

  Duration get duration => (startDate != null && endDate != null)
      ? endDate!.difference(startDate!)
      : Duration.zero;
}

////////////////////////////////////////////////////////////
/// STAFF MINI MODEL
////////////////////////////////////////////////////////////

class StaffMini {
  String? id;
  String? name;
  String? email;

  StaffMini({
    this.id,
    this.name,
    this.email,
  });

  StaffMini.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}

////////////////////////////////////////////////////////////
/// CUSTOMER MODEL
////////////////////////////////////////////////////////////

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
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}

////////////////////////////////////////////////////////////
/// BOOKING ADDRESS MODEL
////////////////////////////////////////////////////////////

class BookingAddress {
  String? specialInstructions;
  Address? address;

  BookingAddress({this.specialInstructions, this.address});

  BookingAddress.fromJson(Map<String, dynamic> json) {
    specialInstructions = json['specialInstructions'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "specialInstructions": specialInstructions,
      "address": address?.toJson(),
    };
  }
}

////////////////////////////////////////////////////////////
/// ADDRESS MODEL
////////////////////////////////////////////////////////////

class Address {
  String? landmark;
  String? line1;
  String? line2;
  String? street;
  String? city;
  String? state;
  String? zip;

  Address({
    this.landmark,
    this.line1,
    this.line2,
    this.street,
    this.city,
    this.state,
    this.zip,
  });

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
    return {
      "landmark": landmark,
      "line_1": line1,
      "line_2": line2,
      "street": street,
      "city": city,
      "state": state,
      "zip": zip,
    };
  }
}

////////////////////////////////////////////////////////////
/// SERVICE MODEL
////////////////////////////////////////////////////////////

class Service {
  String? id;
  String? name;
  int? duration;

  Service({this.id, this.name, this.duration});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    duration = json['durationMinutes'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "durationMinutes": duration,
    };
  }
}

////////////////////////////////////////////////////////////
/// MONTH SCHEDULE MODEL
////////////////////////////////////////////////////////////

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
    return {
      "weekOfMonth": weekOfMonth,
      "dayOfWeek": dayOfWeek,
      "time": time,
    };
  }
}

////////////////////////////////////////////////////////////
/// TRANSACTIONS MODEL
////////////////////////////////////////////////////////////

class Transactions {
  String? status;
  String? paymentMethod;
  String? createdAt;
  String? transactionType;

  Transactions({
    this.status,
    this.paymentMethod,
    this.createdAt,
    this.transactionType,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    createdAt = json['createdAt'];
    transactionType = json['transactionType'];
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "paymentMethod": paymentMethod,
      "createdAt": createdAt,
      "transactionType": transactionType,
    };
  }
}
