import 'package:dartz/dartz.dart';
import 'package:mikipo/src/data/datasource/remote/organization/organization_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/organization/organization_info.dart';
import 'package:mikipo/src/domain/repository/organization/organization_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class OrganizationRepositoryImpl implements IOrganizationRepository {

  static const String _UNAVAILABLE = 'unavailable';

  static final _logger= getLogger((OrganizationRepositoryImpl).toString());

  final IOrganizationRemoteDatasource _organizationRemoteDatasource;

  OrganizationRepositoryImpl(this._organizationRemoteDatasource);

  @override
  Future<Either<Failure,OrganizationInfo>> getOrganizationInfo() async {
    OrganizationInfo organizationInfo;
    try {
      return right(await _organizationRemoteDatasource.getOrganizationInfo());
    } on firestore.FirebaseException catch (e) {
      _logger.e(e);
      if (e.code == _UNAVAILABLE) {
        return left(InternetNotAvailable());
      } else {
        return left(ServerError());
      }
    }
  }



}