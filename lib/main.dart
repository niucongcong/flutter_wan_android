import 'package:flutter/material.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:flutter_app/redux/store.dart';
import 'file:///C:/androidProject/flutter_app/lib/ui/splash/SplashScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'network/wan_android_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WanAndroidApi.getInstance().init();
  runApp(WanAndroidApp(createStore()));
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WanAndroidApp extends StatefulWidget {
  final Store<AppState> store;
  WanAndroidApp(this.store);

  @override
  State<StatefulWidget> createState() => _WanAndroidAppState();
}

class _WanAndroidAppState extends State<WanAndroidApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Wan Android',
        theme: ThemeData.dark().copyWith(
          textTheme:
          ThemeData.dark().textTheme.apply(fontFamily: "Source Code Pro"),
          textSelectionColor: Colors.black,
          cardColor: Colors.white,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
