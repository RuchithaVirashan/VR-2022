import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vr_app_2022/screen/qr-page.dart';

import '../../global/constants.dart';
import 'bottom_navigation.dart';

Future<void> showPopErrorDialog(BuildContext context, String content) async {
  Size size = MediaQuery.of(context).size;
  double relativeWidth = size.width / Constants.referenceWidth;
  double relativeHeight = size.height / Constants.referenceHeight;
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Error'),
        content: Column(
          children: [
            Container(
              child: Lottie.asset('assets/wrong.json',
                  animate: true,
                  height: relativeHeight * 50,
                  width: relativeWidth * 50),
            ),
            Text(content),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  });
}
