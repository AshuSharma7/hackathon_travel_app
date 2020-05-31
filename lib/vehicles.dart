import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget {
  @override
  _VehiclesState createState() => _VehiclesState();
}

List<Map<String, dynamic>> vehicle = [
  {
    "name": "Example",
    "source": "Bhiwadi",
    "destination": "Delhi",
    "fare": "300",
    "number": "1234",
    "type": "bus"
  },
  {
    "name": "Example2",
    "source": "Bhiwadi",
    "destination": "Delhi",
    "number": "3456",
    "fare": "400",
    "type": "cab"
  }
];

int selected;

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "${vehicle[0]["source"]} to ${vehicle[0]["destination"]}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Quicksand",
                    fontSize: 25.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 125,
              child: ListView.builder(
                itemCount: vehicle.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                          color: selected == index
                              ? Colors.blue[100]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                              "assets/images/${vehicle[index]["type"]}.png"),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                vehicle[index]["name"],
                                style: TextStyle(fontFamily: "Comfortaa"),
                              ),
                              Text(
                                "No. " + vehicle[index]["number"],
                                style: TextStyle(color: Colors.black38),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutQuad,
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                                color: selected == index
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                    color: selected == index
                                        ? Colors.green
                                        : Colors.black45,
                                    width: 1.0)),
                            child: Center(
                              child: Text(
                                vehicle[index]["fare"] + "₹",
                                style: TextStyle(
                                    fontFamily: "Pacifico",
                                    color: selected == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
