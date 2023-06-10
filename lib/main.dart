import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vr_app_2022/screen/qr-page.dart';
import 'package:vr_app_2022/screen/sign_in_page.dart';
import 'package:vr_app_2022/screen/sign_up_page.dart';
import 'package:vr_app_2022/service/auth_service.dart';
import 'components/bottom_navigation.dart';
import 'store/application_state.dart';
import 'store/root_reducer.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Store<ApplicationState> _store = Store<ApplicationState>(rootReducer,
      initialState: ApplicationState.initial());
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/qr': (context) => const QRViewPage(),
          '/signin': (context) => SignInPage(),
          // '/signup': (context) => SignUpPage(),
        },
        title: MyApp._title,
        home: Builder(
          builder: (BuildContext context) {
            return AuthService().handleAuthState();
          },
        ),
      ),
    );
  }
}
