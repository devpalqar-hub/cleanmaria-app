class Staff {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;

  Staff({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
  });

  // Factory constructor to create a Staff object from JSON
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status']?.toString() ?? 'inactive',
    );
  }

  // Method to convert a Staff object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
    };
  }
}
