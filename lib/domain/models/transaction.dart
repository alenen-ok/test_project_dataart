import 'package:test_project/core/constants/enums.dart';

class Transaction {
  final DateTime date;
  final int amount;
  final int commission;
  final int result;
  final int number;
  final TransactionType type;

  Transaction({
    required this.date,
    required this.amount,
    required this.commission,
    required this.result,
    required this.number,
    required this.type,
  });
}
