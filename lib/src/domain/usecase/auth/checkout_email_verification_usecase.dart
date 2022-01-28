import 'package:dartz/dartz.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class CheckoutEmailVerificationUseCase {

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final INotificationRepository _notificationRepository;

  CheckoutEmailVerificationUseCase(this._authRepository, this._userRepository, this._notificationRepository);

  Future<Either<Failure,bool>> call(User user) async {
    final isEmailVerifiedResult= await _authRepository.isEmailVerified;
    return isEmailVerifiedResult.fold((l) {
      return left(l);
    }, (isEmailVerified) async {
      if (isEmailVerified) {
        await _userRepository.updateUserEmailVerified(user.id);
        if (!user.isDirector()) {
          await _notificationRepository.sendNewMemberNotificationToBoss(user);
        }
      }
      return right(isEmailVerified);
    });
  }

}