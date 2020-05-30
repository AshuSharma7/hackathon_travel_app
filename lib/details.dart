import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Google Maps'),
            backgroundColor: Colors.black,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Text("Google map"),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: GoogleMap(
                    onTap: markerTap,
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
