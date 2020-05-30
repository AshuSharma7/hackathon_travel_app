import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddVehical extends StatefulWidget {
  @override
  _AddVehical createState() => _AddVehical();
}

TextEditingController category = TextEditingController();
TextEditingController subcategory = TextEditingController();
TextEditingController vnumber = TextEditingController();
TextEditingController registrationId = TextEditingController();
TextEditingController capacity = TextEditingController();
TextEditingController fare = TextEditingController();
TextEditingController startingpt = TextEditingController();
TextEditingController endpt = TextEditingController();
TextEditingController starttime = TextEditingController();
TextEditingController endtime = TextEditingController();

class _AddVehical extends State<AddVehical> {
  void makePost(var a, var b, var c, var d, var e, var f, var g, var h, var i,
      var j) async {
    String url =
        "http://apigo-docker.herokuapp.com/heroku_83210746493cc84/private";
    var body = {
      "vehicalfare": f,
      "vehicalendtime": j,
      "vehicalCategory": a,
      "vehicalSubCategory": b,
      "vehicalNumber": c,
      "vehicalRegistrationID": d,
      "vehicalstartpoint": g,
      "vehicalendpoint": h,
      "vehicalstarttime": i,
      "vehicalcapacity": e
    };
    http.Response r = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    print(r.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Your Vehical Status")),
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: category,
              decoration: InputDecoration(hintText: "Enter Vehical Category"),
            ),
            TextField(
              controller: subcategory,
              decoration:
                  InputDecoration(hintText: "Enter Vehical Sub-Category"),
            ),
            TextField(
              controller: vnumber,
              decoration: InputDecoration(hintText: "Enter Vehical Number"),
            ),
            TextField(
              controller: registrationId,
              decoration:
                  InputDecoration(hintText: "Enter Vehical Registration-ID"),
            ),
            TextField(
              controller: capacity,
              decoration: InputDecoration(hintText: "Enter Passenger Capacity"),
            ),
            TextField(
              controller: fare,
              decoration: InputDecoration(hintText: "Enter Fare Per Km."),
            ),
            TextField(
              controller: startingpt,
              decoration:
                  InputDecoration(hintText: "Enter Vehical Starting Point"),
            ),
            TextField(
              controller: endpt,
              decoration:
                  InputDecoration(hintText: "Enter Vehical Destination Point"),
            ),
            TextField(
              controller: starttime,
              decoration:
                  InputDecoration(hintText: "Enter Vehical Starting Time"),
            ),
            TextField(
              controller: endtime,
              decoration:
                  InputDecoration(hintText: "Enter Vehical Stopping Time"),
            ),
            FlatButton(
              onPressed: () {
                var a = category.text;
                var b = subcategory.text;
                var c = vnumber.text;
                var d = registrationId.text;
                var e = capacity.text;
                var f = fare.text;
                var g = startingpt.text;
                var h = endpt.text;
                var i = starttime.text;
                var j = endtime.text;

                if (category.text != "" &&
                    subcategory.text != "" &&
                    vnumber.text != "" &&
                    registrationId.text != "" &&
                    capacity.text != "" &&
                    fare.text != "" &&
                    startingpt.text != "" &&
                    endpt.text != "" &&
                    starttime.text != "" &&
                    endtime.text != "") {
                  makePost(a, b, c, d, e, f, g, h, i, j);
                  Fluttertoast.showToast(
                      msg: "Value Posted", toastLength: Toast.LENGTH_SHORT);
                  category.clear();
                  subcategory.clear();
                  vnumber.clear();
                  registrationId.clear();
                  capacity.clear();
                  fare.clear();
                  startingpt.clear();
                  endpt.clear();
                  starttime.clear();
                  endtime.clear();
                }
                else{
                  Fluttertoast.showToast(
                      msg: "Enter the Value", toastLength: Toast.LENGTH_SHORT);
                }
              },
              child: Text("Submit"),
            )
          ],
        ),
      )),
    );
  }
}
