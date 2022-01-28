import 'package:mikipo/src/data/datasource/local/state/state_local_datasource.dart';
import 'package:mikipo/src/domain/entity/local/local_state_info.dart';
import 'package:mikipo/src/domain/repository/state/state_repository.dart';

class StateRepositoryImpl implements IStateRepository {

  final IStateLocalDataSource _stateLocalDataSource;

  StateRepositoryImpl(this._stateLocalDataSource);

  @override
  LocalStateInfo getLocalInfo() => _stateLocalDataSource.getLocalInfo();

  @override
  void saveUserDischargedState() async => await _stateLocalDataSource.saveUserDischargedState();

}