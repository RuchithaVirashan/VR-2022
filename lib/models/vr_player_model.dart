import 'dart:developer' show inspect;

class VRPlayer {
  final String name;
  final String uuid;
  final int marks;

  VRPlayer({
    required this.name,
    required this.uuid,
    required this.marks,
  });

  factory VRPlayer.fromJson(Map<String, dynamic> json) {
    return VRPlayer(
      name: json["name"],
      uuid: json["uuid"],
      marks: json["marks"],
    );
  }
}

// class VRPlayerResponse {
//   Map<String, VRPlayer> vrplayerList;
//   VRPlayerResponse({
//     required this.vrplayerList,
//   });

//   factory VRPlayerResponse.fromJson(Map<String, dynamic> json) {
//     return VRPlayerResponse(vrplayerList: parseVRPlayer(json));
//   }

//   static Map<String, VRPlayer> parseVRPlayer(
//       Map<String, dynamic> vruserListJson) {
//     Map<String, VRPlayer> vrplayerMap = {};
//     vruserListJson.forEach((key, value) {
//       print('rererrerer $key');
//       print('rererrerer $value');
//       // VRPlayer user = VRPlayer.fromJson(value);
//       // print(inspect(user.uuid));

//       // vrplayerMap[user.uuid] = user; // assuming the user ID is unique
//     });

//     return vrplayerMap;
//   }
// }

class VRPlayerResponse {
  final Map<String, VRPlayer> vrscannedplayerList;

  VRPlayerResponse({
    required this.vrscannedplayerList,
  });

  factory VRPlayerResponse.fromJson(Map<String, dynamic> json) {
    var vrUserListJson = json as Map<String, dynamic>;
    var vrscannedPlayerList = vrUserListJson.map((key, value) {
      var vrScannedPlayer = VRPlayer.fromJson(value);
      return MapEntry(vrScannedPlayer.uuid, vrScannedPlayer);
    });
    return VRPlayerResponse(vrscannedplayerList: vrscannedPlayerList);
  }
}
