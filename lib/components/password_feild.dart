import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordFeild extends StatelessWidget {
  final double relativeHeight;
  final double relativeWidth;
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData iconName;
  final String? Function(String?)? validate;
  final void Function()? togglePasswordView;
  final bool isHidden;

  const PasswordFeild(
      {Key? key,
      required this.relativeHeight,
      required this.relativeWidth,
      required this.title,
      required this.controller,
      required this.hintText,
      required this.iconName,
      required this.validate,
      required this.togglePasswordView,
      required this.isHidden})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isHidden,
      decoration: InputDecoration(
        labelText: title,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18),
        prefixIcon: Icon(iconName),
        suffixIcon: InkWell(
          onTap: togglePasswordView,
          child: Icon(
            Icons.visibility,
            color:
                isHidden == true ? Colors.grey : Color.fromRGBO(74, 67, 236, 1),
          ),
        ),
      ),
      validator: validate,
    );
  }
}
