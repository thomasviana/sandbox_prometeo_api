class MovementsReqParams {
  final String productType;
  final String productNumber;
  final String authKey;
  final String currency;
  final String dateStart; // DD/MM/YYYY
  final String dateEnd; // DD/MM/YYYY

  MovementsReqParams({
    required this.productType,
    required this.productNumber,
    required this.authKey,
    required this.currency,
    required this.dateStart,
    required this.dateEnd,
  });
}
