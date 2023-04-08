class ScannedUserState {
  Map<String, bool>? gameList;

  ScannedUserState({
    required this.gameList,
  });

  // Copy constructor
  ScannedUserState.fromScannedUserState(ScannedUserState another)
      : gameList = Map<String, bool>.from(another.gameList ?? {});

  // Factory method for creating an initial state
  factory ScannedUserState.initial() {
    return ScannedUserState(
      gameList: {}, // use curly braces to create an empty map
    );
  }
}







