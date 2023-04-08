class ScannedUserState {
  Map<String, bool>? gameList;
   String uuId ='';

  ScannedUserState({
    required this.gameList,
    required this.uuId,
  });

  // Copy constructor
  ScannedUserState.fromScannedUserState(ScannedUserState another){
      gameList = Map<String, bool>.from(another.gameList ?? {});
      uuId = another.uuId;
      }
      


  // Factory method for creating an initial state
  factory ScannedUserState.initial() {
    return ScannedUserState(
      gameList: {}, 
      uuId: "",// use curly braces to create an empty map
    );
  }
}







