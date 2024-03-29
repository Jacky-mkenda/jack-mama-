import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutPrivacyTerms extends StatefulWidget {
  final String appBarTitle, loadURL;

  const AboutPrivacyTerms({
    Key? key,
    this.cookieManager,
    required this.appBarTitle,
    required this.loadURL,
  }) : super(key: key);

  final CookieManager? cookieManager;
  @override
  State<AboutPrivacyTerms> createState() => _AboutPrivacyTermsState();
}

class _AboutPrivacyTermsState extends State<AboutPrivacyTerms> {
  final _controller = Completer<WebViewController>();
  SharedPre sharedPref = SharedPre();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: Utility.myAppBar(context, widget.appBarTitle),
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          minWidth: MediaQuery.of(context).size.width,
        ),
        decoration: Utility.topRoundBG(),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: setWebView(),
        ),
      ),
    );
  }

  Widget setWebView() {
    return WebView(
      initialUrl: widget.loadURL,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        log('WebView is loading (progress : $progress%)');
      },
      javascriptChannels: <JavascriptChannel>{
        _toasterJavascriptChannel(context),
      },
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          log('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        log('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        log('Page started loading: $url');
      },
      onPageFinished: (String url) {
        log('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
      backgroundColor: const Color(0x00000000),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
