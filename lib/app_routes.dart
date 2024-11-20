import 'package:flutter/material.dart';
import 'package:mirror_wall_app/pages/bookmark/bookmark.dart';
import 'package:mirror_wall_app/pages/home/views/home_page.dart';
import 'package:mirror_wall_app/pages/search_history/search_history.dart';
import 'package:mirror_wall_app/pages/settings/settings.dart';
import 'package:mirror_wall_app/pages/splash_screen/splash_screen.dart';


class AppRoutes {
  static const String splashcreen = '/';
  static const String homepage = '/homepage';
  static const String bookmark = '/bookmark';
  static const String settings = '/settings';
  static const String search = '/search';


  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.splashcreen: (context) => const SplashScreen(),
    AppRoutes.homepage: (context) => const HomePage(),
    AppRoutes.bookmark: (context) => const BookmarkPage(),
    AppRoutes.settings: (context) => const SettingPage(),
    AppRoutes.search: (context) => const SearchHistoryPage(),

  };
}