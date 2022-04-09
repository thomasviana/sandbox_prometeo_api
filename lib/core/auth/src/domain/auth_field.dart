import 'dart:convert';

class AuthField {
  final String name;
  final String type;
  final bool interactive;
  final bool optional;
  final String labelEs;
  final String labelEn;

  AuthField({
    required this.name,
    required this.type,
    required this.interactive,
    required this.optional,
    required this.labelEs,
    required this.labelEn,
  });

  AuthField copyWith({
    String? name,
    String? type,
    bool? interactive,
    bool? optional,
    String? labelEs,
    String? labelEn,
  }) {
    return AuthField(
      name: name ?? this.name,
      type: type ?? this.type,
      interactive: interactive ?? this.interactive,
      optional: optional ?? this.optional,
      labelEs: labelEs ?? this.labelEs,
      labelEn: labelEn ?? this.labelEn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'interactive': interactive,
      'optional': optional,
      'label_es': labelEs,
      'label_en': labelEn,
    };
  }

  factory AuthField.fromMap(Map<String, dynamic> map) {
    return AuthField(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      interactive: map['interactive'] ?? false,
      optional: map['optional'] ?? false,
      labelEs: map['label_es'] ?? '',
      labelEn: map['label_en'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthField.fromJson(String source) =>
      AuthField.fromMap(json.decode(source));
}
