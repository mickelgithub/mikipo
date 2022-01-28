import 'package:mikipo/src/data/datasource/local/state/state_local_datasource.dart';
import 'package:mikipo/src/domain/entity/local/local_state_info.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateLocalDataSourceImpl implements IStateLocalDataSource {
  final SharedPreferences _preferences;

  StateLocalDataSourceImpl(this._preferences);

  @override
  LocalStateInfo getLocalInfo() {
    String userId = _preferences.get(UserConstants.USER_ID);
    if (userId == null) {
      return null;
    } else {
      final email = _preferences.getString(UserConstants.EMAIL);
      final pass = _preferences.getString(UserConstants.PASS);
      final biometricAuth= _preferences.getBool(UserConstants.BIOMETRIC_AUTH) ?? false;
      final savedCredentials= _preferences.getBool(UserConstants.SAVED_CREDENTIALS) ?? false;
      return LocalStateInfo(userId: userId, email: email, pass: pass, biometricAuth: biometricAuth, savedCredentials: savedCredentials);
    }
  }

  @override
  void saveUserDischargedState() async {
    await _preferences.clear();
    await _preferences.setString(UserConstants.STATE, UserConstants.STATE_DISCHARGED);
  }


}
