
class UserState {
  String selectedgametype = "";
  List<String> selectedGames = [];
  String selectedUsername = "";

  UserState({
    required this.selectedgametype,
    required this.selectedGames,
    required this.selectedUsername,
  });

  UserState.fromUserState(UserState another) {
    selectedgametype = another.selectedgametype;
    selectedGames = another.selectedGames;
    selectedUsername = another.selectedUsername;

  }

  factory UserState.initial() {
    return UserState(
      selectedgametype: "",
      selectedGames: [],
      selectedUsername: "",
    );
  }
}
