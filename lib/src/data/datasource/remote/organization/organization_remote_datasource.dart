import 'package:mikipo/src/domain/entity/organization/organization_info.dart';

abstract class IOrganizationRemoteDatasource {

  Future<OrganizationInfo> getOrganizationInfo({bool fromServer});
  
}