import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mikipo/src/data/datasource/remote/chef/chef_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class ChefRemoteStorageDataSourceImpl implements IChefRemoteStorageDataSource {

  static final _logger= getLogger((ChefRemoteStorageDataSourceImpl).toString());

  static const String _CHEFS_COLLECTION= 'chefs';
  static const String _USERS_COLLECTION= 'users';

  final FirebaseFirestore _firebaseFirestore;

  ChefRemoteStorageDataSourceImpl(this._firebaseFirestore);

  //TODO a lo mejor hay que cambiar este metodo, porque los usuarios tiene heiperfil
  @override
  Future<bool> isChefAlreadyExists(User user) async {
    Query query= null;
    if (user.isDepartmentChef()) {
      query= _firebaseFirestore.collection(_CHEFS_COLLECTION)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id)
          .where('${User.DEPARTMENT}.${Department.ID}', isEqualTo: user.department.id);
    } else if (user.isAreaChef()) {
      query= _firebaseFirestore.collection(_CHEFS_COLLECTION)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id);
    } else {
      query= _firebaseFirestore.collection(_CHEFS_COLLECTION)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id);
    }
    final result= await query.get(GetOptions(source: Source.server));
    if (result.size> 0) {
      return true;
    }
    return false;
  }

  @override
  Future<User> getMyChef(User user) async {
    try {
    Query query= null;
    if (user.isDepartmentChef()) {
      query= _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id)
          .where('${User.HEIGH_PROFILE}.${HeighProfile.ID}', isEqualTo: HeighProfile.AREA_CHEF)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true)
          .where('${User.IS_ACCEPTED_BY_CHEF}', isEqualTo: true)
          .where('${User.STATE}', isEqualTo: User.STATE_ACTIVE);
    } else if (user.isAreaChef()) {
      query= _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.HEIGH_PROFILE}.${HeighProfile.ID}', isEqualTo: HeighProfile.DIRECTOR)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true)
          .where('${User.STATE}', isEqualTo: User.STATE_ACTIVE);
    } else {
      //not boss
      query= _firebaseFirestore.collection(_USERS_COLLECTION)
          .where('${User.SECTION}.${Section.ID}', isEqualTo: user.section.id)
          .where('${User.AREA}.${Area.ID}', isEqualTo: user.area.id)
          .where('${User.DEPARTMENT}.${Department.ID}', isEqualTo: user.department.id)
          .where('${User.HEIGH_PROFILE}.${HeighProfile.ID}', isEqualTo: HeighProfile.DEPARTMENT_CHEF)
          .where('${User.IS_EMAIL_VERIFIED}', isEqualTo: true)
          .where('${User.IS_ACCEPTED_BY_CHEF}', isEqualTo: true)
          .where('${User.STATE}', isEqualTo: User.STATE_ACTIVE);
    }
    final result= await query.get(GetOptions(source: Source.server));
    if (result.size> 0) {
      return User.fromMap(result.docs.first.data());
    }
    } catch (e) {
      _logger.e(e);
    }
    return null;
  }

}