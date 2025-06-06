class ServiceModel {
  final String id;
  final String name;
  final double durationMinutes;
  final String basePrice;
  final String bathroomRate;
  final String roomRate;
  final String squareFootPrice;

  ServiceModel({
    required this.id,
    required this.name,
    required this.durationMinutes,
    required this.basePrice,
    required this.bathroomRate,
    required this.roomRate,
    required this.squareFootPrice,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'] ?? '',
      durationMinutes: double.parse(json['durationMinutes'].toString() ),
       basePrice: json['base_price'] ?? '0',
      bathroomRate: json['bathroom_rate'] ?? '0',
      roomRate: json['room_rate'] ?? '0',
      squareFootPrice: json['square_foot_price'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "name": name,
      "durationMinutes": durationMinutes,
      "base_price": basePrice,
      "bathroom_rate": bathroomRate,
      "room_rate": roomRate,
      "square_foot_price": squareFootPrice,
    };
  }
}
