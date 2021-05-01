import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final primaryAccentColor;
  final scaffoldBackgroundColor;

  AboutUs({this.primaryAccentColor, this.scaffoldBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            "About Us",
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          centerTitle: true,
          backgroundColor: primaryAccentColor,
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "         Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ))
        ]));
  }
}
