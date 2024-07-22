
import 'models/auth_state.dart';

class AppState {

  final AuthState authState;

  AppState({required this.authState});

  AppState.initialState()
      : 
        authState = AuthState.initialState();
}
