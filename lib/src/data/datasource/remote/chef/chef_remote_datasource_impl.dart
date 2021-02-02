import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mikipo/src/data/datasource/chef/chef_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class ChefRemoteStorageDataSourceImpl implements IChefRemoteStorageDataSource {

  static final String _CHEFS_COLLECTION= 'chefs';

  final FirebaseFirestore _firebaseFirestore;

  ChefRemoteStorageDataSourceImpl(this._firebaseFirestore);

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

}