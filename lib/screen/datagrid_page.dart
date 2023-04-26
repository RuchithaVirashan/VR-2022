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

  void scanButtonPressed() {
    setState(() {
      onclickbutton = true;
      print("onclickbutton $onclickbutton");
    });
  }

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
                Tab(text: "Hill Climb"),
                Tab(text: "Call Of Duty Modern Warfare 4"),
                Tab(text: "PubG"),
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
                  ? const GameQRView(
                      tabname: "Most Wanted",
                    )
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(
                          tabname: "Most Wanted",
                        ),
              _currentTabIndex != 1
                  ? const GameQRView(tabname: "Blur")
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(tabname: "Blur"),
              _currentTabIndex != 2
                  ? const GameQRView(
                      tabname: "Crash Bandicoot",
                    )
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(
                          tabname: "Crash Bandicoot",
                        ),
              _currentTabIndex != 3
                  ? const GameQRView(
                      tabname: "Breakneck",
                    )
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(
                          tabname: "Breakneck",
                        ),
              _currentTabIndex != 4
                  ? const GameQRView(
                      tabname: "Hill Climb",
                    )
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(
                          tabname: "Hill Climb",
                        ),
              _currentTabIndex != 5
                  ? const GameQRView(
                      tabname: "Call Of Duty Modern Warfare 4",
                    )
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(
                          tabname: "Call Of Duty Modern Warfare 4",
                        ),
              _currentTabIndex != 6
                  ? const GameQRView(
                      tabname: "PubG",
                    )
                  : onclickbutton == false
                      ? SecondScreen(pressedbutton: scanButtonPressed)
                      : const GameQRView(
                          tabname: "PubG",
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
