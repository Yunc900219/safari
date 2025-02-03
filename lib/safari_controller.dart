import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafariController extends GetxController {
  final RxBool isOpenWebView = false.obs;

  final WebViewController controller =
      WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        );

  void loadRequest(String url) {
    if (!url.startsWith('http')) {
      url = 'https://www.google.com/search?q=${Uri.encodeComponent(url)}';
    }
    controller.loadRequest(Uri.parse(url));
  }
}
