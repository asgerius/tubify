import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubify/screens/player_screen/player_screen.dart';
import 'package:tubify/system/persistent.dart';
import 'package:tubify/theme.dart';
import 'package:tubify/widgets/transitions.dart';


// If the screen is too small, force portrait mode
const double _minHeight = 600;
bool _isPhone() => MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.shortestSide < _minHeight;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await persistent.init();
  await persistent.setIds(["dQw4w9WgXcQ", "o7cCJqya7wc", "tVj0ZTS4WF4"]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Make status bar transparent and use light icons
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (_isPhone())
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Tubify',
      theme: themeData(),
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      home: PlayerScreen(),
      onGenerateRoute: (RouteSettings settings) {
        final Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
        switch (settings.name) {
          case PlayerScreen.routeName:
            return swipeTransition(PlayerScreen());
        }
      }
    );
  }
}
