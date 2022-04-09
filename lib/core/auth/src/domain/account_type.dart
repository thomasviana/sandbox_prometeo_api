import 'dart:convert';

class AccountType {
  final String name;
  final String labelEs;
  final String labelEn;

  AccountType({
    required this.name,
    required this.labelEs,
    required this.labelEn,
  });

  AccountType copyWith({
    String? name,
    String? labelEs,
    String? labelEn,
  }) {
    return AccountType(
      name: name ?? this.name,
      labelEs: labelEs ?? this.labelEs,
      labelEn: labelEn ?? this.labelEn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'label_es': labelEs,
      'label_en': labelEn,
    };
  }

  factory AccountType.fromMap(Map<String, dynamic> map) {
    return AccountType(
      name: map['name'] ?? '',
      labelEs: map['label_es'] ?? '',
      labelEn: map['label_en'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountType.fromJson(String source) =>
      AccountType.fromMap(json.decode(source));
}
