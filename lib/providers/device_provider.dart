import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kiddy/models/device_model.dart';
import 'package:kiddy/services/device_services.dart';

class DeviceProvider extends ChangeNotifier {
  String _deviceSerialNumber = '';
  String _errorMessage = '';
  DeviceModel? device;

  String get deviceSerialNumber => _deviceSerialNumber;
  String get errorMessage => _errorMessage;

  Future<void> connectDevice({required String serialNumber}) async {
    try {
      // String deviceSerialNumber = await DeviceServices().connectDevice(
      //   deviceSerialNumber: serialNumber,
      // );
      _deviceSerialNumber = deviceSerialNumber;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> getDeviceData() async {
    DatabaseReference deviceRef =
        DeviceServices.getDevice(deviceSerialNumber: "Kiddy12345678");
    deviceRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        device = DeviceModel.fromJson(data, event.snapshot.key!);
        notifyListeners();
      }
    });
  }
}
