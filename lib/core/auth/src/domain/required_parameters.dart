import '../../domain.dart';

class RequiredParameters {
  final String name;
  final String country;
  final List<AuthField> authFields;
  final List<AccountType> accountTypes;
  final String logoUrl;

  RequiredParameters({
    required this.name,
    required this.country,
    required this.authFields,
    required this.accountTypes,
    required this.logoUrl,
  });

  RequiredParameters copyWith({
    String? name,
    String? country,
    List<AuthField>? authFields,
    List<AccountType>? accountTypes,
    String? logoUrl,
  }) {
    return RequiredParameters(
      name: name ?? this.name,
      country: country ?? this.country,
      authFields: authFields ?? this.authFields,
      accountTypes: accountTypes ?? this.accountTypes,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  factory RequiredParameters.fromJson(Map<String, dynamic> map) {
    final provider = map['provider'];
    return RequiredParameters(
      name: provider['name'] ?? '',
      country: provider['country'] ?? '',
      authFields: (provider['auth_fields'] as List)
          .map((e) => AuthField.fromMap(e))
          .toList(),
      accountTypes: ((provider['account_type'] ?? []) as List)
          .map((e) => AccountType.fromMap(e))
          .toList(),
      logoUrl: provider['logo'] ?? '',
    );
  }
}
