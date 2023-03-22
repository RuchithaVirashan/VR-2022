import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp._title,
        home: MainPage(
          indexPage: 1,
        ),
      ),
    );
  }
}
