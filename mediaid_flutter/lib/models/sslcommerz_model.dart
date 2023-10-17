class SSLCommerzResponseModel {
  final String transactionStatus;
  final String tranId;
  final double amount;
  final String currency;
  final String paymentId;

  SSLCommerzResponseModel({
    required this.transactionStatus,
    required this.tranId,
    required this.amount,
    required this.currency,
    required this.paymentId,
  });
}
