import 'package:mikipo/src/domain/entity/organization/organization_info.dart';

abstract class IOrganizationRepository {

  Future<OrganizationInfo> getOrganizationInfo();

}