import 'package:flutter/material.dart';
import '/components/text_field_container.dart';
import '/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String display;
  final Function check;
  const RoundedPasswordField(
      {Key key, this.onChanged, this.display = "Password", this.check})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = _obscureText ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        validator: widget.check,
        decoration: InputDecoration(
          hintText: widget.display,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: kPrimaryColor,
            onPressed: _toggle,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
