class Offer {
  final int responseId;
  final int requestId;
  final int companyId;
  final int price;
  final int duration;
  final String? companyName;

  Offer(
      {required this.responseId,
      required this.requestId,
      required this.companyId,
      required this.price,
      required this.duration,
      required this.companyName});
}
