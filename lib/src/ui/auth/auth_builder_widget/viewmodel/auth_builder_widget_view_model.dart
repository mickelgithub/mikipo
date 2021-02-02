import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/usecase/auth/get_user_stream_usecase.dart';

class AuthBuilderWidgetViewModel {

  final GetUserStreamUseCase _getUserStreamUseCase;

  AuthBuilderWidgetViewModel(this._getUserStreamUseCase);

  Stream<User> get user => _getUserStreamUseCase();
}