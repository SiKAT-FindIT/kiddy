import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceServices {
  // Get Database Reference From Firebase
  static DatabaseReference getDevice({required String deviceSerialNumber}) {
    return FirebaseDatabase.instance.ref('devices').child(deviceSerialNumber);
  }

  // To Connect Device through Serial Number
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

  // To Get Device Serial Number from Saved Data in Shared Preferences
  Future<String?> getSerialNumber() async {
    try {
      final pref = await SharedPreferences.getInstance();

      return pref.getString('device_serial_number');
    } catch (e) {
      rethrow;
    }
  }

  // To Disconnect Device by Removing Saved Data in Shared Preferences
  Future<bool> disconnect() async {
    try {
      final pref = await SharedPreferences.getInstance();

      return await pref.remove('device_serial_number');
    } catch (e) {
      rethrow;
    }
  }
}
