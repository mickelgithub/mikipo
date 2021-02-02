import 'package:mikipo/src/domain/entities/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entities/organization/section.dart';

class OrganizationInfo {

  final List<Section> sections;
  final List<HeighProfile> heighProfiles;

  OrganizationInfo({this.sections, this.heighProfiles});

}