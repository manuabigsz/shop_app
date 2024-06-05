class HtttpExceptionn implements Exception {
  final String msg;
  final int statusCode;

  HtttpExceptionn({
    required this.msg,
    required this.statusCode,
  });

  @override
  String toString() {
    return msg;
  }
}
