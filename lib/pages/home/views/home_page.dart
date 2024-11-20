import 'package:flutter/material.dart';
import 'package:mirror_wall_app/app_routes.dart';
import 'package:mirror_wall_app/pages/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider homeProviderW;
  late HomeProvider homeProviderR;
  InAppWebViewController? webController;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().checkConnection();
    context.read<HomeProvider>().checkIndex();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
      onRefresh: () {
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS) {
          homeProviderW.webController!.reload();
        }
      },
    );
  }

  String? selectedIndex;

  @override
  Widget build(BuildContext context) {
    homeProviderW = context.watch<HomeProvider>();
    homeProviderR = context.read<HomeProvider>();
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: isDarkTheme ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onSubmitted: (val) {
              var url = WebUri(val);
              homeProviderR.webController?.loadUrl(
                urlRequest: URLRequest(
                  url: WebUri("https://www.google.com/search?q=$val"),
                ),
              );
              homeProviderR.setSearch(val);
            },
            decoration: InputDecoration(
              hintText: 'Search or enter URL',
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => homeProviderW.webController?.goBack(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => homeProviderW.webController?.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () => homeProviderW.webController?.goForward(),
          ),
          PopupMenuButton<int>(
            onSelected: (val) {
              switch (val) {
                case 0:
                  _showSearchEngineDialog(context);
                  break;
                case 1:
                  Navigator.pushNamed(context, AppRoutes.search);
                  break;
                case 2:
                  Navigator.pushNamed(context, AppRoutes.settings);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search Engine"),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Search History"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: homeProviderW.isConnect
          ? Column(
        children: [
          if (homeProviderW.progress < 1.0)
            LinearProgressIndicator(
              value: homeProviderW.progress,
              color: isDarkTheme ? Colors.tealAccent : Colors.blueAccent,
            ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(homeProviderW.url.toString()),
              ),
              onProgressChanged: (controller, progress) {
                homeProviderR.isProcess(progress / 100);
                pullToRefreshController?.endRefreshing();
              },
              onWebViewCreated: (controller) {
                homeProviderW.webController = controller;
              },
              pullToRefreshController: pullToRefreshController,
            ),
          ),
        ],
      )
          : _buildOfflineView(),
    );
  }

  Widget _buildOfflineView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 100),
          const SizedBox(height: 20),
          Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
            onPressed: () => homeProviderR.checkConnection(),
          ),
        ],
      ),
    );
  }

  void _showSearchEngineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Select Search Engine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRadioOption("Google", "https://www.google.com/"),
              _buildRadioOption("Bing", "https://www.bing.com/"),
              _buildRadioOption("Yahoo", "https://www.yahoo.com/"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioOption(String label, String url) {
    return RadioListTile(
      value: label,
      groupValue: selectedIndex,
      onChanged: (val) {
        homeProviderW.webController?.loadUrl(
          urlRequest: URLRequest(url: WebUri(url)),
        );
        selectedIndex = val as String?;
        homeProviderR.selectIndex(url);
        Navigator.pop(context);
      },
      title: Text(label),
    );
  }
}
