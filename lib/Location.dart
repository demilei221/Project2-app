import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;

  late LatLng _center = const LatLng(34, -118);

  var myPosition;

  final Set<Marker> _markers = {};

  BitmapDescriptor ? pinLocationIcon ;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  MapSampleState() {
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      print('Successfully got nearby position');
      print(position.longitude);
      print(position.latitude);
      myPosition = position;
      var newPos = LatLng(34.0766,-118.1050);
      CameraUpdate u2 = CameraUpdate.newCameraPosition(CameraPosition(
        target: newPos,
        zoom: 15,
        // tilt: 59.440717697143555,
      ));
      mapController.animateCamera(u2);
      addMarker(newPos, "You are here", "Look for you surroundings");

      // addMarker(LatLng(34.0766,-118.1050), "Another marker", "Look for you surroundings");

    });
  }

  @override
  void initState() {
    super.initState();
  }

  void setCustomMapPin(context) {
    if (pinLocationIcon ==null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/bluemarker.png')
          .then((icon) {
        setState(() {
          pinLocationIcon = icon;
          print('***************' + icon.toString() + '*******************');
        });
      });
    }
  }

  void addMarker(LatLng mLatLng, String mTitle, String mDescription) {
    print('add marker' + mTitle + "_" + mLatLng.toString());
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId:
            MarkerId((mTitle + "_" + _markers.length.toString()).toString()),
        position: mLatLng,
        infoWindow: InfoWindow(
          title: mTitle,
          snippet: mDescription,
        ),
        icon: BitmapDescriptor.defaultMarker ,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    setCustomMapPin(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,  // or use fixed size like 200
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                markers: _markers,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
              ),
            ),
            Container(
              height: 200,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
