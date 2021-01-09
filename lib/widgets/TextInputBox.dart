import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputBox extends StatelessWidget {
  String title;
  String hint;
  bool isPassword;
  bool isCurved;
  Color titleColor;
  Color fillColor;
  Color hintColor;
  Color textColor;
  Color borderColor;
  double borderWidth;

  TextInputBox(
      {this.title,
      this.hint,
      this.isPassword = false,
      this.isCurved = true,
      this.titleColor = Colors.black,
      this.fillColor = Colors.white,
      this.hintColor = Colors.grey,
      this.textColor = Colors.black,
      this.borderColor = Colors.black,
      this.borderWidth = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: titleColor),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
                focusedBorder: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: borderColor, width: borderWidth),
                  borderRadius: isCurved
                      ? const BorderRadius.all(const Radius.circular(10.0))
                      : const BorderRadius.all(const Radius.circular(0)),
                ),
                enabledBorder: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: borderColor, width: borderWidth),
                  borderRadius: isCurved
                      ? const BorderRadius.all(const Radius.circular(10.0))
                      : const BorderRadius.all(const Radius.circular(0)),
                ),
                filled: true,
                hintStyle: new TextStyle(
                    color: hintColor, fontWeight: FontWeight.w400),
                hintText: hint,
                fillColor: fillColor),
          )
        ],
      ),
    );
  }
}
