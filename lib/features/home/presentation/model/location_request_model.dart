class LocationRequestModel {
  final String id;
  final int carId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String status; // 'pending', 'completed', 'failed'

  LocationRequestModel({
    required this.id,
    required this.carId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  factory LocationRequestModel.fromJson(Map<String, dynamic> json) {
    return LocationRequestModel(
      id: json['id'],
      carId: json['car_id'],
      timestamp: DateTime.parse(json['timestamp']),
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car_id': carId,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  LocationRequestModel copyWith({
    String? id,
    int? carId,
    DateTime? timestamp,
    double? latitude,
    double? longitude,
    String? status,
  }) {
    return LocationRequestModel(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
    );
  }
} 