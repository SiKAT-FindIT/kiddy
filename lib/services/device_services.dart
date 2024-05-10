import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceServices {
  static DatabaseReference getDevice({required String deviceSerialNumber}) {
    return FirebaseDatabase.instance.ref('devices').child(deviceSerialNumber);
  }

  Future<String> connectDevice({required String deviceSerialNumber}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      if (await pref.setString('device_serial_number', deviceSerialNumber)) {
        return deviceSerialNumber;
      }
      throw 'Failed to connect device';
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getSerialNumber() async {
    try {
      final pref = await SharedPreferences.getInstance();

      return pref.getString('device_serial_number');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> disconnect() async {
    try {
      final pref = await SharedPreferences.getInstance();

      return await pref.remove('device_serial_number');
    } catch (e) {
      rethrow;
    }
  }
}
