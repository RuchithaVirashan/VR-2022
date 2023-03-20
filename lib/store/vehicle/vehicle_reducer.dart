import 'package:vr_app_2022/store/vehicle/vehicle_action.dart';
import 'package:vr_app_2022/store/vehicle/vehicle_state.dart';

UserState userReducer(UserState prevState, dynamic action) {
  UserState newState = UserState.fromUserState(prevState);

  if (action is AssignUser) {
    newState.selectedgametype = action.gametype;
  }
  if (action is AssignGames) {
    newState.selectedGames = action.gamesList;
    newState.selectedUsername = action.userName;
  }

  return newState;
}
