import 'dart:async';

import 'package:email_validator/email_validator.dart';

class Validators {

  static const String EMAIL_ERROR = 'Email incorrecto';
  static const String PASS_ERROR = 'Longitud minima 6 posiciones';
  static const String PASS_NOT_MATCH = 'No coinciden las contraseñas';

  final validateEmail= StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink) {
      if (EmailValidator.validate(email)) {
        sink.add(email);
      } else {
        sink.addError(EMAIL_ERROR);
      }
    }
  );

  final validatePass= StreamTransformer<String,String>.fromHandlers(
      handleData: (pass, sink) {
        if (pass.length>= 6) {
          sink.add(pass);
        } else {
          sink.addError(PASS_ERROR);
        }
      }
  );
}