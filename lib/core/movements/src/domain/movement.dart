import 'dart:convert';

class Movement {
  final String id;
  final String detail;
  final String date;
  final double amount;
  final String reference;

  Movement({
    required this.id,
    required this.detail,
    required this.date,
    required this.amount,
    required this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'detail': detail,
      'date': date,
      'amount': amount,
      'reference': reference,
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      id: map['id'] ?? '',
      detail: map['detail'] ?? '',
      date: map['date'] ?? '',
      amount: (map['credit'].toString()).isEmpty
          ? map['debit'] ?? 0.0
          : map['credit'] ?? 0.0,
      reference: map['reference'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movement.fromJson(String source) =>
      Movement.fromMap(json.decode(source));
}
