import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:vr_app_2022/screen/datagrid_page.dart';
import 'package:vr_app_2022/screen/qr-page.dart';
import 'package:vr_app_2022/store/vehicle/vehicle_state.dart';
import '../../global/constants.dart';
import '../store/application_state.dart';

Future<void> showGameList(
  BuildContext context,
  void Function(String itemValue, bool isSelected) itemChange,
) async {
  Size size = MediaQuery.of(context).size;
  double relativeWidth = size.width / Constants.referenceWidth;
  double relativeHeight = size.height / Constants.referenceHeight;

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final userState = StoreProvider.of<ApplicationState>(
      context,
    ).state.userState;
    final List<String> items = userState.selectedgametype == "Individual"
        ? ["Most Wanted", "Blur", "Crash Bandicoot", "Breakneck"]
        : ["Call Of Duty Modern Warfare 4", "PubG"];
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
                              color: Color.fromRGBO(116, 118, 136, .6),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Card(
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
                                  // Get the selected item
                                  // Call the callback function with the selected item
                                  itemChange(item, isChecked!);
                                }),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const DataGridView();
                  },
                ),
              );
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  });
}
