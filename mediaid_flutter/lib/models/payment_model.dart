class PaymentModel {
  final int emi;
  final String currency;
  final String totalAmount;
  final String tranId;
  final String successUrl;
  final String failUrl;
  final String cancelUrl;
  final String ipnUrl;
  final String cusName;
  final String cusEmail;
  final String cusPhone;

  PaymentModel({
    required this.emi,
    required this.currency,
    required this.totalAmount,
    required this.tranId,
    required this.successUrl,
    required this.failUrl,
    required this.cancelUrl,
    required this.ipnUrl,
    required this.cusName,
    required this.cusEmail,
    required this.cusPhone,
  });
}
