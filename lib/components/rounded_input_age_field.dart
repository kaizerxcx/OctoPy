import 'package:flutter/material.dart';
import '/components/text_field_container.dart';
import '/constants.dart';
import 'package:flutter/services.dart';

class RoundedInputAgeField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String text;
  final Function check;
  const RoundedInputAgeField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.text = '',
    this.check,
  }) : super(key: key);

  @override
  _RoundedInputAgeFieldState createState() => _RoundedInputAgeFieldState();
}

class _RoundedInputAgeFieldState extends State<RoundedInputAgeField> {
  var txt = TextEditingController();
  void initState() {
    super.initState();
    txt.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: txt,
        onChanged: widget.onChanged,
        cursorColor: Color(0X53CFC6),
        keyboardType: TextInputType.number,
        validator: widget.check,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('^([6-8])')),
        ],
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          counterText: "",
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
// class RoundedInputAgeField extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final ValueChanged<String> onChanged;
//   const RoundedInputAgeField({
//     Key key,
//     this.hintText,
//     this.icon = Icons.person,
//     this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextField(
//         onChanged: onChanged,
//         cursorColor: Color(0X53CFC6),
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp('^([6-8])')),
//         ],
//         decoration: InputDecoration(
//           icon: Icon(
//             icon,
//             color: kPrimaryColor,
//           ),
//           counterText: "",
//           hintText: hintText,
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
