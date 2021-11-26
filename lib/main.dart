import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran/src/components/colors.dart';
import 'package:quran/src/darkModeController/darkThemeProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/homeScreen_view.dart';
import 'src/pages/juzz/JuzIndex_view.dart';
import 'src/pages/otherViews/help.dart';
import 'src/pages/sajda/sajdaIndex_view.dart';
import 'src/pages/surahas/surahIndex_view.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(
    MyApp(),
  );
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
// class App extends StatefulWidget {
//   // Create the initialization Future outside of `build`:
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   /// The future is part of the state of our widget. We should not call `initializeApp`
//   /// directly inside [build].
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Center(child: Text('something when wrong...'));
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           print(snapshot.connectionState);
//           return MyApp();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Center(child: Text('loading...'));
//         ;
//       },
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    darkThemeProvider.darkTheme =
        await darkThemeProvider.darkThemePref.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(create: (_) {
      return darkThemeProvider;
    }, child: Consumer<DarkThemeProvider>(
      builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          title: "They Holy Qur'an",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: colors.light_brown,
            appBarTheme: const AppBarTheme(
              color: colors.default_green,
            ),
          ), // Change this),
          home: Builder(
            builder: (context) => HomeScreen(
              maxSlide: MediaQuery.of(context).size.width * 0.835,
            ),
          ),
          initialRoute: initScreen == 0 || initScreen == null
              ? '/introduction'
              : '/homeScreen',
          routes: <String, WidgetBuilder>{
            // '/introduction': (context) => OnBoardingCard(),
            '/homeScreen': (context) => HomeScreen(
                  maxSlide: MediaQuery.of(context).size.width * 0.835,
                ),
            '/surahIndex': (context) => SurahIndex(),
            '/sajda': (context) => Sajda(),
            '/juzzIndex': (context) => JuzIndex(),
            '/help': (context) => Help(),
          },
        );
      },
    ));
  }
}

//Copyright (C) 2019 Potix Corporation. All Rights Reserved.
//History: Tue Apr 24 09:29 CST 2019
// Author: Jerry Chen

// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Scroll To Index Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Scroll To Index Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static const maxCount = 100;
//   final random = math.Random();
//   final scrollDirection = Axis.vertical;

//   AutoScrollController controller;
//   List<List<int>> randomList;

//   @override
//   void initState() {
//     super.initState();
//     controller = AutoScrollController(
//         viewportBoundaryGetter: () =>
//             Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//         axis: scrollDirection);
//     randomList = List.generate(maxCount,
//         (index) => <int>[index, (1000 * random.nextDouble()).toInt()]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView(
//         scrollDirection: scrollDirection,
//         controller: controller,
//         children: randomList.map<Widget>((data) {
//           return Padding(
//             // ignore: prefer_const_constructors
//             padding: EdgeInsets.all(8),
//             child: _getRow(data[0], math.max(data[1].toDouble(), 50.0)),
//           );
//         }).toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _scrollToIndex,
//         tooltip: 'Increment',
//         child: Text(counter.toString()),
//       ),
//     );
//   }

//   int counter = -1;
//   Future _scrollToIndex() async {
//     setState(() {
//       counter++;
//       if (counter >= maxCount) counter = 0;
//     });

//     await controller.scrollToIndex(counter,
//         preferPosition: AutoScrollPosition.begin);
//     controller.highlight(counter);
//   }

//   Widget _getRow(int index, double height) {
//     return _wrapScrollTag(
//       index: index,
//       child: Container(
//         padding: EdgeInsets.all(8),
//         alignment: Alignment.topCenter,
//         height: height,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.lightBlue, width: 4),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text('index: $index, height: $height'),
//       ),
//     );
//   }

//   Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
//         key: ValueKey(index),
//         controller: controller,
//         index: index,
//         child: child,
//         highlightColor: Colors.black.withOpacity(0.1),
//       );
// }
