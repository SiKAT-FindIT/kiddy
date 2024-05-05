import 'package:equatable/equatable.dart';

class DeviceModel extends Equatable {
  final String serialNumber;
  final bool isSwing;
  final double latitude;
  final double longitude;
  final double altitude;
  final double speed;

  const DeviceModel({
    required this.serialNumber,
    required this.isSwing,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.speed,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json, String serialNumber) {
    return DeviceModel(
      serialNumber: serialNumber,
      isSwing: json['isSwing'] == 1 ? true : false,
      altitude: json['altitude'].toDouble(),
      speed: json['speed'].toDouble(),
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  @override
  List<Object?> get props =>
      [serialNumber, isSwing, latitude, longitude, altitude, speed];
}
