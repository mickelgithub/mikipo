import 'package:mikipo/src/domain/entities/organization/organization_info.dart';

abstract class IOrganizationRepository {

  Future<OrganizationInfo> getOrganizationInfo();

}