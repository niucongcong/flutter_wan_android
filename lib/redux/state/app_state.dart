
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/redux/state/project_state.dart';
import 'package:flutter_app/redux/state/public_account_state.dart';

import 'collection_state.dart';
import 'home_state.dart';
import 'login_state.dart';

@immutable
class AppState {
  final LoginState loginState;
  final HomeState homeState;
  final ProjectState projectState;
  final PublicAccountState publicAccountState;
  final CollectionState collectionState;

  AppState(
      {this.loginState,
        this.homeState,
        this.projectState,
        this.publicAccountState,
        this.collectionState});

  factory AppState.initial() {
    print("AppState.initial");
    CollectionState collectionState=CollectionState.initial();
    if(collectionState.isLoading){
      print("isLoading");
    }else{
      print("endLoading");
    }
    return AppState(
        loginState: LoginState.initial(),
        homeState: HomeState.initial(),
        projectState: ProjectState.initial(),
        publicAccountState: PublicAccountState.initial(),
        collectionState: collectionState);
  }
}
