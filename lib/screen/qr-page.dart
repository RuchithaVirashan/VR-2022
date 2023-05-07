import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vr_app_2022/components/game_list_dialogbox.dart';
import '../components/error.dart';
import '../models/vr_scanned_user_model.dart';
import '../models/vr_user_model.dart';
import '../store/application_state.dart';
import '../store/vruser/vruser_action.dart';

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
  String loadingStatus = "";
  Map<dynamic, VRUser> vruserList = {};
  List<String> items = [];
  List<dynamic> keysArray = [];
  Map<String, VRScannedUser> vrscanneduserList = {};

  void fetchData() async {
    Response response;
    setState(() {
      loadingStatus = "loading";
    });
    try {
      response = await Dio().get(
          "https://virtual-rival-23-default-rtdb.firebaseio.com/Form responses 2.json");
      // print('response 111 ${response}');
      if (response.statusCode == 200) {
        VRUserResponse vruserResponse = VRUserResponse.fromJson(response.data);
        // print("Vr user 1111111 ${vruserResponse}");

        setState(() {
          vruserList = vruserResponse.vruserList;
        });
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

  void fetchScannedData() async {
    Response response;
    setState(() {
      var loadingStatus = "loading";
    });
    try {
      response = await Dio().get(
          "https://virtual-rival-23-default-rtdb.firebaseio.com/scannedUser.json");
      // print(response);
      if (response.statusCode == 200) {
        VRScannedUserResponse vrscanneduserResponse =
            VRScannedUserResponse.fromJson(response.data);

        setState(() {
          vrscanneduserList = vrscanneduserResponse.vrscanneduserList;
        });

        // Assuming you have a map of VRScannedUser objects named vrscanneduserList
        // VRScannedUser vrUser = vrscanneduserList["VRFOC230003"]!;
        // Map<String, bool> gameList = vrUser.gameList; // get the gameList map
        // String gameListJson =
        //     jsonEncode(gameList); // encode the map as a JSON string

        // print("scanned user $vrscanneduserList");
      }
    } catch (e) {
      print(e);
    }
  }

  void registeredUser(String? code) {
    // print('register user 111111 ${vruserList.containsKey("$code")}');
    // print('register user 22222 ${vruserList}');
    // print('register user 3333 ${code}');

    // databaseReference
    //     .child('scannedUser')
    //     .onValue
    //     .listen((DatabaseEvent event) {
    //   scannedUser = event.snapshot.value;
    //   // if (scannedUser is Map) {
    //   //   // check if scannedUser is a Map
    //   //   keysArray = scannedUser.keys.toList();
    //   //   print('Scanned User Key: $keysArray');
    //   // } else {
    //   //   print('Scanned user is not a map');
    //   // }
    //   print('Scanned User Key: ${scannedUser.runtimeType}');
    // });

    if (vruserList.containsKey("$code")) {
      if (vrscanneduserList.containsKey("$code")) {
        showErrorDialog(context, 'Alredy registered');
      } else {
        StoreProvider.of<ApplicationState>(
          context,
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
          ).dispatch(AssignGames(
              gamesList: individualUser,
              userName: vruserList["$code"]!.name,
              uuId: '$code'));

          print("GameList $individualUser ${vruserList["$code"]!.name}");
          showGameList(context);
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
          ).dispatch(AssignGames(
              gamesList: TeamGames,
              userName: vruserList["$code"]!.teamname,
              uuId: '$code'));

          // print("GameList $TeamGames ${vruserList["$code"]!.teamname}");

          showGameList(context);
        }
      }
    } else {
      showErrorDialog(context, 'Not Registered User!');
    }
  }

  @override
  void didChangeDependencies() {
    print('call dis ');
    fetchData();
    fetchScannedData();

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
