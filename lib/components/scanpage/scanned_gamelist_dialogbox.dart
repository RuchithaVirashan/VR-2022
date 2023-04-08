import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vr_app_2022/components/pop_error.dart';
import 'package:vr_app_2022/screen/qr-page.dart';
import 'package:vr_app_2022/store/vruser/vruser_state.dart';
import '../../global/constants.dart';
import '../../store/application_state.dart';
import '../bottom_navigation.dart';


Future<void> showScannedGameList(
  BuildContext context,
) async {
  Size size = MediaQuery.of(context).size;
  double relativeWidth = size.width / Constants.referenceWidth;
  double relativeHeight = size.height / Constants.referenceHeight;
  
final Map<String, bool>? gameList = StoreProvider.of<ApplicationState>(context).state.scanneduserstate.gameList;

final List<String> gameListKeys = gameList!.keys.toList();

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Game'),
        content: Column(
          children: [
            ListBody(
              children: gameListKeys
                  .map((item) => Padding(
                        padding: EdgeInsets.only(
                            top: relativeHeight * 24.5,
                            left: relativeWidth * 29.0,
                            right: relativeWidth * 29.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color.fromRGBO(116, 118, 136, .6),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Color.fromRGBO(116, 118, 136, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text('Payment'),
            //     Padding(
            //       padding: EdgeInsets.only(left: relativeWidth * 10.0),
            //       child: Transform.scale(
            //         scale: 0.7,
            //         child: StatefulBuilder(
            //             builder: (BuildContext context, StateSetter setState) {
            //           return CupertinoSwitch(
            //             value: isPay,
            //             activeColor: const Color.fromRGBO(4, 67, 67, 1),
            //             onChanged: (val) async {
            //               setState(() {
            //                 isPay = !isPay;
            //               });
            //             },
            //           );
            //         }),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // if (isPay == true) {
              //   setData(userState, isPay);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MainPage(
                        indexPage: 1,
                      );
                    },
                  ),
                );
              // } else {
              //   popErrorDialog(context, 'Payment is not complete!');
              // }
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  });
}
