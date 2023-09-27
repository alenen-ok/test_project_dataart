import 'package:test_project/domain/states/transactions_state.dart';
import 'package:test_project/domain/actions/transactions_actions.dart';

TransactionsState transactionsReducer(TransactionsState state, dynamic action) {
  if (action is! TransactionAction) {
    return state;
  }
  switch (action.type) {
    case TransactionActionType.transactionsLoaded:
      return TransactionsState(transactions: action.data, isLoaded: true, isLoading: false);
    case TransactionActionType.transactionRemoved:
      return TransactionsState(transactions: action.data, isLoaded: true, isLoading: false);
    case TransactionActionType.loadTransactions:
      return TransactionsState(transactions: state.transactions, isLoading: true);
  }
}
