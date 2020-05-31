import 'dart:async';
import 'dart:convert';
import 'package:hackathon/vehicles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Destination extends StatefulWidget {
  @override
  _DestinationState createState() => _DestinationState();
}

String apiKey = "7e8622846bb919";
TextEditingController dest = new TextEditingController();

class _DestinationState extends State<Destination> {
  getLatLong() async {
    String url =
        "https://eu1.locationiq.com/v1/search.php?key=$apiKey&q=${dest.text}&format=json";
    http.Response response = await http.get(url);
    List<dynamic> map = jsonDecode(response.body);
    GoogleMapController controller = await _controller.future;
    CameraPosition newPos = CameraPosition(
        target: LatLng(
          double.parse(map[0]["lat"]),
          double.parse(map[0]["lon"]),
        ),
        zoom: 13.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
  }

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

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
    CameraPosition initialCameraPosition =
        CameraPosition(zoom: 3.0, target: LatLng(20.5937, 78.9629));
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
                "DROP LOCATION",
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: dest,
                      style: TextStyle(fontFamily: "Quicksand"),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontFamily: "Comfortaa"),
                          hintText: "Enter Address and press >",
                          counterText: "",
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Please wait for upto 10 seconds");
                        getLatLong();
                      })
                ],
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
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Vehicles()));
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
