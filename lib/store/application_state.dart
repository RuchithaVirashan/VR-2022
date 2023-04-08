import 'package:vr_app_2022/store/scanneduser/scanneduser_state.dart';
import 'package:vr_app_2022/store/vruser/vruser_state.dart';

class ApplicationState {
  final UserState userState;
  final ScannedUserState scanneduserstate;

  ApplicationState({required this.scanneduserstate, required this.userState});

  factory ApplicationState.initial() {
    return ApplicationState(
        userState: UserState.initial(),
        scanneduserstate: ScannedUserState.initial());
  }
}
