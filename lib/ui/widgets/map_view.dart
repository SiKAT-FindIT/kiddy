// Import Libraries and Packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiddy/providers/device_provider.dart';
import 'package:kiddy/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // Maps
  final Completer<GoogleMapController?> _mapsController = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    DeviceProvider deviceProvider =
        Provider.of<DeviceProvider>(context, listen: false);
    deviceProvider.getDeviceData();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/marker.png")
        .then(
      (icon) {
        markerIcon = icon;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DeviceProvider deviceProvider = Provider.of<DeviceProvider>(context);

    return Skeletonizer(
      enabled: deviceProvider.device == null,
      child: deviceProvider.device == null
          ? const SizedBox()
          : Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 28),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      color: lightGreyColor,
                      child: GoogleMap(
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(deviceProvider.device!.latitude,
                              deviceProvider.device!.longitude),
                          zoom: 16,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: {
                          Marker(
                            markerId: MarkerId(
                              deviceProvider.device!.latitude.toString() +
                                  deviceProvider.device!.longitude.toString(),
                            ),
                            position: LatLng(deviceProvider.device!.latitude,
                                deviceProvider.device!.longitude),
                            icon: markerIcon,
                            infoWindow:
                                const InfoWindow(title: "Kana's Location"),
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
            ),
    );
  }
}
