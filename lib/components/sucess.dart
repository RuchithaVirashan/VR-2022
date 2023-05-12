import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../global/constants.dart';

Future<void> showSuccessDialog(
    BuildContext context, String content, String route, String buttonT) async {
  Size size = MediaQuery.of(context).size;
  double relativeWidth = size.width / Constants.referenceWidth;
  double relativeHeight = size.height / Constants.referenceHeight;
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Success'),
        content: Column(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Lottie.asset('assets/done.json',
                  animate: true,
                  height: relativeHeight * 70,
                  width: relativeWidth * 70),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(content),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushNamed(context, route),
            child: Text(buttonT),
          ),
        ],
      ),
    );
  });
}
