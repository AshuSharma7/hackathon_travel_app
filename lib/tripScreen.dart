import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon/destScreen.dart';
import 'package:location/location.dart';

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;
TextEditingController source = new TextEditingController();

class _TripState extends State<Trip> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng _center;

  void checkLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    if (_serviceEnabled) {
      getLocation();
    }
  }

  void checkLocationpermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == PermissionStatus.granted) {
      checkLocationService();
    }
  }

  void getLocation() async {
    _locationData = await location.getLocation();
    _center = LatLng(_locationData.latitude, _locationData.longitude);
    GoogleMapController controller = await _controller.future;
    CameraPosition newPos = CameraPosition(
        target: LatLng(
          _locationData.latitude,
          _locationData.longitude,
        ),
        zoom: 12.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> _markers = {};

  void markerTap(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationpermission();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition =
        CameraPosition(zoom: 3.0, target: LatLng(20.5937, 78.9629));
    if (_locationData != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(_locationData.latitude, _locationData.longitude),
          zoom: 12.0);
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "PICKUP LOCATION",
                style: TextStyle(
                    fontFamily: "Quicksand",
                    color: Colors.black,
                    fontSize: 40.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 2.0, color: Colors.black)),
              child: TextField(
                controller: source,
                style: TextStyle(fontFamily: "Quicksand"),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontFamily: "Comfortaa"),
                    hintText: "Enter Address",
                    border: InputBorder.none),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: GoogleMap(
                  onTap: markerTap,
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: initialCameraPosition),
            ),
            GestureDetector(
              onTap: _markers.isEmpty
                  ? () {
                      Fluttertoast.showToast(
                          msg:
                              "Please Select Location on Map && Enter Address");
                    }
                  : () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Destination()));
                    },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: 50,
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.0,
                        color:
                            _markers.isNotEmpty ? Colors.white : Colors.black),
                    color: _markers.isNotEmpty ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      color: _markers.isNotEmpty ? Colors.white : Colors.black,
                      fontFamily: "Comfortaa"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
