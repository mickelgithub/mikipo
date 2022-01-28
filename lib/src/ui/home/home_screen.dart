import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/absences/absences_screen.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/holidays/holidays_screen.dart';
import 'package:mikipo/src/ui/home/viewmodel/home_view_model.dart';
import 'package:mikipo/src/ui/home/widget/home_rounded_navigation_bar.dart';
import 'package:mikipo/src/ui/team/team_screen.dart';
import 'package:mikipo/src/ui/team/viewmodel/team_view_model.dart';
import 'package:mikipo/src/util/icon/icons_map.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  static final _logger = getLogger((HomeScreen).toString());

  const HomeScreen._();

  static Widget getHomeScreen(
      {@required BuildContext context,
        User user}) {

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel= serviceLocator<HomeViewModel>();
        viewModel.initData(user);
        return viewModel;
      },
      child: HomeScreen._(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static final _logger = getLogger((_HomeScreenState).toString());

  @override
  void initState() {
    super.initState();

    HomeViewModel viewModel =
    Provider.of<HomeViewModel>(context, listen: false);

    viewModel.initUi(this);

  }

  @override
  void dispose() {
    HomeViewModel viewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeScreen._logger.d('build...');

    HomeViewModel viewModel =
        Provider.of<HomeViewModel>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.ldaColor,
        title: Text(
          viewModel.page.title,
            style: TextStyle(color: Palette.white),
          ),
        ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          _getTeamView(context, viewModel.user),
          HolidaysScreen(),
          AbsencesScreen()
        ],
        scrollDirection: Axis.horizontal,
        controller: viewModel.homePageController,
      ),
      bottomNavigationBar: HomeRoundedNavigationBar(
        controller: viewModel.tabController,
        tabs: viewModel.pages
            .map((e) => Tab(
                  icon: Icon(IconsMap.icons[e.icon]),
                ))
            .toList(),
      ),
    );
  }

  Widget _getTeamView(BuildContext context, User user) {
    /*final viewModel = serviceLocator<TeamViewModel>();
    _logger.d('Se ha creado el viewModel TeamViewModel con hash ${viewModel.hashCode}');
    return MultiProvider(
      builder: (_, __) => TeamScreen(viewModel, user),
      providers: [
        Provider<TeamViewModel>.value(value: viewModel),
        ChangeNotifierProvider<ValueNotifier<List<User>>>.value(
            value: viewModel.members),
      ],
    );*/
    return TeamScreen.getTeamScreen(context: context, user: user);
  }
}
