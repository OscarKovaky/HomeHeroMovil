import 'package:redux/redux.dart';
import 'app_state.dart';
import 'reducers/auth_reducer.dart';
import 'middlewares/logging_middleware.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
  );
}

Store<AppState> createStore() {
  return Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
    middleware: [loggingMiddleware], // Agregar middleware aquí
  );
}
