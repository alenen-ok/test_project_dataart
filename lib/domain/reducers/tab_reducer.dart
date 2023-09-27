import 'package:test_project/core/constants/enums.dart';
import 'package:test_project/domain/states/tab_state.dart';
import 'package:test_project/domain/actions/tab_actions.dart';

TabState tabReducer(TabState tabState, dynamic action) {
  if (action is! TabActions) {
    return tabState;
  }
  TabState newState = tabState;
  switch (action) {
    case TabActions.goToTransactions:
      newState.currentTab = MainTab.transactions;
      return newState;
    case TabActions.goToStatistics:
      newState.currentTab = MainTab.statistics;
      return newState;
  }
}
