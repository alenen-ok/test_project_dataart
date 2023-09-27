import 'package:test_project/domain/actions/login_actions.dart';
import 'package:test_project/domain/states/login_state.dart';

LoginFormState loginReducer(LoginFormState state, dynamic action) {
  if (action is! LoginFormAction) {
    return state;
  }
  switch (action.type) {
    case LoginFormActionType.loginSuccess:
      return LoginFormState(user: action.data, isFailure: false);

    case LoginFormActionType.loginFail:
      return LoginFormState(isFailure: true);
  }
}
