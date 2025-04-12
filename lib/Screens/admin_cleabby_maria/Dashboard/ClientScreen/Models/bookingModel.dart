class Booking {
  final String name;
  final String plan;
  final String time;
  final String place;
  final String price;

  // Constructor
  Booking({
    required this.name,
    required this.plan,
    required this.time,
    required this.place,
    required this.price,
  });

  // Factory method to create a Booking from a JSON object
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      name: json['name'],
      plan: json['plan'],
      time: json['time'],
      place: json['place'],
      price: json['price'],
    );
  }
}
