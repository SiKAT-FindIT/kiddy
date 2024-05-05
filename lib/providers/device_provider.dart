import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  String _deviceSerialNumber = '';
  String _errorMessage = '';

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
}
