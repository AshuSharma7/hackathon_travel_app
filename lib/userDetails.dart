import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

TextEditingController name = new TextEditingController();
TextEditingController sourceAdd = new TextEditingController();
TextEditingController destAdd = new TextEditingController();

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Details",
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
                controller: name,
                style: TextStyle(fontFamily: "Quicksand"),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontFamily: "Comfortaa"),
                    hintText: "Full name",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
