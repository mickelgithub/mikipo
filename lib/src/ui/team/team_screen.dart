import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/widget/matias_feedback.dart';
import 'package:mikipo/src/ui/team/viewmodel/team_view_model.dart';
import 'package:mikipo/src/ui/team/widget/member_item.dart';
import 'package:mikipo/src/ui/team/widget/member_no_accepted_yet_item.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatefulWidget {
  static final _logger = getLogger((TeamScreen).toString());

  final TeamViewModel _viewModel;
  final User _user;

  TeamScreen(this._viewModel, this._user);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  static final _logger = getLogger((_TeamScreenState).toString());

  TeamViewModel get viewModel => widget._viewModel;
  User get user => widget._user;

  Future<List<User>> _members;

  @override
  void initState() {
    super.initState();
    _logger.d('initState...${hashCode}');
    _logger.d('the viewmodel has the hascode ${viewModel.hashCode}');
    viewModel.init(user);
  }

  @override
  Widget build(BuildContext context) {
    TeamScreen._logger.d('build...${hashCode}');
    return ChangeNotifierProvider<ValueNotifier<List<User>>>(
      create: (_) => viewModel.members,
      child: Consumer<ValueNotifier<List<User>>>(
        builder: (_, valueNotifier, __) {
          print('hola');
          if (valueNotifier.value!= null) {
            print('hola1');
            final members = valueNotifier.value;
            if (members.isEmpty) {
              return Container(
                  color: Palette.feedback_backgroud_color,
                  child: MatiasFeedback(
                    feedback: 'Tu equipo todavia no tiene miembros',
                  ));
            } else {
              print('hola2');
              return _buildMembers(members);
            }
          }
          print('hola3');
          return Container(
            width: 0.0,
            height: 0.0,
          );
        },
      ),
    );

    /*return Consumer<ValueNotifier<List<User>>>(
      builder: (_, valueNotifier, __) {
        print('hola');
        if (valueNotifier.value!= null) {
          print('hola1');
          final members = valueNotifier.value;
          if (members.isEmpty) {
            return Container(
                color: Palette.feedback_backgroud_color,
                child: MatiasFeedback(
                  feedback: 'Tu equipo todavia no tiene miembros',
                ));
          } else {
            print('hola2');
            return _buildMembers(members);
          }
        }
        print('hola3');
        return Container(
          width: 0.0,
          height: 0.0,
        );
      },
    );*/
  }

  Widget _buildMembers(List<User> members) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        separatorBuilder: (_, index) => Divider(),
        itemCount: members.length,
        itemBuilder: (_, index) {
          return members[index].isAcceptedByChef
              ? Provider<TeamViewModel>.value(
                  value: viewModel, child: MemberItem(chef: user, member: members[index]))
              : Provider<TeamViewModel>.value(
                  value: viewModel,
                  child: MemberNotAcceptedYetItem(chef: user, member: members[index]));
        });
  }

  @override
  void dispose() {
    _logger.d('dispose...');
    super.dispose();
  }
}
