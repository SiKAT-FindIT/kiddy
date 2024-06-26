import 'package:flutter/material.dart';
import 'package:kiddy/providers/device_provider.dart';
import 'package:kiddy/shared/theme.dart';
import 'package:provider/provider.dart';

// Connecting Page
// After QR Scanned, to conditional Routing
class ConnectingPage extends StatefulWidget {
  const ConnectingPage({super.key, required this.serialnumber});
  final String serialnumber;

  @override
  State<ConnectingPage> createState() => _ConnectingPageState();
}

class _ConnectingPageState extends State<ConnectingPage> {
  @override
  void initState() {
    super.initState();
    handleStart(serialNumber: widget.serialnumber);
  }

  // Start After QR Scanned
  // Give Conditional To Routing
  handleStart({required String serialNumber}) async {
    final DeviceProvider deviceProvider =
        Provider.of<DeviceProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    try {
      if (await deviceProvider.connectDevice(serialNumber: serialNumber)) {
        // Success Connecting
        navigator.pushNamedAndRemoveUntil('/main', (route) => false);
      } else {
        navigator.pushNamedAndRemoveUntil(
            '/start', (route) => false); // Fail Connecting back to start page
      }
    } catch (e) {
      navigator.pushNamedAndRemoveUntil('/start',
          (route) => false); // Have some errors and back to start page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Connect to ',
                style: whiteText.copyWith(
                  fontSize: 24,
                  fontWeight: regular,
                ),
              ),
              Text(
                'Kiddy Device',
                style: whiteText.copyWith(
                  fontSize: 24,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connecting...',
                  style: whiteText.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                    color: darkGreenColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
