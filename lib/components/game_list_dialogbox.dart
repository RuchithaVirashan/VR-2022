import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vr_app_2022/components/pop_error.dart';
import 'package:vr_app_2022/screen/qr-page.dart';
import 'package:vr_app_2022/store/vehicle/vehicle_state.dart';
import '../../global/constants.dart';
import '../store/application_state.dart';
import 'bottom_navigation.dart';
import 'error.dart';

Future<void> showGameList(
  BuildContext context,
) async {
  Size size = MediaQuery.of(context).size;
  double relativeWidth = size.width / Constants.referenceWidth;
  double relativeHeight = size.height / Constants.referenceHeight;

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    bool isPay = false;
    final userState = StoreProvider.of<ApplicationState>(
      context,
    ).state.userState;
    final List<String> items = userState.selectedgametype == "Individual"
        ? ["Most Wanted", " Blur", " Crash Bandicoot", " Breakneck"]
        : ["Call Of Duty Modern Warfare 4", " PubG"];
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('${userState.selectedgametype} Game'),
        content: Column(
          children: [
            ListBody(
              children: items
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
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Card(
                              child: CheckboxListTile(
                                  value: userState.selectedGames.contains(item),
                                  title: Text(
                                    item,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(116, 118, 136, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: (isChecked) {
                                    setState(() {
                                      if (isChecked!) {
                                        StoreProvider.of<ApplicationState>(
                                          context,
                                        )
                                            .state
                                            .userState
                                            .selectedGames
                                            .add(item);
                                      } else {
                                        StoreProvider.of<ApplicationState>(
                                          context,
                                        )
                                            .state
                                            .userState
                                            .selectedGames
                                            .remove(item);
                                      }
                                    });

                                    print(StoreProvider.of<ApplicationState>(
                                      context,
                                    ).state.userState.selectedGames);
                                  }),
                            );
                          }),
                        ),
                      ))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Payment'),
                Padding(
                  padding: EdgeInsets.only(left: relativeWidth * 10.0),
                  child: Transform.scale(
                    scale: 0.7,
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return CupertinoSwitch(
                        value: isPay,
                        activeColor: const Color.fromRGBO(4, 67, 67, 1),
                        onChanged: (val) async {
                          setState(() {
                            isPay = !isPay;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (isPay == true) {
                setData(userState, isPay);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MainPage(
                        indexPage: 0,
                      );
                    },
                  ),
                );
              } else {
                popErrorDialog(context, 'Payment is not complete!');
              }
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  });
}

void setData(UserState userState, bool isPay) {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('scannedUser')
      .child(userState.selectedUuId);
  Map<String, dynamic> gameMap = {
    for (var game in userState.selectedGames) game: false
  };
  Map<String, dynamic> userData = {
    'gameList': gameMap,
    'payment': isPay,
    'gameType': userState.selectedgametype,
    'uuid': userState.selectedUuId,
    'marks': '',
  };

  reference.set(userData);
}
