// Import libraries and packages
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kiddy/models/detection_model.dart';
import 'package:kiddy/providers/device_provider.dart';
import 'package:kiddy/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:image/image.dart' as img;
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  int count = 0;
  late final WebSocketChannel _channel;
  DetectionModel? detect;

  // Initialization Load TensorFlow Model
  initTFLite() async {
    await Tflite.loadModel(
      model: "assets/models/model_unquant.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  // To Convert Stream Image Format
  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  // To Run Model Detect Object
  objectDetector(Uint8List binary) async {
    img.Image? image = img.decodeImage(binary);
    if (image != null) {
      var detector = await Tflite.runModelOnBinary(
        binary: imageToByteListFloat32(image, 224, 127.5, 127.5),
        asynch: true,
        numResults: 1,
        threshold: 0.04,
      );
      if (detector != null && detector.isNotEmpty) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(detector.first as Map);
        setState(() {
          detect = DetectionModel.fromJson(data);
        });
      }
    }
  }

  // Connect to WebSocket
  initWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://152.42.191.96:65080'),
    );
  }

  @override
  void initState() {
    super.initState();
    initTFLite();
    initWebSocket();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
    _channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    DeviceProvider deviceProvider = Provider.of<DeviceProvider>(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 28),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55,
          color: lightGreyColor,
          child: Stack(
            children: [
              StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: whiteColor,
                      ),
                    );
                  } else {
                    // Detect once after count untill 10
                    count++;
                    if (count % 10 == 0) {
                      count = 0;
                      if (snapshot.data != null) {
                        objectDetector(snapshot.data);
                      }
                    }

                    return Image.memory(
                      snapshot.data,
                      gaplessPlayback: true,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      fit: BoxFit.cover,
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: textShadow,
                      ),
                      child: Text(
                        'Kana\'s Camera',
                        style: whiteText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: textShadow,
                          ),
                          child: DigitalClock(
                            showSecondsDigit: false,
                            hourMinuteDigitTextStyle: whiteText,
                            is24HourTimeFormat: true,
                            colon: Text(
                              ":",
                              style: whiteText,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: textShadow,
                          ),
                          child: Visibility(
                            visible: detect != null,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: blueColor,
                                  radius: 8,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  detect != null
                                      ? detect!.label.split(' ')[1]
                                      : '',
                                  style: whiteText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Skeletonizer(
              enabled: deviceProvider.device == null,
              child: IconButton.filled(
                isSelected: false,
                iconSize: 32,
                onPressed: () {},
                icon: Icon(
                  Icons.mic,
                  color: whiteColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Skeletonizer(
              enabled: deviceProvider.device == null,
              child: IconButton.filled(
                isSelected: deviceProvider.device?.isSwing,
                iconSize: 32,
                onPressed: () async {
                  await deviceProvider.updateSwing();
                },
                icon: Icon(
                  Icons.waves_rounded,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
