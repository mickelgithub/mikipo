import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';


enum PageEnum {
  team, holidays, absences
}

class HomePage {

  final PageEnum pageType;
  final String title;
  final String icon;

  HomePage({this.pageType, this.title, this.icon});

}

class HomeViewModel with ChangeNotifier {

  static const String PAGE_TEAM_TITLE= 'Mi equipo';
  static const String PAGE_HOLIDAYS_TITLE= 'Vacaciones';
  static const String PAGE_ABSENCES_TITLE= 'Ausencias';
  static const String PAGE_TEAM_ICON= 'team_page_icon';
  static const String PAGE_HOLIDAYS_ICON= 'holidays_page_icon';
  static const String PAGE_ABSENCES_ICON= 'absences_page_icon';

  static final _logger= getLogger((HomeViewModel).toString());

  final List<HomePage> pages= [
    HomePage(pageType: PageEnum.team, title: PAGE_TEAM_TITLE, icon: PAGE_TEAM_ICON),
    HomePage(pageType: PageEnum.holidays, title: PAGE_HOLIDAYS_TITLE, icon: PAGE_HOLIDAYS_ICON),
    HomePage(pageType: PageEnum.absences, title: PAGE_ABSENCES_TITLE, icon: PAGE_ABSENCES_ICON),
  ];

  User user;
  PageController homePageController;
  TabController tabController;
  HomePage page;
  
  
  void initUi(SingleTickerProviderStateMixin ticker) {
    page= pages[0];
    homePageController= PageController(
        initialPage: pages.indexOf(page)
    );
    tabController =
        TabController(length: pages.length, vsync: ticker);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        print('..........................${tabController.index}');
        setPage(tabController.index);
      }
    });
  }
  
  void initData(User user) {
    this.user= user;
  }

  void setPage(int value) {
    page= pages[value];
    homePageController.jumpToPage(value);
    notifyListeners();
  }

  void dispose() {
    homePageController.dispose();
    tabController.dispose();
  }


}