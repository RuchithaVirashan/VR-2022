import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vr_app_2022/components/game_list_dialogbox.dart';
import 'package:vr_app_2022/components/scanpage/scanned_gamelist_dialogbox.dart';
import '../../models/vr_scanned_user_model.dart';
import '../../store/application_state.dart';
import '../../store/scanneduser/scanneduser_action.dart';
import '../error.dart';

class GameQRView extends StatefulWidget {
  const GameQRView({Key? key}) : super(key: key);

  @override
  State<GameQRView> createState() => _GameQRViewState();
}

class _GameQRViewState extends State<GameQRView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Map<String, VRScannedUser> vrscanneduserList = {};
  var onclickbutton = false;
  int _currentTabIndex = 0;
  Barcode? result;
  QRViewController? controller;
  var isLoading = false;
  String loadingStatus = "";
  List<String> items = [];

  void fetchData() async {
    Response response;
    setState(() {
      var loadingStatus = "loading";
    });
    try {
      response = await Dio().get(
          "https://registervr-2c445-default-rtdb.firebaseio.com/scannedUser.json");
      print(response);
      if (response.statusCode == 200) {
        VRScannedUserResponse vrscanneduserResponse =
            VRScannedUserResponse.fromJson(response.data);

        setState(() {
          vrscanneduserList = vrscanneduserResponse.vrscanneduserList;
        });

        // Assuming you have a map of VRScannedUser objects named vrscanneduserList
        VRScannedUser vrUser = vrscanneduserList["VRFOC230003"]!;
        Map<String, bool> gameList = vrUser.gameList; // get the gameList map
        String gameListJson =
            jsonEncode(gameList); // encode the map as a JSON string

        print("VRScannedUser GameList $gameListJson");
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
          // showErrorDialog(context, 'Scanned QR is valid');
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
    if (vrscanneduserList.containsKey("$code")) {
      final VRScannedUser vrUser = vrscanneduserList["$code"]!;
      Map<String, bool>? gameList = vrUser.gameList;
      final String gameListJson = jsonEncode(gameList);
      final Map<String, dynamic> gameListMap = jsonDecode(gameListJson);
      final Map<String, bool> scannedgameList =
          gameListMap.map((key, value) => MapEntry(key, value as bool));

      StoreProvider.of<ApplicationState>(
        context,
      ).dispatch(AssignScannedUserGames(scannedgameList));
      print("Authorized $code");
      print("Redux ${StoreProvider.of<ApplicationState>(
        context,
      ).state.scanneduserstate.gameList}");
      showScannedGameList(context);
    } else {
      showErrorDialog(context, 'Not Scanned User!');
    }
  }

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
                    Center(
                      child: Visibility(
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
