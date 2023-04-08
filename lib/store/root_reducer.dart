import 'package:vr_app_2022/store/scanneduser/scanneduser_reducer.dart';
import 'package:vr_app_2022/store/vruser/vruser_reducer.dart';

import 'application_state.dart';

ApplicationState rootReducer(ApplicationState state, action) {
  return ApplicationState(
      userState: userReducer(state.userState, action),
      scanneduserstate: scannedUserReducer(state.scanneduserstate, action));
}
