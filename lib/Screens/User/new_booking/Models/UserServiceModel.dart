class UserServiceModel {
  String? id;
  String? name;
  String? description;
  int? durationMinutes;
  String? basePrice;
  String? bathroomRate;
  String? roomRate;
  String? squareFootPrice;
  bool? isActive;

  UserServiceModel(
      {this.id,
      this.name,
      this.description,
      this.durationMinutes,
      this.basePrice,
      this.bathroomRate,
      this.roomRate,
      this.squareFootPrice,
      this.isActive});

  UserServiceModel.fromJson(Map<String, dynamic> json) {
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
