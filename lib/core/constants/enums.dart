enum MainTab { transactions, statistics }

enum TransactionType {
  transfer('Перевод'),
  add('Пополнение'),
  subtract('Снятие');

  final String name;

  const TransactionType(this.name);
}
