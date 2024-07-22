import 'package:redux/redux.dart';
import '../actions/auth_actions.dart';
import '../models/auth_state.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LogInAction>(_logIn),
  TypedReducer<AuthState, LogOutAction>(_logOut),
  TypedReducer<AuthState, CompleteMfaAction>(_completeMfa),
]);

AuthState _logIn(AuthState state, LogInAction action) {
  return AuthState(isLoggedIn: true, isMfaCompleted: state.isMfaCompleted, token: action.token);
}

AuthState _logOut(AuthState state, LogOutAction action) {
  return AuthState(isLoggedIn: false, isMfaCompleted: false, token: null);
}

AuthState _completeMfa(AuthState state, CompleteMfaAction action) {
  return AuthState(isLoggedIn: state.isLoggedIn, isMfaCompleted: true, token: state.token);
}

