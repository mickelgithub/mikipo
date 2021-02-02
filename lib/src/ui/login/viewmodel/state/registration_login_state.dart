import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

@immutable
abstract class RegistrationLoginState {}

class RegistrationLoginStateOk extends RegistrationLoginState {}

class RegistrationLoginStateError extends RegistrationLoginState {

  static const String _EMAIL_ALREADY_IN_USE= 'La cuenta ya existe.';
  static const String _INTERNET_NOT_AVAILABLE= 'No hay conexion a internet.';
  static const String _UNKNOWN_ERROR= 'Hubo algun error con el servidor.';
  static const String _TOO_MANY_LOGIN_REQUEST= 'Demasiadas peticiones de login.';
  static const String _WRONG_PASSWORD= 'Credenciales inválidas';

  final String message;

  RegistrationLoginStateError(Failure failure): message=_getMessage(failure);

  static String _getMessage(Failure failure) {
    if (failure is EmailAlreadyInUse) {
      return _EMAIL_ALREADY_IN_USE;
    } else if (failure is InternetNotAvailable) {
      return _INTERNET_NOT_AVAILABLE;
    } else if (failure is TooManyLoginRequest) {
      return _TOO_MANY_LOGIN_REQUEST;
    } else if (failure is WrongPasswordOnLogin || failure is UserNotFoundOnLogin) {
      return _WRONG_PASSWORD;
    } else if (failure is ChefAlreadyExists) {
      ChefAlreadyExists chefAlreadyExistsFailure= failure as ChefAlreadyExists;
      if (chefAlreadyExistsFailure.user.isDirector()) {
        return 'Ya existe un director para ${chefAlreadyExistsFailure.user.section.name}';
      } else if (chefAlreadyExistsFailure.user.isAreaChef()) {
        return 'Ya existe un jefe de area para ${chefAlreadyExistsFailure.user.area.name}';
      } else {
        return 'Ya existe un jefe de depart para ${chefAlreadyExistsFailure.user.department.name}';
      }
    } else {
      return _UNKNOWN_ERROR;
    }
  }

}
