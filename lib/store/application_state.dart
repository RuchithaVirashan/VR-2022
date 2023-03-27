
import 'package:vr_app_2022/store/vruser/vruser_state.dart';

class ApplicationState {
  final UserState userState;

  ApplicationState({required this.userState});

  factory ApplicationState.initial() {
    return ApplicationState(userState: UserState.initial());
  }
}
