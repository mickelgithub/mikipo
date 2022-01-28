import 'package:dartz/dartz.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/organization/organization_info.dart';
import 'package:mikipo/src/domain/repository/organization/organization_repository.dart';

class GetOrganizationInfoUseCase {

  final IOrganizationRepository _organizationRepository;

  GetOrganizationInfoUseCase(this._organizationRepository);

  Future<Either<Failure,OrganizationInfo>> call() => _organizationRepository.getOrganizationInfo();
}