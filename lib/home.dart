import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loadingMap = true;
  BitmapDescriptor _defaultMarker;
  GoogleMapController mapsController;

  static final CameraPosition _kMendoza = CameraPosition(
    target: LatLng(-32.892826, -68.851940),
    zoom: 16.4746,
  );

  static final List<Map<String,dynamic>> parroquias = [
    {"id": "CDM", "title": "Corazón de María", "subtitle":"9 AM a 20 PM", "lat": -32.890592, "long": -68.852528},
    {"id": "SLG", "title": "San Luis Gonzaga", "subtitle":"9 AM a 20 PM", "lat": -32.894794, "long": -68.840546}
  ];

  @override
  void initState() {
    loadAsset();
    super.initState();
  }

  loadAsset() async {
    ByteData bytes = await rootBundle.load('assets/faith.png');
    setState(() {
      _defaultMarker =  BitmapDescriptor.fromBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(loadingMap);
    final Set<Marker> markers = parroquias.map((p) {
    return Marker(
      icon: _defaultMarker,
      markerId: MarkerId(p['id']),
      position: LatLng(
        p['lat'], p['long']
      ),
      infoWindow: InfoWindow(title: p['title'], snippet: p['subtitle']));
      }).toSet();
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          if (loadingMap) CircularProgressIndicator(),
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kMendoza,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              mapsController = controller;
              loadingMap = false;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        Location location = Location();
        var actualLoc = await location.getLocation();
        mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(actualLoc.latitude, actualLoc.longitude)));
      }),
    );
  }
  
}
