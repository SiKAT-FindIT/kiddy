// Import Packages
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiddy/providers/device_provider.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Init state to fetch the application data when start the apps
  getInit() async {
    Timer(const Duration(seconds: 3), () async {
      // Import Providers
      DeviceProvider deviceProvider =
          Provider.of<DeviceProvider>(context, listen: false);
      // Init final context
      final navigator = Navigator.of(context);

      // Check if the device have connected
      await deviceProvider.getSerialNumber();
      if (deviceProvider.deviceSerialNumber == '') {
        navigator.pushNamedAndRemoveUntil('/start', (route) => false);
      } else {
        await deviceProvider.getDeviceData();
        navigator.pushNamedAndRemoveUntil('/main', (route) => false);
      }
    });
  }

  @override
  void initState() {
    getInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 24,
              ),
              width: 130,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            Text(
              'Kiddy',
              style: darkGreyText.copyWith(
                fontSize: 40,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
