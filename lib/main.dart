import 'package:fallacy_flashcard/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(FallacyApp());
}

class FallacyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Logical Fallacy Flashcard",
        debugShowCheckedModeBanner: false,
        home: FallacyCode());
  }
}

class FallacyCode extends StatefulWidget {
  @override
  _FallacyCodeState createState() => _FallacyCodeState();
}

class _FallacyCodeState extends State<FallacyCode> {
  final _rnd = new Random();
  bool _goingFront = false;
  List _fallacy = [];
  String _frontTitle = "";
  String _fallacyTitle = "";
  String _desc = "";
  String _exampleTitle = "";
  String _example = "";
  var primaryAccentColor;
  var scaffoldBackgroundColor;

  void atFront() {
    setState(() {
      primaryAccentColor = Colors.redAccent;
      _fallacyTitle = "";
      _desc = "";
      _exampleTitle = "";
      _example = "";
    });
  }

  void atBack() {
    setState(() {
      primaryAccentColor = Colors.blueAccent;
      int _index = _rnd.nextInt(_fallacy.length);
      _fallacyTitle = _fallacy[_index]["title"];
      _desc = _fallacy[_index]["desc"];
      _exampleTitle = _fallacyTitle + "'s Example:";
      _example = _fallacy[_index]["eg"];
    });
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final data = await json.decode(response);
    setState(() {
      _fallacy = data["content"];
    });
  }

  @override
  void initState() {
    _frontTitle = "Tap to reveal a random fallacy!";
    primaryAccentColor = Colors.redAccent;
    scaffoldBackgroundColor = Colors.yellowAccent.shade700;
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Logical Fallacy Flashcard",
            style: TextStyle(decoration: TextDecoration.underline)),
        centerTitle: true,
        backgroundColor: primaryAccentColor,
      ),
      endDrawer: Drawer(
          child: Container(
              color: primaryAccentColor,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Row(children: <Widget>[
                        TextButton(
                          child: Text(
                            "ABOUT US",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs(primaryAccentColor: this.primaryAccentColor, scaffoldBackgroundColor: this.scaffoldBackgroundColor,)))
                          },
                        ),
                      ]),
                    ),
                  )
                ],
              ))),
      body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 150.0, horizontal: 10.0),
            child: FlipCard(
                direction: FlipDirection.VERTICAL,
                front: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.redAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      child: Text(_frontTitle,
                          style: TextStyle(
                              color: Colors.yellowAccent.shade700,
                              fontSize: 75,
                              fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
                    ),
                  ],
                ),
                back: Stack(alignment: Alignment.center, children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent,
                  )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5.0),
                          child: Text(
                            _fallacyTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            _desc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 5.0),
                          child: Text(
                            _exampleTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 0.0),
                          child: Text(
                            _example,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                        )
                      ])
                ]),
                onFlipDone: (bool fin) {
                  switch (_goingFront) {
                    case true:
                      atFront();
                      _goingFront = false;
                      break;
                    case false:
                      atBack();
                      _goingFront = true;
                      break;
                  }
                },
                speed: 500),
          )),
    );
  }
}
