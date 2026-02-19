class UserProfileModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? status;
  String? roleId;
  Role? role;
  List<Addresses>? addresses;
  String? createdAt;
  String? updatedAt;

  UserProfileModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.status,
      this.roleId,
      this.role,
      this.addresses,
      this.createdAt,
      this.updatedAt});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    roleId = json['roleId'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['roleId'] = this.roleId;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Role {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.name, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Addresses {
  String? id;
  String? userId;
  String? landmark;
  String? line1;
  String? line2;
  String? street;
  String? city;
  String? state;
  String? zip;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
      this.userId,
      this.landmark,
      this.line1,
      this.line2,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    landmark = json['landmark'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['landmark'] = this.landmark;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
