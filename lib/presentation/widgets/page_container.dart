import 'package:flutter/material.dart';
import 'package:test_project/core/constants/enums.dart';
import 'package:test_project/presentation/views/statistics_view.dart';
import 'package:test_project/presentation/views/transactions_view.dart';

class PageContainer extends StatelessWidget {
  const PageContainer(this.tab, {super.key});

  final MainTab tab;

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case MainTab.transactions:
        return TransactionsView();
      case MainTab.statistics:
        return const StatisticsView();
    }
  }
}
