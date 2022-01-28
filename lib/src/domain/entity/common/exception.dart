class CustomException implements Exception {

  final CustomCause cause;

  CustomException(this.cause);
}

enum CustomCause {
  userNotFound,
  notifRecipientIncorrect,
  errorNotControlled
}