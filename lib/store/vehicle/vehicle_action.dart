import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:vr_app_2022/models/vr_user_model.dart';
import '../application_state.dart';

class AssignUser {
  final String gametype;

  AssignUser({
    required this.gametype,
  });
}

class AssignGames {
 final List<String> gamesList;
 final String userName;
 final String uuId;
 
 AssignGames({
  required this.gamesList,
  required this.userName,
  required this.uuId,
 });
}




