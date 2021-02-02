import 'package:mikipo/src/domain/organization/organization_info.dart';

abstract class IOrganizationRemoteDatasource {

  Future<OrganizationInfo> getOrganizationInfo();
  
}