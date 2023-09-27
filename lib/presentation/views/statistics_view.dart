import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/core/constants/colors.dart';
import 'package:test_project/core/constants/enums.dart';
import 'package:test_project/domain/models/linear_transactions.dart';
import 'package:test_project/domain/states/app_state.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.isLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.deepBlue,
          ));
        }

        final data = [
          LinearTransactions(TransactionType.add, vm.addedAmount),
          LinearTransactions(TransactionType.subtract, vm.subtractedAmount),
          LinearTransactions(TransactionType.transfer, vm.transferAmount),
        ];
        return Center(
          child: PieChart<int>(
            [
              Series<LinearTransactions, int>(
                id: 'Transactions',
                domainFn: (LinearTransactions trs, _) => trs.type.index,
                measureFn: (LinearTransactions trs, _) => trs.transactions,
                data: data,
                labelAccessorFn: (LinearTransactions trs, _) => trs.type.name,
              ),
            ],
            animate: false,
            defaultRenderer: ArcRendererConfig(
              arcWidth: 90,
              arcRendererDecorators: [ArcLabelDecorator(labelPosition: ArcLabelPosition.inside)],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final int addedAmount;
  final int subtractedAmount;
  final int transferAmount;
  final bool isLoading;

  _ViewModel({
    required this.addedAmount,
    required this.subtractedAmount,
    required this.transferAmount,
    required this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      addedAmount: store.state.transactionsState.getAddedAmount,
      subtractedAmount: store.state.transactionsState.getSubtractedAmount,
      transferAmount: store.state.transactionsState.getTransferAmount,
      isLoading: store.state.transactionsState.isLoading,
    );
  }
}
