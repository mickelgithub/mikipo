import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';

part 'organization_info.freezed.dart';

@freezed
abstract class OrganizationInfo with _$OrganizationInfo {

  const factory OrganizationInfo({List<Section> sections, List<HeighProfile> heighProfiles})= _OrganizationInfo;

}