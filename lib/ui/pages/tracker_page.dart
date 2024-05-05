// Import Packages
import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiddy/models/device_model.dart';
import 'package:kiddy/services/device_services.dart';

// Import styles
import 'package:kiddy/shared/theme.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/header.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  // Index for content
  int currentIndex = 0;

  // Carousel Controller
  final CarouselController _controller = CarouselController();

  // Device Data
  DeviceModel? deviceData;

  // Database Reference
  late DatabaseReference deviceRef;

  // Maps
  final Completer<GoogleMapController?> _mapsController = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    // final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    deviceRef = DeviceServices.getDevice(deviceSerialNumber: "Kiddy12345678");
    deviceRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        setState(() {
          deviceData = DeviceModel.fromJson(data, event.snapshot.key!);
        });
      }
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/marker.png")
        .then(
      (icon) {
        markerIcon = icon;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    deviceRef.onDisconnect();
  }

  @override
  Widget build(BuildContext context) {
    // Title
    Widget title() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 48,
          right: 28,
          left: 28,
        ),
        child: Text(
          'Children Tracker',
          style: whiteText.copyWith(fontSize: 20, fontWeight: bold),
        ),
      );
    }

    // Content Camera
    Widget camera() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
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
                          boxShadow: cardShadow,
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
                              horizontal: 16,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: cardShadow,
                            ),
                            child: Text(
                              '09:41',
                              style: whiteText,
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
                              boxShadow: cardShadow,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: blueColor,
                                  radius: 8,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Sleeping',
                                  style: whiteText,
                                ),
                              ],
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
              IconButton.filled(
                isSelected: false,
                iconSize: 32,
                onPressed: () {},
                icon: Icon(
                  Icons.mic,
                  color: whiteColor,
                ),
              ),
              const SizedBox(width: 16),
              IconButton.filled(
                isSelected: deviceData!.isSwing,
                iconSize: 32,
                onPressed: () async {
                  await deviceRef
                      .update({"isSwing": deviceData!.isSwing ? 0 : 1});
                },
                icon: Icon(
                  Icons.waves_rounded,
                  color: whiteColor,
                ),
              ),
            ],
          )
        ],
      );
    }

    // Content Maps
    Widget maps() {
      return Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GoogleMap(
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(deviceData!.latitude, deviceData!.longitude),
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {
                    Marker(
                      markerId: MarkerId(
                        deviceData!.latitude.toString() +
                            deviceData!.longitude.toString(),
                      ),
                      position:
                          LatLng(deviceData!.latitude, deviceData!.longitude),
                      icon: markerIcon,
                      infoWindow: const InfoWindow(title: "Kana's Location"),
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    if (!_mapsController.isCompleted) {
                      _mapsController.complete(controller);
                    }
                  },
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
                  color: whiteColor,
                  boxShadow: cardShadow,
                ),
                child: const Text('Baim\'s Location'),
              )
            ],
          ),
        ],
      );
    }

    // Current Content selected
    Widget content() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: CarouselSlider(
              items: [
                camera(),
                maps(),
              ],
              carouselController: _controller,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                enableInfiniteScroll: false,
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    1.5,
                padEnds: false,
                viewportFraction: 1,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => GestureDetector(
                onTap: () => _controller.animateToPage(index),
                child: Container(
                  width: currentIndex == index ? 20 : 12,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentIndex == index
                        ? darkYellowColor
                        : lightGreyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // render body
    Widget body() {
      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            title(),
            content(),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Header(
            color: darkPinkColor,
          ),
          deviceData != null ? body() : const SizedBox(),
        ],
      ),
    );
  }
}
