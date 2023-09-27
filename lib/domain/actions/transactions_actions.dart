import 'dart:async';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:test_project/domain/models/transaction.dart';
import 'package:test_project/domain/repositories/transactions_repository.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/internal/dependencies/locator.dart';

enum TransactionActionType { loadTransactions, transactionsLoaded, transactionRemoved }

class TransactionAction {
  TransactionActionType type;
  dynamic data;

  TransactionAction({required this.type, this.data});
}

ThunkAction<AppState> getTransactions() {
  return (Store<AppState> store) async {
    final repository = injector<TransactionsRepository>();
    if (store.state.transactionsState.isLoaded) {
      store.dispatch(TransactionAction(
          type: TransactionActionType.transactionsLoaded, data: store.state.transactionsState.transactions));
      return;
    }
    store.dispatch(TransactionAction(type: TransactionActionType.loadTransactions));
    dynamic data = await repository.getTransactions();
    store.dispatch(TransactionAction(type: TransactionActionType.transactionsLoaded, data: data));
  };
}

ThunkAction<AppState> removeTransaction(int index, Completer completer) {
  return (Store<AppState> store) async {
    List<Transaction> data = store.state.transactionsState.transactions;
    data.removeAt(index);
    store.dispatch(TransactionAction(type: TransactionActionType.transactionRemoved, data: data));
    completer.complete();
  };
}
