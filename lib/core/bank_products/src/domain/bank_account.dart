class BankAccount {
  final String id;
  final String name;
  final String number;
  final String currency;
  final int balance;

  BankAccount({
    required this.id,
    required this.name,
    required this.number,
    required this.currency,
    required this.balance,
  });

  BankAccount copyWith({
    String? id,
    String? name,
    String? number,
    String? currency,
    int? balance,
  }) {
    return BankAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
    );
  }

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      currency: map['currency'] ?? '',
      balance: map['balance'] ?? '',
    );
  }
}
