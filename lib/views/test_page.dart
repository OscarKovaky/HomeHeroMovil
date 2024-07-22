import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/app_state.dart';
import '../redux/actions/auth_actions.dart';
import 'login_page.dart';
class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _TestPageViewModel>(
      converter: (store) {
        return _TestPageViewModel(
          logOut: () {
            store.dispatch(LogOutAction());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        );
      },
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Test Page'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: viewModel.logOut,
              ),
            ],
          ),
          body: Center(
            child: Text('This is the test page!'),
          ),
        );
      },
    );
  }
}

class _TestPageViewModel {
  final VoidCallback logOut;

  _TestPageViewModel({
    required this.logOut,
  });
}
