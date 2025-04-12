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

  /// From JSON to Staff object
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      status: json['status'] as String,
    );
  }

  /// Convert Staff object to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
    };
  }

  /// CopyWith method for immutability and field updates
  Staff copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? status,
  }) {
    return Staff(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
