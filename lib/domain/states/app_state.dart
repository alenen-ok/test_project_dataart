import 'tab_state.dart';
import 'transactions_state.dart';
import 'login_state.dart';

class AppState {
  final TabState tabState;
  final LoginFormState loginState;
  final TransactionsState transactionsState;

  const AppState({required this.tabState, required this.loginState, required this.transactionsState});

  factory AppState.initial() => AppState(
        tabState: TabState.initial(),
        loginState: LoginFormState.initial(),
        transactionsState: TransactionsState.initial(),
      );
}
