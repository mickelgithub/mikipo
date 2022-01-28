import 'package:flutter/material.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/widget/matias_feedback.dart';
import 'package:mikipo/src/ui/team/viewmodel/team_view_model.dart';
import 'package:mikipo/src/ui/team/widget/member_item.dart';
import 'package:mikipo/src/ui/team/widget/member_no_accepted_yet_item.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class TeamScreen extends StatefulWidget {

  static final _logger = getLogger((TeamScreen).toString());

  TeamScreen._();

  static Widget getTeamScreen(
      {@required BuildContext context,
        @required User user}) {

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel= serviceLocator<TeamViewModel>();
        viewModel.init(user);
        return viewModel;
      },
      child: TeamScreen._(),
    );
  }

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  static final _logger = getLogger((_TeamScreenState).toString());

  @override
  void initState() {
    super.initState();
    _logger.d('initState...$hashCode');
    final viewModel= Provider.of<TeamViewModel>(context, listen: false);
    _logger.d('the viewmodel has the hascode ${viewModel.hashCode}');
    viewModel.init(viewModel.user);
  }

  @override
  Widget build(BuildContext context) {
    TeamScreen._logger.d('build...$hashCode');
    final viewModel= Provider.of<TeamViewModel>(context);
    return Consumer<ValueNotifier<List<User>>>(
      builder: (_, valueNotifier, __) {
        if (valueNotifier.value != null) {
          final members = valueNotifier.value;
          if (members.isEmpty) {
            return Container(
                color: Palette.feedback_backgroud_color,
                child: MatiasFeedback(
                  feedback: 'Tu equipo todavia no tiene miembros',
                ));
          } else {
            return _buildMembers(members, viewModel);
          }
        }
        return Container(
          width: 0.0,
          height: 0.0,
        );
      },
    );
  }

  Widget _buildMembers(List<User> members, TeamViewModel viewModel) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        separatorBuilder: (_, index) => Divider(),
        itemCount: members.length,
        itemBuilder: (_, index) {
          return members[index].isConfirmedPositive()
              ? Provider<TeamViewModel>.value(
                  value: viewModel,
                  child: MemberItem(chef: viewModel.user, member: members[index]))
              : Provider<TeamViewModel>.value(
                  value: viewModel,
                  child: MemberNotAcceptedYetItem(
                      chef: viewModel.user, member: members[index]));
        });
  }

  @override
  void dispose() {
    _logger.d('dispose...');
    super.dispose();
  }
}
