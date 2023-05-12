import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../store/application_state.dart';
import '../global/constants.dart';

class ProfileButton extends StatelessWidget {
  final void Function()? onPressed;
  final String imgName;

  const ProfileButton({
    super.key,
    required this.imgName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return InkWell(
      onTap: () {
        onPressed!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Image.asset(
              imgName,
              color: const Color.fromRGBO(205, 210, 209, 1),
            ),
          ),
        ],
      ),
    );
  }
}
