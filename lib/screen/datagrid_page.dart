import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
        String gameListJson = vrUser.gameList
            .toString(); // convert the gameList map to a JSON string
        gameListJson = gameListJson.replaceAll(" ", "\"").substring(
            1,
            gameListJson.length -
                1); // replace spaces with double quotes and remove the surrounding curly braces
        
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
    return Container(
      child: Text("data grid"),
    );
  }
}
