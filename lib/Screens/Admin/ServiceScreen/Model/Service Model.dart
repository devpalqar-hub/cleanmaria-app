class ServiceModel {
  final String name;
  final double durationMinutes;
  final String basePrice;
  final String bathroomRate;
  final String roomRate;
  final String squareFootPrice;

  ServiceModel({
    required this.name,
    required this.durationMinutes,
    required this.basePrice,
    required this.bathroomRate,
    required this.roomRate,
    required this.squareFootPrice,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      name: json['name'] ?? '',
      durationMinutes: double.parse(json['durationMinutes'].toString() ),
      basePrice: (json['base_price'])  ,
      bathroomRate: (json['bathroom_rate']),
      roomRate: (json['room_rate']),
      squareFootPrice:(json['square_foot_price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "durationMinutes": durationMinutes,
      "base_price": basePrice,
      "bathroom_rate": bathroomRate,
      "room_rate": roomRate,
      "square_foot_price": squareFootPrice,
    };
  }
}
