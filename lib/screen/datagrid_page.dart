import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vr_app_2022/components/scanpage/game_qr_scan.dart';
import 'package:vr_app_2022/models/vr_player_model.dart';
import '../components/datagrid/player.dart';
import '../components/error.dart';
import '../components/datagrid/data_grid_page.dart';
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
  var isLoading = true;
  String loadingStatus = "";
  List<String> items = [];
  Map<dynamic, VRPlayer> vrplayerList = {};
  List<Player> players = [];

  void scanButtonPressed() {
    setState(() {
      onclickbutton = true;
      print("onclickbutton $onclickbutton");
    });
  }

  @override
  void didChangeDependencies() {
    fetchPlayers();
    super.didChangeDependencies();
  }

  Future<void> refreshData() async {
    // Simulating fetching data from an API
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      fetchPlayers();
    });
  }

  void fetchPlayers() async {
    late Response<dynamic> response;
    setState(() {
      isLoading = true;
    });

    try {
      if (_currentTabIndex == 0) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/Most Wanted.json");
      } else if (_currentTabIndex == 1) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/Blur.json");
      } else if (_currentTabIndex == 2) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/Crash Bandicoot.json");
      } else if (_currentTabIndex == 3) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/Breakneck.json");
      } else if (_currentTabIndex == 4) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/Hill Climb.json");
      } else if (_currentTabIndex == 5) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/Call Of Duty Modern Warfare 4.json");
      } else if (_currentTabIndex == 6) {
        response = await Dio().get(
            "https://virtual-rival-23-default-rtdb.firebaseio.com/PubG.json");
      }

      print('response 222 ${response}');
      if (response.statusCode == 200) {
        VRPlayerResponse vrplayerResponse =
            VRPlayerResponse.fromJson(response.data);
        print("Vr player 2222 ${vrplayerResponse}");

        setState(() {
          vrplayerList = vrplayerResponse.vrscannedplayerList;
          // List<Player> getPlayerData() {
          //   List<Player> players = [];
          players.clear();

          vrplayerList.forEach((key, value) {
            if (value.marks == 0) {
              players
                  .add(Player(value.uuid, value.name, value.marks.toString()));
            }
          });

          setState(() {
            isLoading = false;
          });

          // print('playerrr $player');

          //   return players;
          // }
        });
        print("Vr player 2222 ${vrplayerList}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: TabBar(
          labelColor: const Color.fromRGBO(8, 17, 95, 1),
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
              fetchPlayers();
            });
          },
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Update the condition for onclickbutton to be false when _currentTabIndex is not 0
                        _currentTabIndex != 0
                            ? const GameQRView(
                                tabname: "Most Wanted",
                              )
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'Most Wanted',
                                    ),
                                  )
                                : const GameQRView(
                                    tabname: "Most Wanted",
                                  ),
                        _currentTabIndex != 1
                            ? const GameQRView(tabname: "Blur")
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'Blur',
                                    ),
                                  )
                                : const GameQRView(tabname: "Blur"),
                        _currentTabIndex != 2
                            ? const GameQRView(
                                tabname: "Crash Bandicoot",
                              )
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'Crash Bandicoot',
                                    ),
                                  )
                                : const GameQRView(
                                    tabname: "Crash Bandicoot",
                                  ),
                        _currentTabIndex != 3
                            ? const GameQRView(
                                tabname: "Breakneck",
                              )
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'Breakneck',
                                    ),
                                  )
                                : const GameQRView(
                                    tabname: "Breakneck",
                                  ),
                        _currentTabIndex != 4
                            ? const GameQRView(
                                tabname: "Hill Climb",
                              )
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'Hill Climb',
                                    ),
                                  )
                                : const GameQRView(
                                    tabname: "Hill Climb",
                                  ),
                        _currentTabIndex != 5
                            ? const GameQRView(
                                tabname: "Call Of Duty Modern Warfare 4",
                              )
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'Call Of Duty Modern Warfare 4',
                                    ),
                                  )
                                : const GameQRView(
                                    tabname: "Call Of Duty Modern Warfare 4",
                                  ),
                        _currentTabIndex != 6
                            ? const GameQRView(
                                tabname: "PubG",
                              )
                            : onclickbutton == false
                                ? RefreshIndicator(
                                    onRefresh: refreshData,
                                    child: DataGridPage(
                                      player: players,
                                      tabname: 'PubG',
                                    ),
                                  )
                                : const GameQRView(
                                    tabname: "PubG",
                                  ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
                      child: SecondScreen(pressedbutton: scanButtonPressed),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
