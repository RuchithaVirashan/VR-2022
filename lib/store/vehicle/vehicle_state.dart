
class UserState {
  String selectedgametype = "";
  List<String> selectedGames = [];
  String selectedUsername = "";
  String selectedUuId = '';

  UserState({
    required this.selectedgametype,
    required this.selectedGames,
    required this.selectedUsername,
    required this.selectedUuId,
  });

  UserState.fromUserState(UserState another) {
    selectedgametype = another.selectedgametype;
    selectedGames = another.selectedGames;
    selectedUsername = another.selectedUsername;
    selectedUuId = another.selectedUuId;
  }

  factory UserState.initial() {
    return UserState(
      selectedgametype: "",
      selectedGames: [],
      selectedUsername: "",
      selectedUuId: '',
    );
  }
}
