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
}
