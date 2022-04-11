class CreditCard {
  final String id;
  final String name;
  final String number;
  final String dueDate;
  final String closeDate;
  final double balanceLocal;
  final double balanceDollar;

  CreditCard({
    required this.id,
    required this.name,
    required this.number,
    required this.dueDate,
    required this.closeDate,
    required this.balanceLocal,
    required this.balanceDollar,
  });

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      dueDate: map['due_date'] ?? '',
      closeDate: map['close_date'] ?? '',
      balanceLocal: map['balance_local']?.toDouble() ?? 0.0,
      balanceDollar: map['balance_dollar']?.toDouble() ?? 0.0,
    );
  }
}
