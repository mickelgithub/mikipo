import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mikipo/src/data/datasource/remote/team/team_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class TeamRemoteDatasourceImpl implements ITeamRemoteDatasource {

  static final _logger= getLogger((TeamRemoteDatasourceImpl).toString());

  static const String _USERS_COLLECTION= 'users';

  final FirebaseFirestore _firebaseFirestore;

  TeamRemoteDatasourceImpl(this._firebaseFirestore);

  @override
  Future<List<User>> getTeamMembers(User user) async {
    _logger.d('get team members for the user ${user.email}');
    Query query= null;
    if (user.isDirector()) {
      query= _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.USER_ID}', isNotEqualTo: user.id)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.HEIGH_PROFILE}.${HeighProfile.ID}', isEqualTo: HeighProfile.AREA_CHEF)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true);
    } else if (user.isAreaChef()) {
      query = _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.USER_ID}', isNotEqualTo: user.id)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id)
          .where('${User.HEIGH_PROFILE}.${HeighProfile.ID}',
          isEqualTo: HeighProfile.DEPARTMENT_CHEF)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true);
    } else if (user.isDepartmentChef()) {
      query= _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.USER_ID}', isNotEqualTo: user.id)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id)
          .where('${User.DEPARTMENT}.${Department.ID}', isEqualTo: user.department.id)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true);
    } else {
      query= _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.USER_ID}', isNotEqualTo: user.id)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id)
          .where('${User.DEPARTMENT}.${Department.ID}', isEqualTo: user.department.id)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true)
          .where('${User.IS_ACCEPTED_BY_CHEF}', isEqualTo: true);
    }
    final result= await query.get();
    List<User> members= [];
    if (result.size> 0) {
      result.docs.forEach((userDocSnapshot) {
        members.add(User.fromMap(userDocSnapshot.data()));
      });
    }
    return members;
  }

}