import 'package:vr_app_2022/store/scanneduser/scanneduser_action.dart';
import 'package:vr_app_2022/store/scanneduser/scanneduser_state.dart';

ScannedUserState scannedUserReducer(
    ScannedUserState prevState, dynamic action) {
  ScannedUserState newState = ScannedUserState.fromScannedUserState(prevState);

  if (action is AssignScannedUserGames) {
    newState.gameList = Map.from(action.gameList);
    newState.uuId = action.uuId;
    newState.username = action.username;
  }

  return newState;
}
