import 'package:flutter/material.dart';
import 'package:master_card_webview/my_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse('https://www.google.co.uk/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Example'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await webViewController.canGoBack()) {
                    webViewController.goBack();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('No Back History Found!'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await webViewController.canGoForward()) {
                    webViewController.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                          content: Text('No Forward History Found!'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () {
                  webViewController.reload();
                },
              ),
            ],
          ),
        ],
      ),
      body: MyWebView(controller: webViewController),
    );
  }
}
