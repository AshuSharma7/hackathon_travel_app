import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyVehicals extends StatefulWidget {
  @override
  _MyVehicals createState() => _MyVehicals();
}

Future<Map> getUri() async {
  String url =
      'http://apigo-docker.herokuapp.com/heroku_83210746493cc84/private/21';
  http.Response response = await http.get(url);
  print(response.body);
  return json.decode(response.body);
}

class _MyVehicals extends State<MyVehicals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map data = snapshot.data;
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.grey.shade300),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Center(
                                child: Text(
                              data["vehicalCategory"],
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalSubCategory"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalNumber"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalRegistrationID"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalcapacity"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalfare"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalendpoint"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalstartpoint"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalstarttime"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data["vehicalendtime"],
                                    style: TextStyle(
                                        fontSize: 20,),
                                  ),
                                ))
                          ],
                        ),
                      );
                    });
              } else {
                return Text("data");
              }
            },
          ),
        ),
      ),
    );
  }
}
