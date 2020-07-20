library modal_progress_hud;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navigation_action_bar/navigation_action_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALI Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _url = 'https://africanleadershipinstitution.com';
  bool _isLoading = true;
  int currentIndex = 0;

  WebViewController controller;

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationActionBar(
        context: context,
        accentColor: Colors.teal,
        scaffoldColor: Colors.black26,
        index: currentIndex,
        subItems: [
          NavBarItem(iconData: Icons.chat, size: 25),
          NavBarItem(iconData: Icons.assessment, size: 25),
          NavBarItem(iconData: Icons.more, size: 25),
          NavBarItem(iconData: Icons.rate_review, size: 25),
          NavBarItem(iconData: Icons.share, size: 25),
        ],
        mainIndex: 2,
        items: [
          NavBarItem(iconData: Icons.home, size: 30),
          NavBarItem(iconData: Icons.dashboard, size: 30),
          NavBarItem(iconData: Icons.more_vert, size: 40),
          NavBarItem(iconData: Icons.library_books, size: 30),
          NavBarItem(iconData: Icons.announcement, size: 30),
        ],
        onTap: (index) {
          if (index != null)
            _splitScreen(index);
        },
      ),
            body: SafeArea(
                child: ProgressHUD(
                  child: Stack(
                      children: <Widget>[
                        WebView(
                          onWebViewCreated: webViewCreated,
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl: _url,
                          onPageFinished: pageFinishedLoading,
                        ),
                      ]),
                  inAsyncCall: _isLoading,
                  opacity: 0.0,
                )));
  }
  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }

  void _splitScreen(double i) {
    switch (i.toString()) {
      case '0.0':
        _url = 'https://africanleadershipinstitution.com';
        controller.loadUrl(_url);
        break;
      case '1.0':
        _url = 'https://africanleadershipinstitution.com/user/dashboard';
        controller.loadUrl(_url);
        break;
      case '3.0':
        _url = 'https://africanleadershipinstitution.com/courses';
        controller.loadUrl(_url);
        break;
      case '4.0':
        _url = 'https://africanleadershipinstitution.com/courses';
        controller.loadUrl(_url);
        break;
      case '2.0':
        _url = 'https://africanleadershipinstitution.com/blog';
        controller.loadUrl(_url);
        break;
      case '2.1':
        _url = 'https://africanleadershipinstitution.com/courses';
        controller.loadUrl(_url);
        break;
      case '2.2':
        _url = 'https://africanleadershipinstitution.com/about-us';
        controller.loadUrl(_url);
        break;
      case '2.3':
        _url = 'https://africanleadershipinstitution.com/courses';
        controller.loadUrl(_url);
        break;
      case '2.4':
        _url = 'https://africanleadershipinstitution.com/courses';
        controller.loadUrl(_url);
        break;
    }
  }

  void webViewCreated(WebViewController _controller) {
    print('fsbndvsad');
    controller = _controller;

  }
}

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}

