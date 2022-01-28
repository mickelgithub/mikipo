import 'package:dartz/dartz.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:mikipo/src/domain/repository/chef/chef_repository.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class SendNewMemberNotificationUseCase {

  /*static const _NEW_MEMBER_NOTIFICATION_TITLE= 'Nuevo miembro';
  static const _NEW_MEMBER_NOTIFICATION_BODY= 'Se ha dado de alta un nuevo miembro';

  static final _logger = getLogger((SendNewMemberNotificationUseCase).toString());

  final IChefRepository _chefRepository;
  final INotificationRepository _notificationRepository;

  SendNewMemberNotificationUseCase(this._chefRepository, this._notificationRepository);

  Future<Either<Failure, User>> call(User user) async {

    final myBossResult= await _chefRepository.getMyChef(user);
    final area= user.area== null ? '' : user.area.name;
    final dept= user.department== null ? '' : user.department.name;
    return myBossResult.fold((l) {
      _logger.e('There was an error when retriving the boss of (${user.section.name},$area,$dept}) $l');
      return left(l);
    }, (myBoss) async {
      if (myBoss== null) {
        _logger.d('No boss found for (${user.section.name},$area,$dept)');
        return right(null);
      } else {
        _logger.d('The boss of (${user.section.name ?? ''},$area,$dept) is found and is ${myBoss.email}');
        final notifFailure= await _notificationRepository.sendNotification(_getNotification(user, myBoss));
        if (notifFailure== null) {
          //notification sent
          return right(myBoss);
        } else {
          return left(notifFailure);
        }
      }
    });

  }

  _getNotification(User member, User chef) {
    return Notification(
        to: chef,
        from: member,
        title: _NEW_MEMBER_NOTIFICATION_TITLE,
        type: NotificationType.newMember,
        body: '${_NEW_MEMBER_NOTIFICATION_BODY} ${member.email}');
  }*/
}