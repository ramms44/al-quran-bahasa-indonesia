import 'package:flutter/material.dart';
import 'package:quran/src/components/animate_route.dart';
import 'package:quran/src/components/colors.dart';
import 'package:quran/src/components/home_button.dart';
import 'package:quran/src/pages/surah/surah.dart';
import 'package:quran/src/pages/surahas/ayahs_view.dart';
import 'package:quran/src/pages/surahas/surahIndex_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _helpCenter() {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }

  bool ishover = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _helpCenter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: colors.default_green, // colors green default
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        color: colors.light_brown,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // children home button widgets component
              HomeButton(
                buttonName: 'BACA QUR`AN',
                onPress: () {
                  Navigator.push(context, AnimatedRoutes(widget: SurahIndex()));
                  print('baca quran');
                },
              ),
              HomeButton(
                buttonName: 'TAFSIR',
                onPress: () {
                  print('tafsir');
                },
              ),
              HomeButton(
                buttonName: 'TERAKHIR BACA',
                onPress: () {
                  print('terakhir baca');
                },
              ),
              HomeButton(
                buttonName: 'PENCARIAN',
                onPress: () {
                  print('pencarian');
                },
              ),
              HomeButton(
                buttonName: 'PENGATURAN',
                onPress: () {
                  print('pengaturan');
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _helpCenter,
        tooltip: 'Helpcenter',
        child: const Icon(Icons.help_center),
        backgroundColor: colors.default_green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
