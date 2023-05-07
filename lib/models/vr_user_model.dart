import 'dart:developer';

class VRUser {
  final String email;
  final String name;
  final String g1;
  final String g2;
  final String g3;
  final String g4;
  final String g5;
  final String gametype;
  final String tg1;
  final String tg2;
  final String teamname;
  final String uuid;

  VRUser({
    required this.email,
    required this.name,
    required this.g1,
    required this.g2,
    required this.g3,
    required this.g4,
    required this.g5,
    required this.tg1,
    required this.tg2,
    required this.gametype,
    required this.teamname,
    required this.uuid,
  });

  factory VRUser.fromJson(Map<String, dynamic> json) {
    return VRUser(
      email: json["Email"],
      name: json["Name"],
      g1: json["G1"],
      g2: json["G2"],
      g3: json["G3"],
      g4: json["G4"],
      g5: json["G5"],
      tg1: json["TG1"],
      tg2: json["TG2"],
      gametype: json["Game Type"],
      teamname: json["Team Name"],
      uuid: json["uuid"],
    );
  }
}

// class VRUserResponse {
//   Map<String, VRUser> vruserList;
//   VRUserResponse({
//     required this.vruserList,
//   });

//   factory VRUserResponse.fromJson(Map<String, dynamic> json) {
//     return VRUserResponse(vruserList: parseVRUser(json['Form responses 2']));
//   }

//   static Map<String, VRUser> parseVRUser(vruserListJson) {
//     var map = vruserListJson as Map<String, dynamic>;
//     Map<String, VRUser> vruserMap = {};
//     map.forEach((key, value) {
//       VRUser user = VRUser.fromJson(value);
//       vruserMap[user.uuid] = user; // assuming the user ID is unique
//     });
//     return vruserMap;
//   }
// }

class VRUserResponse {
  Map<String, VRUser> vruserList;
  VRUserResponse({
    required this.vruserList,
  });

  factory VRUserResponse.fromJson(Map<String, dynamic> json) {
    return VRUserResponse(vruserList: parseVRUser(json));
  }

  static Map<String, VRUser> parseVRUser(Map<String, dynamic> vruserListJson) {
    Map<String, VRUser> vruserMap = {};
    vruserListJson.forEach((key, value) {
      // if (key != '0') {
      // exclude the first item in the response
      // print('rererrerer $key');
      // print('rererrerer $value');
      VRUser user = VRUser.fromJson(value);
      // print(inspect(user.uuid));
      // print('aaaaaa $user');

      vruserMap[user.uuid] = user; // assuming the user ID is unique
      // }
    });
    // print('map user $vruserMap');

    return vruserMap;
  }
}
