import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/details.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
String user = "";
TextEditingController mobNo = new TextEditingController();
TextEditingController otp = new TextEditingController();

class _LoginState extends State<Login> {
  smsSent(String verificationId, List<int> code, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => otpPage(
                  verificationId: verificationId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Login",
                style: TextStyle(fontFamily: "Pacifico", fontSize: 40.0),
              ),
            ),
            Expanded(child: SizedBox()),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: mobNo.text.length == 10 ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                      width: 2.0,
                      color: mobNo.text.length == 10
                          ? Colors.white
                          : Colors.black)),
              child: TextField(
                maxLength: 10,
                onChanged: (value) {
                  setState(() {});
                },
                controller: mobNo,
                style: TextStyle(
                    letterSpacing: 3.0,
                    fontFamily: "Quicksand",
                    color:
                        mobNo.text.length == 10 ? Colors.white : Colors.black),
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.0),
                    prefixText: "+91",
                    prefixStyle: TextStyle(
                        color: mobNo.text.length == 10
                            ? Colors.white
                            : Colors.black,
                        fontFamily: "Quicksand"),
                    hintStyle: TextStyle(fontFamily: "Comfortaa"),
                    hintText: "Mobile no.",
                    counterText: "",
                    border: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        padding: EdgeInsets.only(top: 30.0),
                        height: 350,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  user = "citizen";
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 750),
                                height: 50,
                                margin: EdgeInsets.all(20.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: user == "citizen"
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                        width: 2.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Text(
                                  "Citizen",
                                  style: TextStyle(
                                      color: user == "citizen"
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  user = "agent";
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 750),
                                height: 50,
                                margin: EdgeInsets.all(20.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: user == "agent"
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                        width: 2.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Text(
                                  "Private Travel Agent",
                                  style: TextStyle(
                                      color: user == "agent"
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  user = "government";
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 750),
                                height: 50,
                                margin: EdgeInsets.all(20.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: user == "government"
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                        width: 2.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Text(
                                  "Government",
                                  style: TextStyle(
                                      color: user == "government"
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ).then((value) {
                  setState(() {});
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 750),
                height: 50,
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: user == "" ? Colors.white : Colors.black,
                    border: Border.all(
                        width: 2.0,
                        color: user == "" ? Colors.black : Colors.white),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  user == ""
                      ? "Select user Type"
                      : (user == "citizen"
                          ? "Citizen"
                          : (user == "agent"
                              ? "Private Travel Agent"
                              : "Governemnt")),
                  style: TextStyle(
                      color: user == "" ? Colors.black : Colors.white,
                      fontFamily: "Comfortaa"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (mobNo.text.length == 10 && user != "") {
                  _auth.verifyPhoneNumber(
                      phoneNumber: "+91" + mobNo.text,
                      timeout: Duration(seconds: 10),
                      verificationCompleted: (authCredential) =>
                          verificationCompleted(authCredential, context),
                      verificationFailed: (authException) =>
                          verificationFailed(authException, context),
                      codeSent: (verificationId, [code]) =>
                          smsSent(verificationId, [code], context),
                      codeAutoRetrievalTimeout: (verificationId) => {});
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  "LOGIN",
                  style:
                      TextStyle(color: Colors.white, fontFamily: "Comfortaa"),
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}

verificationCompleted(AuthCredential authCredential, BuildContext context) {
  _auth.signInWithCredential(authCredential).then((value) {
    Fluttertoast.showToast(msg: value.user.displayName);
  });
}

verificationFailed(AuthException authException, BuildContext context) {
  Fluttertoast.showToast(
    msg: authException.message,
  );
}

class otpPage extends StatefulWidget {
  String verificationId;
  otpPage({Key key, @required this.verificationId}) : super(key: key);
  @override
  _otpPageState createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Login",
                style: TextStyle(fontFamily: "Pacifico", fontSize: 40.0),
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              "Enter OTP",
              style: TextStyle(fontSize: 20.0, fontFamily: "Quicksand"),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 2.0, color: Colors.black)),
              child: TextField(
                controller: otp,
                maxLength: 6,
                onChanged: (value) {
                  setState(() {});
                },
                style: TextStyle(fontFamily: "Quicksand"),
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.0),
                    hintStyle: TextStyle(fontFamily: "Comfortaa"),
                    hintText: "6 Digit OTP",
                    counterText: "",
                    border: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: otp.text.length == 6
                  ? () async {
                      Fluttertoast.showToast(msg: "Please Wait");
                      final AuthCredential authCredential =
                          PhoneAuthProvider.getCredential(
                              verificationId: widget.verificationId,
                              smsCode: otp.text);
                      _auth.signInWithCredential(authCredential).then((value) {
                        Fluttertoast.showToast(
                            msg: value.user.displayName.toString());
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Details()));
                    }
                  : () {
                      Fluttertoast.showToast(msg: "Enter Valid OTP");
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
                            otp.text.length == 6 ? Colors.white : Colors.black),
                    color: otp.text.length == 6 ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: otp.text.length == 6 ? Colors.white : Colors.black,
                      fontFamily: "Comfortaa"),
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}
