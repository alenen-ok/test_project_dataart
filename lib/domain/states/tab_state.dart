import 'package:test_project/core/constants/enums.dart';

class TabState {
  MainTab currentTab;

  TabState({required this.currentTab});

  factory TabState.initial() => TabState(currentTab: MainTab.transactions);
}
