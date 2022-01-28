import 'package:mikipo/src/domain/entity/local/local_state_info.dart';

abstract class IStateLocalDataSource {
  LocalStateInfo getLocalInfo();
  void saveUserDischargedState();
}