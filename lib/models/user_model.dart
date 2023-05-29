class UserData {
  String email;
  String game;
  String name;
  String userId;

  UserData({
    required this.email,
    required this.game,
    required this.name,
    required this.userId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      game: json['game'],
      name: json['name'],
      userId: json['userId'],
    );
  }
}

class UserDataResponse {
  final Map<String, UserData> vruserList;

  UserDataResponse({
    required this.vruserList,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    var vrUserListJson = json as Map<String, dynamic>;
    var vrscannedPlayerList = vrUserListJson.map((key, value) {
      var userData = UserData.fromJson(value);
      return MapEntry(userData.userId, userData);
    });
    return UserDataResponse(vruserList: vrscannedPlayerList);
  }
}
