
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/redux/state/project_state.dart';
import 'package:flutter_app/redux/state/public_account_state.dart';
import 'package:flutter_app/redux/state/register_state.dart';
import 'package:flutter_app/redux/state/search_action_state.dart';
import 'package:flutter_app/redux/state/search_result_state.dart';
import 'package:flutter_app/redux/state/welfare_state.dart';

import 'collection_state.dart';
import 'home_state.dart';
import 'login_state.dart';
import 'navigation_state.dart';

@immutable
class AppState {
  final LoginState loginState;
  final RegisterState registerState;
  final HomeState homeState;
  final ProjectState projectState;
  final SearchActionState searchActionState;
  final SearchResultSate searchResultSate;
  final WelfareState welfareState;
  final NavigationState navigationState;
  final PublicAccountState publicAccountState;
  final CollectionState collectionState;

  AppState(
      {this.loginState,
        this.registerState,
        this.homeState,
        this.projectState,
        this.searchActionState,
        this.searchResultSate,
        this.welfareState,
        this.navigationState,
        this.publicAccountState,
        this.collectionState});

  factory AppState.initial() {
    return AppState(
        loginState: LoginState.initial(),
        registerState: RegisterState.initial(),
        homeState: HomeState.initial(),
        projectState: ProjectState.initial(),
        searchActionState: SearchActionState.initial(),
        searchResultSate: SearchResultSate.initial(),
        welfareState: WelfareState.initial(),
        navigationState: NavigationState.initial(),
        publicAccountState: PublicAccountState.initial(),
        collectionState: CollectionState.initial());
  }
}
