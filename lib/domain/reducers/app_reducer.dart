import 'package:test_project/domain/reducers/login_reducer.dart';
import 'package:test_project/domain/reducers/tab_reducer.dart';
import 'package:test_project/domain/reducers/transactions_reducer.dart';
import 'package:test_project/domain/states/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    tabState: tabReducer(state.tabState, action),
    loginState: loginReducer(state.loginState, action),
    transactionsState: transactionsReducer(state.transactionsState, action),
  );
}
