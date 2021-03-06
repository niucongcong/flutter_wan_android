
import 'package:flutter_app/data/login_result.dart';
import 'package:flutter_app/redux/actions/login_action.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final int type; // 0-login, 1-register
  final bool isLoading;
  final int loginStatus;
  final String errorMessage;
  final LoginData loginData;

  final Function(String, String) login;

  LoginViewModel(
      {this.type, this.isLoading, this.loginStatus, this.errorMessage, this.loginData, this.login});

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      type: store.state.loginState.type,
      isLoading: store.state.loginState.isLoading,
      loginStatus: store.state.loginState.loginStatus,
      errorMessage: store.state.loginState.errorMessage,
      loginData: store.state.loginState.loginData,
      login: (String account, String password) {
        store.dispatch(startLogin(account, password));
      }
    );
  }
}
