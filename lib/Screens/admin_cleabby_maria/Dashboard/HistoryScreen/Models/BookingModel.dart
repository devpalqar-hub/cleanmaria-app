class Booking {
  final String status;
  final String customerName;
  final String time;
  final String location;

  Booking({
    required this.status,
    required this.customerName,
    required this.time,
    required this.location,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      status: json['status'] ?? '',
      customerName: json['customer']?['name'] ?? 'Unknown',
      time: DateTime.parse(json['createdAt']).toLocal().toString().substring(0, 16),
      location: json['bookingAddress']?['specialInstructions'] ?? 'No instructions',
    );
  }
}
