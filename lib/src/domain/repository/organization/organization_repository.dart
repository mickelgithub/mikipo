import 'package:dartz/dartz.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/organization/organization_info.dart';

abstract class IOrganizationRepository {

  Future<Either<Failure, OrganizationInfo>> getOrganizationInfo();

}