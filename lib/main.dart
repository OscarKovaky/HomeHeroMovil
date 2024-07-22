import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redux/redux.dart';
import 'redux/store.dart';
import 'redux/app_state.dart';
import 'views/home_page.dart';

void main() async {
   await dotenv.load(fileName: ".env.${String.fromEnvironment('ENV', defaultValue: 'development')}");
  final store = createStore();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
