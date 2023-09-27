import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:test_project/domain/models/user.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/internal/dependencies/locator.dart';
import 'package:test_project/domain/repositories/login_repository.dart';

enum LoginFormActionType { loginSuccess, loginFail }

class LoginFormAction {
  LoginFormActionType type;
  dynamic data;

  LoginFormAction({required this.type, this.data});
}

ThunkAction<AppState> login(String userName, String password, Completer completer) {
  return (Store<AppState> store) async {
    final repository = injector<LoginRepository>();
    final User? user = await repository.login(userName, password);
    if (user == null) {
      completer.completeError("fail");
    }
    store.dispatch(
      LoginFormAction(
        type: LoginFormActionType.loginSuccess,
        data: user,
      ),
    );
    completer.complete();
  };
}
