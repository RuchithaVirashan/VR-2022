import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_redux/flutter_redux.dart';

class UserService {
  final userDet = FirebaseAuth.instance.currentUser;

  getUserData() {
    User user = userDet as User;
    List<UserInfo> userinfo = user.providerData;
    final uid = userinfo[0].uid;
    if (kDebugMode) {
      print("user info $uid");
    }
    return uid;
  }

  Future addUserDetails(String name, String email) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('users').child(name);

    Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'userId': email,
    };

    reference.set(userData);
  }
}
