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

  Future<bool> connectDevice({required String serialNumber}) async {
    try {
      String deviceSerialNumber = await DeviceServices().connectDevice(
        deviceSerialNumber: serialNumber,
      );
      _deviceSerialNumber = deviceSerialNumber;
      await getDeviceData();
      _errorMessage = '';
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<void> getSerialNumber() async {
    try {
      String? serialNumber = await DeviceServices().getSerialNumber();
      if (serialNumber != null) {
        _deviceSerialNumber = serialNumber;
        _errorMessage = '';
      } else {
        _errorMessage = 'Not connected the device';
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<bool> disconnect() async {
    try {
      if (await DeviceServices().disconnect()) {
        _errorMessage = '';
        return true;
      } else {
        _errorMessage = 'Disconnect the device failed';
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<void> getDeviceData() async {
    DatabaseReference deviceRef =
        DeviceServices.getDevice(deviceSerialNumber: _deviceSerialNumber);
    deviceRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        device = DeviceModel.fromJson(data, event.snapshot.key!);
        notifyListeners();
      }
    });
  }

  Future<void> updateSwing() async {
    DatabaseReference deviceRef =
        DeviceServices.getDevice(deviceSerialNumber: _deviceSerialNumber);
    if (device != null) {
      await deviceRef.update({"isSwing": device!.isSwing ? 0 : 1});
    }
  }
}
