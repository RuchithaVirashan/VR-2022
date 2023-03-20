import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vr_app_2022/components/game_list_dialogbox.dart';
import '../components/error.dart';
import '../global/constants.dart';
import '../models/vr_user_model.dart';
import '../store/application_state.dart';
import '../store/vehicle/vehicle_action.dart';
import '../store/vehicle/vehicle_state.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({Key? key}) : super(key: key);

  @override
  State<QRViewPage> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var isLoading = false;
  var draft = <dynamic>[];
  var draftUser = <dynamic>[];
  String loadingStatus = "";
  Map<String, VRUser> vruserList = {};
  List<String> items = [];
  String _selectedItem = '';
  List<String> userSelectedGames = [];

  void fetchData() async {
    Response response;
    setState(() {
      loadingStatus = "loading";
    });
    try {
      response = await Dio().get(
          "https://registervr-2c445-default-rtdb.firebaseio.com/1eoHHF9lyzyOqmH8-SCHMo2S3RXpm0Cc-G4o9Rc9l16U.json");
      print(response);
      if (response.statusCode == 200) {
        VRUserResponse vruserResponse = VRUserResponse.fromJson(response.data);

        setState(() {
          vruserList = vruserResponse.vruserList;
        });

        print("Ruchitha ${vruserList["VRFOC230001"]!.gametype}");
      }
    } catch (e) {
      print(e);
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (validateQRData(scanData.code)) {
        // Valid data
        print('QR code data is valid: ${scanData.code}');
        setState(() {
          result = scanData;
          controller.stopCamera();
          registeredUser(result!.code);
        });
      } else {
        // Invalid data
        print('QR code data is invalid: ${scanData.code}');
        setState(() {
          controller.stopCamera();
          showErrorDialog(context, 'Scanned QR not valid');
        });
      }
    });
  }

  bool validateQRData(String? qrText) {
    // Regular expression to validate the scanned data
    RegExp exp = RegExp(r"VRFOC23");
    return exp.hasMatch(qrText!);
  }

  void registeredUser(String? code) {
    if (vruserList.containsKey("$code")) {
      StoreProvider.of<ApplicationState>(
        context,
        // listen: false,
      ).dispatch(AssignUser(gametype: vruserList["$code"]!.gametype));
      print("Authorized $code");
      print("Redux ${StoreProvider.of<ApplicationState>(
        context,
      ).state.userState.selectedgametype}");

      if (StoreProvider.of<ApplicationState>(
            context,
          ).state.userState.selectedgametype ==
          "Individual") {
        List<String> individualUser = [
          ...?(vruserList["$code"]!.g1.isEmpty
              ? null
              : [vruserList["$code"]!.g1]),
          ...?(vruserList["$code"]!.g2.isEmpty
              ? null
              : [vruserList["$code"]!.g2]),
          ...?(vruserList["$code"]!.g3.isEmpty
              ? null
              : [vruserList["$code"]!.g3]),
          ...?(vruserList["$code"]!.g4.isEmpty
              ? null
              : [vruserList["$code"]!.g4]),
          ...?(vruserList["$code"]!.g5.isEmpty
              ? null
              : [vruserList["$code"]!.g5]),
        ].where((element) => element != null).toList();

        StoreProvider.of<ApplicationState>(
          context,
          // listen: false,
        ).dispatch(AssignGames(
            gamesList: individualUser, userName: vruserList["$code"]!.name));

        print("GameList $individualUser ${vruserList["$code"]!.name}");
        showGameList(context, _itemChange, userSelectedGames);
      } else if (StoreProvider.of<ApplicationState>(
            context,
          ).state.userState.selectedgametype ==
          "Team") {
        List<String> TeamGames = [
          ...?(vruserList["$code"]!.tg1.isEmpty
              ? null
              : [vruserList["$code"]!.tg1]),
          ...?(vruserList["$code"]!.tg2.isEmpty
              ? null
              : [vruserList["$code"]!.tg2]),
        ].where((element) => element != null).toList();

        StoreProvider.of<ApplicationState>(
          context,
          // listen: false,
        ).dispatch(AssignGames(
            gamesList: TeamGames, userName: vruserList["$code"]!.teamname));

        print("GameList $TeamGames ${vruserList["$code"]!.teamname}");
        // showGameList(context, onItemSelected);
        userSelectedGames = TeamGames.map((v) => v).toList();
        showGameList(context, _itemChange, userSelectedGames);
      }
    } else {
      showErrorDialog(context, 'Not Registered User!');
    }
  }

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      // final store = StoreProvider.of<ApplicationState>(context);
      // final List<String> selectedGames =
      //     List<String>.from(store.state.userState.selectedGames);

      // if (isSelected) {
      //   userSelectedGames.add(itemValue);
      //   // StoreProvider.of<ApplicationState>(
      //   //   context,
      //   //   // listen: false,
      //   // ).dispatch(AssignGames(gamesList: selectedGames, userName: ''));
      // } else {
      //   userSelectedGames.remove(itemValue);
      // StoreProvider.of<ApplicationState>(
      //   context,
      //   // listen: false,
      // ).dispatch(AssignGames(gamesList: userSelectedGames, userName: ''));
      //}

      // print(userSelectedGames);
      // _selectedItem = selectedItem;
      if (isSelected) {
        StoreProvider.of<ApplicationState>(
          context,
        ).state.userState.selectedGames.add(itemValue);
      } else {
        StoreProvider.of<ApplicationState>(
          context,
        ).state.userState.selectedGames.remove(itemValue);
      }
    });

    print(StoreProvider.of<ApplicationState>(
      context,
    ).state.userState.selectedGames);
  }

  // void onItemSelected(String selectedItem) {
  //   // Update the state of the parent widget with the selected item
  //   setState(() {
  //     // Update the state variable with the selected item
  //     _selectedItem = selectedItem;
  //   });
  // }

  @override
  void didChangeDependencies() {
    fetchData();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Stack(
              children: [
                Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Visibility(
                      visible: result == null ? true : false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Lottie.asset('assets/scan_effect_ing.json',
                                animate: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: result != null
                          ? Text(
                              '${describeEnum(result!.format)} scanned successfully ${result!.code}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'scannig code',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
