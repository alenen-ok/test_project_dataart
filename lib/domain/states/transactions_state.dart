import 'package:test_project/core/constants/enums.dart';

import '../models/transaction.dart';

class TransactionsState {
  List<Transaction> transactions;
  bool isLoading;
  bool isLoaded;

  TransactionsState({required this.transactions, this.isLoading = false, this.isLoaded = false});

  factory TransactionsState.initial() => TransactionsState(transactions: []);

  int get getAddedAmount => transactions.where((element) => element.type == TransactionType.add).length;

  int get getSubtractedAmount => transactions.where((element) => element.type == TransactionType.subtract).length;

  int get getTransferAmount => transactions.where((element) => element.type == TransactionType.transfer).length;
}
