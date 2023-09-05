class Request {
  final int id;
  final String serviceName;
  final String serviceNameEn;
  final int status;
  final String statusMsg;
  final String statusMsgEn;

  Request(
      {required this.id,
      required this.serviceName,
      required this.serviceNameEn,
      required this.status,
      required this.statusMsg,
      required this.statusMsgEn});
}
