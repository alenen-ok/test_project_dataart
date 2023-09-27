import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/core/services/navigation_service.dart';
import 'package:test_project/domain/actions/transactions_actions.dart';
import 'package:test_project/domain/models/transaction.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/core/constants/colors.dart';
import 'package:test_project/internal/dependencies/locator.dart';
import 'package:test_project/presentation/widgets/buttons.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  final NavigationService _navigationService = injector<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final int index = (ModalRoute.of(context)!.settings.arguments as Map)["index"];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Детали транзакции'),
          backgroundColor: AppColors.deepBlue,
        ),
        body: StoreConnector<AppState, _ViewModel>(
            converter: (Store<AppState> store) => _ViewModel.fromStore(store),
            builder: (BuildContext context, _ViewModel vm) {
              final item = vm.transactions[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Дата транзакции: ${item.date}'),
                    Text('Сумма транзакции: ${item.amount} руб.'),
                    Text('Комиссия транзакции: ${item.commission} руб.'),
                    Text('Итого: ${item.result} руб.'),
                    Text('Номер транзакции: ${item.number}'),
                    Text('Тип транзакции: ${item.type.name}'),
                    DefaultFilledButton(
                      label: 'Удалить транзакцию',
                      onTap: () => vm.onRemoveTransaction.call(
                        index,
                        _navigationService.goBack,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class _ViewModel {
  final List<Transaction> transactions;
  final Function(int, VoidCallback) onRemoveTransaction;

  _ViewModel({required this.transactions, required this.onRemoveTransaction});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        transactions: store.state.transactionsState.transactions,
        onRemoveTransaction: (index, onComplete) {
          Completer completer = Completer();
          store.dispatch(removeTransaction(index, completer));
          completer.future.then((value) {
            if (completer.isCompleted) {
              onComplete.call();
            }
          });
        });
  }
}
