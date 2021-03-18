import 'package:flutter_app/redux/reducer/project_reducer.dart';
import 'package:flutter_app/redux/reducer/public_account_reducer.dart';
import 'package:flutter_app/redux/reducer/register_reducer.dart';
import 'package:flutter_app/redux/reducer/search_action_reducer.dart';
import 'package:flutter_app/redux/reducer/search_result_reducer.dart';
import 'package:flutter_app/redux/reducer/welfare_reducer.dart';
import 'package:flutter_app/redux/state/app_state.dart';

import 'collection_reducer.dart';
import 'home_reducer.dart';
import 'login_reducer.dart';
import 'navigation_reducer.dart';

AppState appReducer(AppState appState, dynamic action) {
  return AppState(
      loginState: loginReducer(appState.loginState, action),
      registerState: registerReducer(appState.registerState, action),
      homeState: homeReducer(appState.homeState, action),
      projectState: projectReducer(appState.projectState, action),
      searchActionState:
      searchActionReducer(appState.searchActionState, action),
      searchResultSate: searchResultReducer(appState.searchResultSate, action),
      welfareState: welfareReducer(appState.welfareState, action),
      navigationState: navigationReducer(appState.navigationState, action),
      publicAccountState:
      publicAccountReducer(appState.publicAccountState, action),
      collectionState: collectionReducer(appState.collectionState, action));
}
