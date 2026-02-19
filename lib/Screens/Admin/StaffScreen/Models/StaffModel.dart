class Staff {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final int priority;
  final String assignedZone;

  Staff(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.status,
      required this.priority,
      this.assignedZone = ""});

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone']?.toString() ?? '',
      status: json['status'] ?? '',
      assignedZone:
          json["staffZone"] == null ? "" : json["staffZone"]["zone"]["name"],
      priority: (json['priority'] is int)
          ? json['priority']
          : int.tryParse(json['priority']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'priority': priority,
    };
  }

  Staff copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? status,
    int? priority,
  }) {
    return Staff(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      priority: priority ?? this.priority,
    );
  }
}
