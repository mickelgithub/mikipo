import 'package:flutter/material.dart';
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

class HomeViewModel {

  static const String PAGE_TEAM_TITLE= 'Mi equipo';
  static const String PAGE_HOLIDAYS_TITLE= 'Vacaciones';
  static const String PAGE_ABSENCES_TITLE= 'Ausencias';
  static const String PAGE_TEAM_ICON= 'team_page_icon';
  static const String PAGE_HOLIDAYS_ICON= 'holidays_page_icon';
  static const String PAGE_ABSENCES_ICON= 'absences_page_icon';

  static final _logger= getLogger((HomeViewModel).toString());
  PageController homePageController;

  HomeViewModel() {
    page= ValueNotifier(pages[0]);
    homePageController= PageController(
        initialPage: pages.indexOf(page.value)
    );
  }

  final List<HomePage> pages= [
    HomePage(pageType: PageEnum.team, title: PAGE_TEAM_TITLE, icon: PAGE_TEAM_ICON),
    HomePage(pageType: PageEnum.holidays, title: PAGE_HOLIDAYS_TITLE, icon: PAGE_HOLIDAYS_ICON),
    HomePage(pageType: PageEnum.absences, title: PAGE_ABSENCES_TITLE, icon: PAGE_ABSENCES_ICON),
  ];

  void  setPage(int value) {
    page.value= pages[value];
    homePageController.jumpToPage(value);
  }
  ValueNotifier<HomePage> page;

  void dispose() {
    page.dispose();
    homePageController.dispose();
  }



}