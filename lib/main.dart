import 'package:flutter/material.dart';
import 'package:hackathon/login.dart';
import 'package:hackathon/tripScreen.dart';
import 'package:hackathon/userDetails.dart';

import 'details.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Trip(),
    );
  }
}
