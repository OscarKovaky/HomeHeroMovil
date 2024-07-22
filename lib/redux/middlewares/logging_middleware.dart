import 'package:redux/redux.dart';
import '../app_state.dart';

void loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  print('Middleware: Dispatching action $action');
  next(action);
  print('Middleware: New state ${store.state}');
}
