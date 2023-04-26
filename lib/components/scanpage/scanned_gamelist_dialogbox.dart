import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vr_app_2022/components/pop_error.dart';
import 'package:vr_app_2022/components/scanpage/error.dart';
import 'package:vr_app_2022/screen/qr-page.dart';
import 'package:vr_app_2022/store/scanneduser/scanneduser_state.dart';
import 'package:vr_app_2022/store/vruser/vruser_state.dart';
import '../../global/constants.dart';
import '../../store/application_state.dart';
import '../../store/scanneduser/scanneduser_action.dart';
import '../bottom_navigation.dart';
import '../error.dart';

Future<void> showScannedGameList(
  BuildContext context,
  tabname,
) async {
  Size size = MediaQuery.of(context).size;
  double relativeWidth = size.width / Constants.referenceWidth;
  double relativeHeight = size.height / Constants.referenceHeight;

  final Map<String, bool>? gameList =
      StoreProvider.of<ApplicationState>(context)
          .state
          .scanneduserstate
          .gameList;

  List<String> trueGames = [];
  List<String> falseGames = [];

  gameList!.forEach((key, value) {
    if (value == true) {
      trueGames.add(key);
    } else {
      falseGames.add(key);
    }
  });

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    print("gameList $trueGames");
    print("gameListfalse $falseGames");
    print("Tabname $tabname");
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Game'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: relativeWidth * (double.maxFinite / 3),
                child: Column(
                  children: [
                    const Text("Not Played"),
                    ListBody(
                      children: falseGames
                          .map((item) => Padding(
                                padding: EdgeInsets.only(
                                    top: relativeHeight * 24.5,
                                    left: relativeWidth * 10.0,
                                    right: relativeWidth * 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          116, 118, 136, .6),
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: relativeWidth * (double.maxFinite / 3),
                child: Column(
                  children: [
                    const Text("Played"),
                    ListBody(
                      children: trueGames
                          .map((item) => Padding(
                                padding: EdgeInsets.only(
                                    top: relativeHeight * 24.5,
                                    left: relativeWidth * 29.0,
                                    right: relativeWidth * 29.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          116, 118, 136, .6),
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
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (gameList.containsKey(tabname)) {
                bool isGameSelected = gameList[tabname]!;
                print("GameSelect $isGameSelected");
                if (isGameSelected == false) {
                  gameList[tabname] = true;
                  print("update gameList $gameList");
                  StoreProvider.of<ApplicationState>(
                    context,
                  ).dispatch(AssignScannedUserGames(
                      gameList,
                      StoreProvider.of<ApplicationState>(
                        context,
                      ).state.scanneduserstate.uuId,
                      StoreProvider.of<ApplicationState>(
                        context,
                      ).state.scanneduserstate.username));
                  // Get a reference to the gameList node in the Realtime Database
                  DatabaseReference gameListRef = FirebaseDatabase.instance
                      .reference()
                      .child('scannedUser')
                      .child(StoreProvider.of<ApplicationState>(
                        context,
                      ).state.scanneduserstate.uuId)
                      .child('gameList');

                  setData(
                      StoreProvider.of<ApplicationState>(
                        context,
                      ).state.scanneduserstate,
                      tabname);

// Update the gameList node with the new game list data
                  gameListRef.set(gameList).then((value) {
                    print('Game list updated successfully');

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const MainPage(
                            indexPage: 1,
                          );
                        },
                      ),
                    );
                  }).catchError((error) {
                    print('Failed to update game list: $error');
                  });
                } else {
                  showScannedErrorDialog(context, 'Already played');
                }
              } else {
                showScannedErrorDialog(context, 'Not entrolled');
              }
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  });
}

void setData(ScannedUserState scanneduserstate, tabname) {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child(tabname)
      .child(scanneduserstate.uuId);

  Map<String, dynamic> userData = {
    'uuid': scanneduserstate.uuId,
    'name': scanneduserstate.username,
    'marks': 0,
  };

  reference.set(userData);
}
