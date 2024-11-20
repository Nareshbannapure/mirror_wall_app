import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static ShrHelper shrHelper = ShrHelper();
  List<String>searchHistory=[];
  String? selectedindex;

  Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', history);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("searchHistory") ?? [];
  }

  void setSearch(List<String> search) async {
    final SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList("searchHistory", searchHistory);
  }

  Future<List<String>?> getSearch() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    return shr.getStringList("searchHistory") ?? [];
  }

  void setIndex(String webView) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString(
      "index",
      webView,
    );
  }

  Future<String?> getIndex() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    String? index = shr.getString("index");
    return index;
  }

  Future<void> setTheme(bool theme) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool("theme", theme);
  }

  Future<bool?> getTheme() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? theme = shr.getBool("theme");
    return theme;
  }
}