import 'package:flutter_app/redux/reducer/app_reducer.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<AppState> createStore() {
  return Store(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
}
