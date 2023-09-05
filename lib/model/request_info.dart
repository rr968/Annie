class RequestInfo {
  final int requestId;
  final int serviceId;
  final int status;
  final String serviceName;
  final String serviceNameEn;
  final String requestType;
  final String requestTypeEn;
  final String? requestNature;
  final String? requestNatureEn;
  final int floorsCount;
  final int? cityId;
  final String? rejectionReason;
  final bool editable;
  final List files;

  RequestInfo(
      {required this.requestId,
      required this.serviceId,
      required this.status,
      required this.serviceName,
      required this.serviceNameEn,
      required this.requestType,
      required this.requestTypeEn,
      required this.requestNature,
      required this.requestNatureEn,
      required this.floorsCount,
      required this.cityId,
      required this.rejectionReason,
      required this.editable,
      required this.files});
}
