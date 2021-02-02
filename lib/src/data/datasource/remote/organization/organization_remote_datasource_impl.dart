import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mikipo/src/data/datasource/remote/organization/organization_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/organization_info.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';



class OrganizationRemoteDatasourceImpl implements IOrganizationRemoteDatasource {

  static const String _ORGANIZATION_COLLECTION = 'tables';
  static const String _SECTIONS_COLLECTION= 'sections';
  static const String _HEIGH_PROFILES_COLLECTION= 'heigh_profiles';

  static final _logger= getLogger((OrganizationRemoteDatasourceImpl).toString());

  final FirebaseFirestore _firebaseFirestore;

  OrganizationRemoteDatasourceImpl(this._firebaseFirestore);

  @override
  Future<OrganizationInfo> getOrganizationInfo() async {
    _logger.d('Vamos a traer la info de la organization!!!!!!!!!!!!!!!!!!!!!!!!');
    List<Section> sectionsResult = [];
    List<HeighProfile> heighProfilesResult = [];
    Query query = _firebaseFirestore.collection(_ORGANIZATION_COLLECTION);
    try {
      await query.get().then((querySnapshot) async {
        List<dynamic> sections = querySnapshot.docs[0].data()[_SECTIONS_COLLECTION];
        List<dynamic> heighProfiles = querySnapshot.docs[0].data()[_HEIGH_PROFILES_COLLECTION];
        sections.forEach((element) {
          Section section = Section.fromMap({
            Section.ID: element[Section.ID],
            Section.NAME: element[Section.NAME],
            Section.ICON: element[Section.ICON],
            Section.AREAS: element[Section.AREAS]
          });
          sectionsResult.add(section);
        });
        heighProfiles.forEach((element) {
          HeighProfile heighProfile= HeighProfile.fromMap({
            HeighProfile.ID: element[HeighProfile.ID],
            HeighProfile.NAME: element[HeighProfile.NAME],
            HeighProfile.LEVEL: element[HeighProfile.LEVEL]
          });
          heighProfilesResult.add(heighProfile);
        });
      });
    } on FirebaseException catch (e) {
      _logger.e(e);
      if (e.code == 'permission-denied') {
        //el usuario no tiene permisos...
      }
    } on Exception catch (ee) {
      _logger.e(ee);
    }
    return OrganizationInfo(sections: sectionsResult, heighProfiles: heighProfilesResult);
  }
}
