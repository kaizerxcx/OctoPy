import 'package:flutter/material.dart';
import '/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0XFFF6F6F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0XFFE8E8E8),
          width: 1, //                   <--- border width here
        ),
      ),
      child: child,
    );
  }
}
