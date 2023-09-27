import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/core/constants/colors.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/presentation/widgets/page_container.dart';
import 'package:test_project/core/constants/enums.dart';
import 'package:test_project/domain/actions/tab_actions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Транзакции'),
          backgroundColor: AppColors.deepBlue,
        ),
        body: StoreConnector<AppState, MainTab>(
          converter: (store) => store.state.tabState.currentTab,
          builder: (_, tab) => PageContainer(tab),
        ),
        bottomNavigationBar: StoreConnector<AppState, Function>(
          converter: (store) => store.dispatch,
          builder: (context, onTap) => Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap.call(TabActions.goToTransactions),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    color: AppColors.deepBlue,
                    child: const Text(
                      "Транзакции",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.white, fontSize: 20.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap.call(TabActions.goToStatistics),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    color: AppColors.deepBlue,
                    child: const Text(
                      "Статистика",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.white, fontSize: 20.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
