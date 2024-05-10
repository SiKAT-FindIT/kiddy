// Import Packages
import 'package:flutter/material.dart';
import 'package:kiddy/ui/widgets/qr_scanner_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, required this.title, required this.onDetect});

  final String title;
  final void Function(String? value, MobileScannerController cameraController)
      onDetect;

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // Flashlight initialization
  bool torchEnabled = false;

  // Camera initialization
  CameraFacing facing = CameraFacing.back;

  // Camera controller
  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              Barcode barcode = barcodes.first;
              widget.onDetect(barcode.rawValue, cameraController);
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: whiteText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Torch Button (Flashlight)
                    IconButton(
                      color: Colors.white,
                      icon: torchEnabled
                          ? const Icon(Icons.flash_on, color: Colors.yellow)
                          : const Icon(Icons.flash_off, color: Colors.grey),
                      onPressed: () => {
                        cameraController.toggleTorch(),
                        setState(() {
                          torchEnabled = !torchEnabled;
                        })
                      },
                    ),

                    // Camera Switch Button (Front/Back)
                    IconButton(
                      color: Colors.white,
                      icon: facing == CameraFacing.back
                          ? const Icon(Icons.camera_front)
                          : const Icon(Icons.camera_rear),
                      onPressed: () => {
                        cameraController.switchCamera(),
                        setState(() {
                          facing = facing == CameraFacing.back
                              ? CameraFacing.front
                              : CameraFacing.back;
                        })
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
