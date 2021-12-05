//map
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:untitled/Result.dart';

class Location extends StatefulWidget {
  Location(
      {Key? key,
      required this.address,
      required this.county,
      required this.state,
      required this.zip_code,
      required this.business_type})
      : super(key: key);
  final String address, county, state, zip_code, business_type;
  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  Map<String, dynamic> _serverInfo = Map();

  void initState() {
    // TODO: implement initState
    super.initState();
    serverInfo();
  }

  void serverInfo() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = //local host
        Uri.parse(
            'http://18.118.105.155/${widget.address}/${widget.county}/${widget.state}/${widget.zip_code}/${widget.business_type}');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        _serverInfo = jsonResponse;
      });
      var newPos = LatLng(_serverInfo['latitude'], _serverInfo['longitude']);
      CameraUpdate u2 = CameraUpdate.newCameraPosition(CameraPosition(
        target: newPos,
        zoom: 15,
        // tilt: 59.440717697143555,
      ));
      mapController.animateCamera(u2);
      addMarker(newPos, "your Location", "", BitmapDescriptor.hueRed);
      addMarkersNearby();
      addMarkersParking();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void addMarkersNearby() {
    //print(_states['near_by_place']);
    for (int i = 0; i < _serverInfo['near_by_place'].length; i++) {
      var newPos = LatLng(_serverInfo['near_by_place'][i]['lat'],
          _serverInfo['near_by_place'][i]['lng']);
      addMarker(
          newPos,
          _serverInfo['near_by_place'][i]['name'],
          double.parse(_serverInfo['near_by_place'][i]['distance'])
                  .toStringAsFixed(2) +
              ' miles',
          BitmapDescriptor.hueBlue);
    }
  }

  void addMarkersParking() {
    //print(_states['near_by_place']);
    for (int i = 0; i < _serverInfo['parkings'].length; i++) {
      var newPos = LatLng(
          _serverInfo['parkings'][i]['lat'], _serverInfo['parkings'][i]['lng']);
      addMarker(
          newPos,
          _serverInfo['parkings'][i]['name'],
          double.parse(_serverInfo['parkings'][i]['distance'])
                  .toStringAsFixed(2) +
              ' miles',
          BitmapDescriptor.hueMagenta);
    }
  }

  late GoogleMapController mapController;
  late LatLng _center = const LatLng(34, -118);
  var myPosition;
  final Set<Marker> _markers = {};
  BitmapDescriptor? pinLocationIcon;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
/*
  LocationState() {
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      print('Successfully got nearby position');
      print(position.longitude);
      print(position.latitude);
      myPosition = position;
      var newPos = LatLng(position.latitude,position.longitude);
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
*/

  // void setCustomMapPin(context) {
  //   if (pinLocationIcon == null) {
  //     ImageConfiguration configuration = createLocalImageConfiguration(context);
  //     BitmapDescriptor.fromAssetImage(configuration, 'assets/bluemarker.png')
  //         .then((icon) {
  //       setState(() {
  //         pinLocationIcon = icon;
  //         print('***************' + icon.toString() + '*******************');
  //       });
  //     });
  //   }
  // }

  void addMarker(
      LatLng mLatLng, String mTitle, String mDescription, double iconColor) {
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
        icon: BitmapDescriptor.defaultMarkerWithHue(iconColor),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // setCustomMapPin(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Maps'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.assessment_outlined),
          tooltip: '',
          onPressed: () {
            Navigator.push(
                //connect to different screen
                context,
                MaterialPageRoute(
                  //connect different route
                  builder: (context) => Result(
                      //build Location
                      title: "",
                      serverInfo: _serverInfo),
                ));
          },
        ),
      ]),
      body:
          SizedBox(
            width:
                MediaQuery.of(context).size.width, // or use fixed size like 200
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
    );
  }
}
