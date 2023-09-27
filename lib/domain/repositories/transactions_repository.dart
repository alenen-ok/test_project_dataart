import 'package:test_project/domain/models/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getTransactions();
}
