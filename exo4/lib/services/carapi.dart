user1class StatusErrorException {
  final int statusCode;
  const StatusErrorException(this.statusCode);
}

abstract class CarAPI {
  static const apiServer = 'extranet.esimed.fr:3333';
  static const apiUrl = '';
}