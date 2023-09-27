import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/core/constants/colors.dart';
import 'package:test_project/core/services/navigation_service.dart';
import 'package:test_project/domain/models/transaction.dart';
import 'package:test_project/internal/dependencies/locator.dart';
import 'package:test_project/presentation/widgets/transaction_item.dart';
import 'package:test_project/domain/actions/transactions_actions.dart';
import 'package:test_project/domain/states/app_state.dart';

class TransactionsView extends StatelessWidget {
  TransactionsView({super.key});

  final NavigationService _navigationService = injector<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        store.dispatch(getTransactions());
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.isLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.deepBlue,
          ));
        }
        return ListView.builder(
          key: const PageStorageKey<String>('transactionsKey'),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => _navigationService.navigateTo(
              "details_screen",
              args: {"index": index},
            ),
            child: TransactionItem(transaction: vm.transactions[index]),
          ),
          itemCount: vm.transactions.length,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Transaction> transactions;
  final bool isLoading;

  _ViewModel({required this.transactions, required this.isLoading});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      transactions: store.state.transactionsState.transactions,
      isLoading: store.state.transactionsState.isLoading,
    );
  }
}
