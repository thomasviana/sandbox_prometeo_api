class MovementsReqParams {
  final String accountNumber;
  final String authKey;
  final String currency;
  final String dateStart; // DD/MM/YYYY
  final String dateEnd; // DD/MM/YYYY

  MovementsReqParams({
    required this.accountNumber,
    required this.authKey,
    required this.currency,
    required this.dateStart,
    required this.dateEnd,
  });
}
