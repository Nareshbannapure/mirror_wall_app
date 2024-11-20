import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall_app/pages/home/helper/helper.dart';

class HomeProvider with ChangeNotifier {
  var connectivity = Connectivity();
  double progress = 0;
  int currentIndex = 0;
  String? url;
  InAppWebViewController? webController;

  bool isTheme = false;
  bool isConnect = false;

  List<String> searchHistory = [];
  List<String> get getSearchHistory => searchHistory;

  Future<void> setSearch(String term) async {
    if (term.isNotEmpty && !searchHistory.contains(term)) {
      searchHistory.insert(0, term); // Add the new term at the top
      await ShrHelper.shrHelper.saveSearchHistory(searchHistory);
      notifyListeners();
    }
  }

  Future<void> removeSearch(String term) async {
    searchHistory.remove(term);
    await ShrHelper.shrHelper.saveSearchHistory(searchHistory);
    notifyListeners();
  }

  void getSearch() async {
    searchHistory = await ShrHelper.shrHelper.getSearchHistory();
    notifyListeners();
  }

  void getHistory() {
    getSearch();
    notifyListeners();
  }

  void checkConnection() async {
    StreamSubscription<List<ConnectivityResult>> results =
    (await Connectivity().onConnectivityChanged.listen(
          (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          isConnect = false;
        } else {
          isConnect = true;
        }
        notifyListeners();
      },
    ));
  }

  void isProcess(double value) {
    progress = value;
    notifyListeners();
  }

  void themeChange(bool theme) {
    isTheme = theme;
    ShrHelper.shrHelper.setTheme(theme);
    notifyListeners();
  }

  void checkTheme() async {
    bool? theme = await ShrHelper.shrHelper.getTheme();
    isTheme = theme!;
    notifyListeners();
  }

  void selectIndex(String val) {
    ShrHelper.shrHelper.setIndex(val);
    notifyListeners();
  }

  Future<void> checkIndex() async {
    url = await ShrHelper.shrHelper.getIndex();
    notifyListeners();
  }
}