import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:guide/views/colors.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.3152, 44.3661),
    zoom: 14.4746,
  );

  var textController = TextEditingController();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("plocation".tr,
            style: const TextStyle(
                color: secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'redex')),
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        // toolbarHeight: 60,
        centerTitle: true,
        iconTheme: const IconThemeData(color: secondaryColor, size: 30),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: const FaIcon(
              FontAwesomeIcons.locationDot,
              size: 40,
              color: secondaryColor,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              // hide location button
              myLocationButtonEnabled: false,
              mapType: MapType.normal,

              //  camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                textController.text = "تحديث العنوان ...";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();
                //get address name from camera position
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                  localeIdentifier: "ar",
                );
                // update the ui with the address
                textController.text = '${placemarks.first.street}';
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            width: MediaQuery.of(context).size.width - 50,
            height: 40,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(1, 1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextFormField(
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    // height: 19/19,
                  ),
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  controller: textController,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  var location = [
                    cameraPosition.target.longitude,
                    cameraPosition.target.latitude
                  ];
                  Get.back(result: location);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: Text("setlocationonmap".tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'dubai')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
