class ZoneModel {
  final String id;
  final String name;
  final String code;
  final bool isActive;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final ZoneCount count;

  ZoneModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.count,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      isActive: json['isActive'] ?? false,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      count: ZoneCount.fromJson(json['_count'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'isActive': isActive,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '_count': count.toJson(),
    };
  }

  // Convert to Map for UI display
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '_count': {
        'pincodes': count.pincodes,
        'staff': count.staff,
        'bookings': count.bookings,
      },
    };
  }
}

class ZoneCount {
  final int pincodes;
  final int staff;
  final int bookings;

  ZoneCount({
    required this.pincodes,
    required this.staff,
    required this.bookings,
  });

  factory ZoneCount.fromJson(Map<String, dynamic> json) {
    return ZoneCount(
      pincodes: json['pincodes'] ?? 0,
      staff: json['staff'] ?? 0,
      bookings: json['bookings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pincodes': pincodes,
      'staff': staff,
      'bookings': bookings,
    };
  }
}
