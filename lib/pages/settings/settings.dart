
import 'package:flutter/material.dart';
import 'package:mirror_wall_app/app_routes.dart';
import 'package:mirror_wall_app/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Theme'),
            trailing: Switch(
              value: context.watch<HomeProvider>().isTheme,
              onChanged: (value) {
                context.read<HomeProvider>().themeChange(value);
              },
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.bookmark);
            },
            title: const Text('BookMark'),
            leading: const Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
