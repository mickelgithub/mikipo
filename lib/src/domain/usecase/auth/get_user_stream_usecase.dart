import 'file:///C:/Users/ldasal4.LINEADIRECTA/StudioProjects/mikipo/lib/src/domain/entity/setting/globalsetting/global_setting.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';

class GetGlobalSettingStreamUseCase {

  final IAuthRepository _authRepository;

  GetGlobalSettingStreamUseCase(this._authRepository);

  Stream<GlobalSetting> call() => _authRepository.globalSetting;

}