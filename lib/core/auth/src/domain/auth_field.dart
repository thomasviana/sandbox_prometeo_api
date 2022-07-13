class AuthField {
  final String name;
  final String type;
  final bool interactive;
  final bool optional;
  final String labelEs;
  final String labelEn;
  final String value;

  AuthField({
    required this.name,
    required this.type,
    required this.interactive,
    required this.optional,
    required this.labelEs,
    required this.labelEn,
    this.value = '',
  });

  AuthField copyWith({
    String? name,
    String? type,
    bool? interactive,
    bool? optional,
    String? labelEs,
    String? labelEn,
    String? value,
  }) {
    return AuthField(
      name: name ?? this.name,
      type: type ?? this.type,
      interactive: interactive ?? this.interactive,
      optional: optional ?? this.optional,
      labelEs: labelEs ?? this.labelEs,
      labelEn: labelEn ?? this.labelEn,
      value: value ?? this.value,
    );
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
}
