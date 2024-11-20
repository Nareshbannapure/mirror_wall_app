
import 'package:flutter/material.dart';
import 'package:mirror_wall_app/app_routes.dart';
import 'package:mirror_wall_app/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider()
            ..checkTheme()
            ..getHistory(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: (value.isTheme) ? ThemeData.dark() : ThemeData.light(),
            themeMode: (value.isTheme)
                ? ThemeMode.dark
                : value.isTheme
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
