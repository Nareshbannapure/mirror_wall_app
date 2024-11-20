
import 'package:flutter/material.dart';
import 'package:mirror_wall_app/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';


class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  late HomeProvider searchHistoryProviderW;
  late HomeProvider searchHistoryProviderR;
  @override
  Widget build(BuildContext context) {
    searchHistoryProviderW = context.watch<HomeProvider>();
    searchHistoryProviderR = context.read<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search History'),
      ),
      body: ListView.builder(
        itemCount: searchHistoryProviderW.searchHistory.length,
        itemBuilder: (context, index) {
          final history = searchHistoryProviderW.searchHistory[index];
          return ListTile(
            title: Text(history),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                searchHistoryProviderR.removeSearch(history);
              },
            ),
          );
        },
      ),
    );
  }
}
