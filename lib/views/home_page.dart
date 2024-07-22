import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/app_state.dart';
import 'login_page.dart';
import 'test_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.authState.isLoggedIn,
      builder: (context, isLoggedIn) {
        return isLoggedIn ? TestPage() : LoginPage();
      },
    );
  }
}

