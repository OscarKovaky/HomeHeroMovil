import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/app_state.dart';
import '../redux/actions/auth_actions.dart';
import '../services/auth_service.dart';
import '../models/login.dart';
import 'verify_two_factor_page.dart';
import 'test_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _login(Function onLoggedIn, Function onRequiresTwoFactor) async {
    try {
      final loginDto = LoginDto(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final response = await _authService.login(loginDto);

      if (response['RequiresTwoFactor'] == true) {
        onRequiresTwoFactor();
      } else {
        onLoggedIn(response['Token']);
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _LoginViewModel>(
      converter: (store) {
        return _LoginViewModel(
          isLoggedIn: store.state.authState.isLoggedIn,
          logIn: (token) {
            store.dispatch(LogInAction(token: token));
          },
          requiresTwoFactor: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyTwoFactorPage(email: _emailController.text),
              ),
            );
          },
        );
      },
      builder: (context, viewModel) {
        if (viewModel.isLoggedIn) {
          // Si el usuario ya está logueado, navega a la vista de prueba
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TestPage()),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Login Page'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () => _login(viewModel.logIn, viewModel.requiresTwoFactor),
                  child: Text('Log In'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoginViewModel {
  final bool isLoggedIn;
  final Function(String token) logIn;
  final VoidCallback requiresTwoFactor;

  _LoginViewModel({
    required this.isLoggedIn,
    required this.logIn,
    required this.requiresTwoFactor,
  });
}
