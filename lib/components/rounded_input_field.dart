import 'package:flutter/material.dart';
import '/components/text_field_container.dart';
import '/constants.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool isName;
  final String text;
  final Function check;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.isName = false,
    this.text = '',
    this.check,
  }) : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
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
        maxLength: 100,
        validator: widget.check,
        inputFormatters: [
          // widget.isName
          //     ? FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
          //     : FilteringTextInputFormatter.deny(""),
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
// class RoundedInputField extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final ValueChanged<String> onChanged;
//   final bool isName;
//   const RoundedInputField({
//     Key key,
//     this.hintText,
//     this.icon = Icons.person,
//     this.onChanged,
//     this.isName = false,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextField(
//         onChanged: onChanged,
//         cursorColor: Color(0X53CFC6),
//         maxLength: 100,
//         inputFormatters: [
//           isName
//               ? FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
//               : FilteringTextInputFormatter.deny(""),
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
