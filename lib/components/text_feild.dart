import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../store/application_state.dart';
import '../global/constants.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData iconName;
  final String? Function(String?)? validate;

  const CustomTextField(
      {Key? key,
      required this.title,
      required this.controller,
      required this.hintText,
      required this.iconName,
      required this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: relativeWidth * 18),
        prefixIcon: Icon(iconName),
      ),
      validator: validate,
    );
  }
}
