class Request {
  final int id;
  final int serviceId;
  final String serviceName;
  final String serviceNameEn;
  final int status;
  final String statusMsg;
  final String statusMsgEn;
  final int currentStep;
  final String? selectedCompany;
  final String? selectedOfferPrice;
  final String? remainingDays;

  Request({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.serviceNameEn,
    required this.status,
    required this.statusMsg,
    required this.statusMsgEn,
    required this.currentStep,
    required this.selectedCompany,
    required this.selectedOfferPrice,
    this.remainingDays,
  });
}
