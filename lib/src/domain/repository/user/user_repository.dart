import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';

enum Source { local, remote }

abstract class IUserRepository {
  Future<void> saveUser(User user);
  Future<Either<Failure,User>> getUser(String userId);
  Future<void> updateUserHeighProfile(
      {@required String userId,
      @required HeighProfile heighProfile,
      @required Section section,
      Area area,
      Department department});
  Future<void> updateUserEmailVerified(String userId);
}
