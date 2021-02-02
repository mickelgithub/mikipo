import 'package:mikipo/src/data/datasource/remote/organization/organization_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/organization/organization_info.dart';
import 'package:mikipo/src/domain/repository/organization/organization_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class OrganizationRepositoryImpl implements IOrganizationRepository {

  final logger= getLogger((OrganizationRepositoryImpl).toString());

  final IOrganizationRemoteDatasource _organizationRemoteDatasource;

  OrganizationRepositoryImpl(this._organizationRemoteDatasource);

  @override
  Future<OrganizationInfo> getOrganizationInfo() async {
    OrganizationInfo organizationInfo;
    try {
      organizationInfo= await _organizationRemoteDatasource.getOrganizationInfo();
    } finally {
      //TODO
    }
    return organizationInfo;
  }



}