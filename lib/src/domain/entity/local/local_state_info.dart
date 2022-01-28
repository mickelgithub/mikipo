import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_state_info.freezed.dart';

@freezed
abstract class LocalStateInfo with _$LocalStateInfo {

  const factory LocalStateInfo(
      {String userId,
        String email,
        String pass,
        bool biometricAuth,
        bool savedCredentials
        }) = _LocalStateInfo;


}