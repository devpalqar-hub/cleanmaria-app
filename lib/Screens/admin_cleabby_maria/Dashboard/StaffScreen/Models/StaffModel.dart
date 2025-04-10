class Staff {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String status;

  Staff({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.status,
  });

  // From JSON to Staff object
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
    );
  }
  
}
