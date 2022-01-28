import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';
import 'package:mikipo/src/domain/repository/state/state_repository.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class LoginUserUseCase {
  static final _logger = getLogger((LoginUserUseCase).toString());

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IStateRepository _stateRepository;
  final INotificationRepository _notificationRepository;

  LoginUserUseCase(this._authRepository, this._userRepository, this._stateRepository, this._notificationRepository);

  Future<Either<Failure, User>> call({@required String email, @required String pass}) async {
    final loginUserResult =
        await _authRepository.loginUser(email: email, pass: pass);
    return loginUserResult.fold((failure) {
      return left(failure);
    }, (userId) async {
      final userRemoteResult = await _userRepository.getUser(userId);
      return userRemoteResult.fold((error) {
        return left(error);
      }, (user) async {
        _logger.d(
            'No error when retrieving the user $userId from remote database');
        if (user.state == UserConstants.STATE_DISCHARGED) {
          _logger.d(
              'The $userId is discharged, so we have to delete local info and save en local info the user state as discharged');
          await _stateRepository.saveUserDischargedState();
          await _authRepository.logout();
          return left(UserDischarged());
        } else if (user.state == UserConstants.STATE_DISABLED) {
          return left(UserDisabled());
        } else {
          //active state
          if (!user.isEmailVerified) {
            _logger.d(
                'The user $userId does not have the email verified, so we refresh');
            final isVerifiedResult = await _authRepository.isEmailVerified;
            return isVerifiedResult.fold((l) {
              //InternetNotAvailable(),AuthServerError()
              return left(l);
            }, (isEmailVerified) async {
              if (isEmailVerified) {
                _logger.d(
                    'The user $userId does have the email verified after refreshing, so we update the remote db and we send notification to his boss');
                _userRepository.updateUserEmailVerified(userId);
                if (!user.isDirector()) {
                  await _notificationRepository.sendNewMemberNotificationToBoss(
                      user);
                }
                return right(user.copyWith(isEmailVerified: isEmailVerified));
              }
              return right(user);
            });
          }
          return right(user);
        }
      });
    });
  }


}
