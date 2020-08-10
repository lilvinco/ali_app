library modal_progress_hud;
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALI Study',
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
      home: MyHomePage(title: 'ALI Study'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  pushNotifications() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
        "9241b337-a04a-4618-9e70-a87e7b88b16e",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

  }
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
  var _selectedIndex = 0;
  static const Color primaryColorDark = Color.fromRGBO(28, 38, 50, 1);

  @override
    Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: primaryColorDark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              title: Text('Courses'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Blog'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('Certification'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: Text('More'),
            ),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          //backgroundColor: Color.fromRGBO(17, 24, 32, 1),
          backgroundColor: primaryColorDark,
          selectedItemColor: Color.fromRGBO(23, 208, 207, 1),
          unselectedItemColor: Color.fromRGBO(169, 163, 163, 1),
          showUnselectedLabels: true,
          onTap: (index) {
            if (index != null){
              print(index);
              setState(() => _selectedIndex = index);
              _splitScreen(index);}
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
                  ))),
    );
  }
  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }

   _splitScreen(int i) {
    switch (i) {
      case 0:
        setState(() => _isLoading = true);
        _url = 'https://africanleadershipinstitution.com';
        controller.loadUrl(_url);
        break;
      case 1:
        setState(() => _isLoading = true);
        _url = 'https://africanleadershipinstitution.com/courses';
        controller.loadUrl(_url);
        break;
      case 2:
        setState(() => _isLoading = true);
        _url = 'https://africanleadershipinstitution.com/blog';
        controller.loadUrl(_url);
        break;
      case 3:
        _url = 'https://africanleadershipinstitution.com/user/certificates';
        controller.loadUrl(_url);
        break;
      case 4:
        print('bbv');
        final result = showMenu(context: context,
            position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
            items: <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text('Dashboard'), value: 'https://africanleadershipinstitution.com/user/dashboard'),
              new PopupMenuItem<String>(
                  child: const Text('About Us'), value: 'https://africanleadershipinstitution.com/about-us'),
              /*new PopupMenuItem<String>(
                  child: const Text('Rate Us'), value: '4.2'),*/
              new PopupMenuItem<String>(
                  child: const Text('Share'), value: 'Share'),
            ],
            elevation: 20.0);
        result.then((value) {
          if(value == 'Share'){
            Share.share('Join me and 40,000 learners on African Leadership Institute: https://africanleadershipinstitution.com/user/dashboard');
          }
          else {
            print(value);
            _url = value;
            controller.loadUrl(_url);
          }
        });
        break;
    }
  }

  void webViewCreated(WebViewController _controller) {
    controller = _controller;
  }
}
class Choice {
  const Choice({this.title, this.url, this.icon});
  final String title;
  final String url;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'About Us', url: ''),
  const Choice(title: 'Rate Us', url: ''),
  const Choice(title: 'Share', url: ''),
];

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

