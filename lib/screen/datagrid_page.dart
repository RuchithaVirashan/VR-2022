import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vr_app_2022/components/scanpage/game_qr_scan.dart';
import '../components/error.dart';
import '../components/scanpage/scan_button_page.dart';
import '../models/vr_scanned_user_model.dart';

class DataGridView extends StatefulWidget {
  const DataGridView({super.key});

  @override
  State<DataGridView> createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  Map<String, VRScannedUser> vrscanneduserList = {};
  var onclickbutton = false;
  int _currentTabIndex = 0;
  Barcode? result;
  QRViewController? controller;
  var isLoading = false;
  String loadingStatus = "";
  List<String> items = [];

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (validateQRData(scanData.code)) {
  //       // Valid data
  //       print('QR code data is valid: ${scanData.code}');
  //       setState(() {
  //         result = scanData;
  //         controller.stopCamera();
  //       });
  //     } else {
  //       // Invalid data
  //       print('QR code data is invalid: ${scanData.code}');
  //       setState(() {
  //         controller.stopCamera();
  //         showErrorDialog(context, 'Scanned QR not valid');
  //       });
  //     }
  //   });
  // }

  // bool validateQRData(String? qrText) {
  //   // Regular expression to validate the scanned data
  //   RegExp exp = RegExp(r"VRFOC23");
  //   return exp.hasMatch(qrText!);
  // }

  void scanButtonPressed() {
    setState(() {
      onclickbutton = true;
      print("onclickbutton $onclickbutton");
    });
  }

  // void fetchData() async {
  //   Response response;
  //   setState(() {
  //     var loadingStatus = "loading";
  //   });
  //   try {
  //     response = await Dio().get(
  //         "https://registervr-2c445-default-rtdb.firebaseio.com/scannedUser.json");
  //     print(response);
  //     if (response.statusCode == 200) {
  //       VRScannedUserResponse vrscanneduserResponse =
  //           VRScannedUserResponse.fromJson(response.data);

  //       setState(() {
  //         vrscanneduserList = vrscanneduserResponse.vrscanneduserList;
  //       });

  //       // Assuming you have a map of VRScannedUser objects named vrscanneduserList
  //       VRScannedUser vrUser = vrscanneduserList["VRFOC230003"]!;
  //       Map<String, bool> gameList = vrUser.gameList; // get the gameList map
  //       String gameListJson =
  //           jsonEncode(gameList); // encode the map as a JSON string

  //       print("VRScannedUser GameList $gameListJson");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   fetchData();

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: const [
                Tab(text: "Most Wanted"),
                Tab(text: "Blur"),
                Tab(text: "Crash Bandicoot"),
                Tab(text: "Breakneck"),
                Tab(text: "Pubg"),
                Tab(text: "Call Of Duty Modern Warfare 4"),
                Tab(text: "Pubg"),
              ],
              // Set the onTap property to update the current tab index
              onTap: (index) {
                setState(() {
                  _currentTabIndex = index;
                  onclickbutton = false;
                });
              },
            ),
            title: Text('Individual Game'),
          ),
          body: TabBarView(
            children: [
              // Update the condition for onclickbutton to be false when _currentTabIndex is not 0
              _currentTabIndex != 0
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
              _currentTabIndex != 1
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
              _currentTabIndex != 2
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
              _currentTabIndex != 3
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
              _currentTabIndex != 4
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
              _currentTabIndex != 5
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
              _currentTabIndex != 6
                  ? GameQRView()
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : GameQRView(),
            ],
          ),
        ),
      ),
    );
  }
}
