import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mikipo/src/domain/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/organization/organization_info.dart';
import 'package:mikipo/src/domain/organization/section.dart';
import 'package:mikipo/src/framework/datasource/remote/organization/organization_remote_datasource.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';



class OrganizationRemoteDatasourceImpl implements IOrganizationRemoteDatasource {

  static const String _ID= 'id';
  static const String _NAME= 'name';
  static const String _ICON= 'icon';
  static const String _AREAS= 'areas';
  static const String _LEVEL= 'level';
  static const String _ORGANIZATION_COLLECTION = 'tables';
  static const String _SECTIONS= 'sections';
  static const String _HEIGH_PROFILES= 'heigh_profiles';

  final logger= getLogger('OrganizationRemoteDatasourceImpl');

  final FirebaseFirestore _firebaseFirestore;

  OrganizationRemoteDatasourceImpl(this._firebaseFirestore);

  @override
  Future<OrganizationInfo> getOrganizationInfo() async {
    logger.d('Vamos a traer la info de la organization!!!!!!!!!!!!!!!!!!!!!!!!');
    List<Section> sectionsResult = [];
    List<HeighProfile> heighProfilesResult = [];
    Query query = _firebaseFirestore.collection(_ORGANIZATION_COLLECTION);
    try {
      await query.get().then((querySnapshot) async {
        List<dynamic> sections = querySnapshot.docs[0].data()[_SECTIONS];
        List<dynamic> heighProfiles = querySnapshot.docs[0].data()[_HEIGH_PROFILES];
        sections.forEach((element) {
          Section section = Section.fromMap({
            _ID: element[_ID],
            _NAME: element[_NAME],
            _ICON: element[_ICON],
            _AREAS: element[_AREAS]
          });
          sectionsResult.add(section);
        });
        heighProfiles.forEach((element) {
          HeighProfile heighProfile= HeighProfile.fromMap({
            _ID: element[_ID],
            _NAME: element[_NAME],
            _LEVEL: element[_LEVEL]
          });
          heighProfilesResult.add(heighProfile);
        });
      });
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        //el usuario no tiene permisos...
      }
    } on Exception catch (ee) {
      print('error');
    }
    return OrganizationInfo(sections: sectionsResult, heighProfiles: heighProfilesResult);
  }
}
