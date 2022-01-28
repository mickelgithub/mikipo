import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mikipo/src/data/datasource/local/avatar/avatar_datasource.dart';
import 'package:mikipo/src/data/datasource/local/avatar/avatar_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/local/state/state_local_datasource.dart';
import 'package:mikipo/src/data/datasource/local/state/state_local_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/data/datasource/local/user/user_local_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/auth/auth_remote_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/remote/avatar/avatar_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/avatar/avatar_remote_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/remote/chef/chef_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/chef/chef_remote_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/remote/notification/NotificationRemoteDatasourceImpl.dart';
import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/organization/organization_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/organization/organization_remote_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/remote/team/team_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/team/team_remote_datasource_impl.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource_impl.dart';
import 'package:mikipo/src/data/repository/auth/auth_repository_impl.dart';
import 'package:mikipo/src/data/repository/avatar/avatar_repository_impl.dart';
import 'package:mikipo/src/data/repository/chef/chef_repository_impl.dart';
import 'package:mikipo/src/data/repository/notification/notification_repository_impl.dart';
import 'package:mikipo/src/data/repository/organization/organization_repository_impl.dart';
import 'package:mikipo/src/data/repository/state/state_repository_impl.dart';
import 'package:mikipo/src/data/repository/team/team_repository_impl.dart';
import 'package:mikipo/src/data/repository/user/user_repository_impl.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/domain/repository/chef/chef_repository.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';
import 'package:mikipo/src/domain/repository/organization/organization_repository.dart';
import 'package:mikipo/src/domain/repository/state/state_repository.dart';
import 'package:mikipo/src/domain/repository/team/team_repository.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';
import 'package:mikipo/src/domain/usecase/auth/checkout_email_verification_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/get_user_authentication_state_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/get_user_stream_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/login_user_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/register_user_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/update_user_profile_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/crop_image_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/delete_avatar_from_cach_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/pick_image_usecase.dart';
import 'package:mikipo/src/domain/usecase/organization/get_organization_info_usecase.dart';
import 'package:mikipo/src/domain/usecase/team/accept_deny_member_usecase.dart';
import 'package:mikipo/src/domain/usecase/team/get_team_members_usecase.dart';
import 'package:mikipo/src/domain/usecase/team/handle_accept_deny_member_notification_usecase.dart';
import 'package:mikipo/src/domain/usecase/team/send_new_member_notification_usecase.dart';
import 'package:mikipo/src/ui/auth/auth_builder_widget/viewmodel/auth_builder_widget_view_model.dart';
import 'package:mikipo/src/ui/home/viewmodel/home_view_model.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/splash/viewmodel/splash_viewmodel.dart';
import 'package:mikipo/src/ui/team/viewmodel/team_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!serviceLocator.isRegistered<SharedPreferences>()) {
    serviceLocator.registerSingleton(sharedPreferences);
  }
  //Apis
  serviceLocator.registerSingleton(FirebaseAuth.instance);
  serviceLocator.registerSingleton(FirebaseFirestore.instance);
  serviceLocator.registerSingleton(FirebaseStorage.instance);
  serviceLocator.registerSingleton(FirebaseMessaging.instance);
  serviceLocator.registerFactory(() => ImagePicker());
  serviceLocator.registerSingleton(http.Client());

  //datasources
  serviceLocator.registerSingleton<IAuthRemoteDatasource>(
      AuthRemoteDatasourceImpl(serviceLocator()));
  serviceLocator.registerSingleton<IUserLocalDataSource>(
      UserLocalDataSourceImpl(serviceLocator()));
  serviceLocator.registerSingleton<IUserRemoteStorageDataSource>(
      UserRemoteStorageDataSourceImpl(serviceLocator()));
  serviceLocator.registerSingleton<IOrganizationRemoteDatasource>(
      OrganizationRemoteDatasourceImpl(serviceLocator()));
  serviceLocator.registerSingleton<IAvatarRemoteDatasource>(
      AvatarRemoteDatasourceImpl(serviceLocator()));
  serviceLocator.registerFactory<IAvatarLocalDatasource>(
      () => AvatarLocalDatasourceImpl(serviceLocator()));
  serviceLocator.registerFactory<IStateLocalDataSource>(
          () => StateLocalDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<IChefRemoteStorageDataSource>(
      () => ChefRemoteStorageDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<INotificationRemoteDatasource>(() =>
      NotificationRemoteDatasourceImpl(
          serviceLocator(),
          serviceLocator(),
          'https://fcm.googleapis.com/fcm/send',
          'AAAATqGctIE:APA91bEPQwZPzIToKA5BbL3g0djGEL7EFxEe_ghwULs4iho-SJxtB_pNQIJb7s0oGyFwykqu7vdS70-EC6iZEpJCDvgxazyH9w_3Q36Om_vEQkVvKXpo20d2aCLh13YQIAQZ8XPdnz9D'));
  serviceLocator.registerFactory<ITeamRemoteDatasource>(
      () => TeamRemoteDatasourceImpl(serviceLocator()));

  //repositories
  serviceLocator.registerSingleton<IAuthRepository>(AuthRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator()));
  serviceLocator.registerSingleton<IOrganizationRepository>(
      OrganizationRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory<IAvatarRepository>(
      () => AvatarRepositoryImpl(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory<IUserRepository>(
      () => UserRepositoryImpl(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory<IChefRepository>(
      () => ChefRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory<INotificationRepository>(
      () => NotificationRepositoryImpl(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory<IStateRepository>(
          () => StateRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory<ITeamRepository>(() => TeamRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator()));

  //use cases
  serviceLocator.registerFactory(() => GetUserStreamUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetOrganizationInfoUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => CropImageUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => RegisterUserUseCase(serviceLocator(),
      serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => PickImageUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => DeleteAvatarFromCacheUserCase(serviceLocator()));
  serviceLocator.registerFactory(() => LoginUserUseCase(serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => GetTeamMembersUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => AcceptDenyMemberUseCase(serviceLocator()));
  serviceLocator.registerFactory(() =>
      HandleAcceptDenyMemberNotificationUseCase(
          serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => UpdateUserProfileUseCase(
      serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => GetUserAuthenticationStateUseCase(
      serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => CheckoutEmailVerificationUseCase(
      serviceLocator(),
      serviceLocator(),
      serviceLocator()));

  /*serviceLocator.registerFactory(() => SendNewMemberNotificationUseCase(
      serviceLocator(),
      serviceLocator()));*/

  //viewmodels
  serviceLocator
      .registerFactory(() => AuthBuilderWidgetViewModel(serviceLocator()));
  serviceLocator.registerFactory(() => LoginViewModel(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator()));
  serviceLocator.registerFactory(() => HomeViewModel());
  serviceLocator
      .registerFactory(() => TeamViewModel(serviceLocator(), serviceLocator()));
  serviceLocator
      .registerFactory(() => SplashViewModel(serviceLocator()));



}
