import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vr_app_2022/components/bottom_navigation.dart';
import 'package:vr_app_2022/service/userService.dart';

import '../screen/qr-page.dart';
import '../screen/sign_in_page.dart';

class AuthService {
  final UserService _userService = UserService();
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            log("sccc ${snapshot.data}");
            return const MainPage(indexPage: 0);
          } else {
            if (kDebugMode) {
              print("Loging error detect");
            }
            return const SignInPage();
          }
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
