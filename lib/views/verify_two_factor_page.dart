import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/verify_two_factor.dart';
import '../redux/actions/auth_actions.dart';
import 'test_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/app_state.dart';

class VerifyTwoFactorPage extends StatefulWidget {
  final String email;

  VerifyTwoFactorPage({required this.email});

  @override
  _VerifyTwoFactorPageState createState() => _VerifyTwoFactorPageState();
}

class _VerifyTwoFactorPageState extends State<VerifyTwoFactorPage> {
  final _codeController = TextEditingController();
  final _authService = AuthService();

  Future<void> _verify(Function(String token) onVerified) async {
    try {
      final verifyTwoFactorDto = VerifyTwoFactorDto(
        email: widget.email,
        code: _codeController.text,
        rememberMe: false, // Actualizar según sea necesario
      );
      final response = await _authService.verifyTwoFactor(verifyTwoFactorDto);

      onVerified(response['Token']);
    } catch (e) {
      // Manejar el error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _VerifyTwoFactorViewModel>(
      converter: (store) {
        return _VerifyTwoFactorViewModel(
          logIn: (token) {
            store.dispatch(LogInAction(token: token));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TestPage()),
            );
          },
        );
      },
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(title: Text('Verify Two-Factor Authentication')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(labelText: 'Verification Code'),
                ),
                ElevatedButton(
                  onPressed: () => _verify(viewModel.logIn),
                  child: Text('Verify'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VerifyTwoFactorViewModel {
  final Function(String token) logIn;

  _VerifyTwoFactorViewModel({
    required this.logIn,
  });
}
