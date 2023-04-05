import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/scanpage/scan_button_page.dart';
import '../models/vr_scanned_user_model.dart';

class DataGridView extends StatefulWidget {
  const DataGridView({super.key});

  @override
  State<DataGridView> createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  Map<String, VRScannedUser> vrscanneduserList = {};

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

  @override
  void didChangeDependencies() {
    fetchData();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true, // Set this to true
              tabs: [
                Tab(text: "Most Wanted"),
                Tab(text: "Blur"),
                Tab(text: "Crash Bandicoot"),
                Tab(text: "Breakneck"),
                Tab(text: "Pubg"),
                Tab(text: "Call Of Duty Modern Warfare 4"),
                Tab(text: "Pubg"),
              ],
            ),
            title: const Text('Individual Game'),
          ),
          body: TabBarView(
            children: [
              SecondScreen(),
              SecondScreen(),
              SecondScreen(),
              SecondScreen(),
              SecondScreen(),
              SecondScreen(),
              SecondScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
