// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/src/components/colors.dart';
import 'package:quran/src/pages/help/help.dart';
import 'package:quran/src/pages/notes/notes.dart';
import 'package:quran/src/pages/pengaturan/pengaturan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran/src/pages/surahas/surahIndex_view.dart';
import 'animations/bottomAnimation.dart';
import 'components/home_button.dart';
import 'customWidgets/appName.dart';
import 'customWidgets/calligraphy.dart';
import 'customWidgets/quranRailPNG.dart';
import 'darkModeController/darkThemeProvider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'pages/search/suratAyat.dart';

const kUrl1 = 'https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3';
const kUrl2 = 'https://cdn.islamic.network/quran/audio/128/ar.alafasy/2.mp3';

class HomeScreen extends StatefulWidget {
  final double maxSlide;
  final bahasa;
  HomeScreen({@required this.maxSlide, this.bahasa});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  String localFilePath;
  AudioPlayer audioPlayer = AudioPlayer();
  String bahasa;

  @override
  void initState() {
    super.initState();
    getBahasa(bahasa);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    // play();
  }

  Future<String> getBahasa(value) async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getString("bahasa") ?? "null";
    print('bahasa yang dipilih : $value');
    setState(() {
      bahasa = value;
    });
    return value;
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  bool _canBeDragged;
  bool isPlay = false;

  // play
  void play() async {
    // if (isPlay == true) {
    int result = await audioPlayer.play(kUrl1);
    if (result == 1) {
      print('result : $result');
      // success play
    }

    audioPlayer.onPlayerStateChanged.listen((msg) {
      print('audioPlayer change : $msg');
      // ignore: unrelated_type_equality_checks
      if (PlayerState.COMPLETED == true) {
        print('play another');
        // advancedPlayer.play(kUrl2);
      }
    });
  }

  // pause
  pause() async {
    // ...
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / widget.maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text("Are You Sure?"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                shape: const StadiumBorder(),
                color: Colors.white,
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    print('isplay : $isPlay');
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
        toolbarHeight: height * 0.15,
        automaticallyImplyLeading: false,
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: colors.default_green, // colors green default
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Al - Qur`an',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Image(
                image: AssetImage(
                  'assets/golden_quran.png',
                ),
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
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
                buttonName:
                    widget.bahasa == 'id' ? 'BACA QUR`AN' : 'READ QUR`AN',
                onPress: () {
                  // Navigator.push(context, AnimatedRoutes(widget: SurahIndex()));

                  // Navigator.pushNamed(context, '/surahIndex');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahIndex(
                        isTafsir: false,
                        bahasa: bahasa,
                      ),
                    ),
                  );
                  print('baca quran');
                },
              ),
              // HomeButton(
              //   buttonName: 'TAFSIR',
              //   onPress: () {
              //     print('tafsir');
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const SurahIndex(isTafsir: true),
              //       ),
              //     );
              //   },
              // ),
              // HomeButton(
              //   buttonName: 'TERAKHIR BACA',
              //   onPress: () {
              //     print('terakhir baca');
              //     play();
              //   },
              // ),
              // HomeButton(
              //   buttonName: 'PENCARIAN',
              //   onPress: () {
              //     print('pencarian');
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => SearchPages()),
              //     );
              //   },
              // ),
              HomeButton(
                buttonName: widget.bahasa == 'id'
                    ? 'PENCARIAN SURAT & AYAT'
                    : 'SEARCH VERSE & SURAH',
                onPress: () {
                  print('pencarian');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchSurahAyah()),
                  );
                },
              ),
              HomeButton(
                buttonName: widget.bahasa == 'id' ? 'LIHAT CATATAN' : 'NOTES',
                onPress: () {
                  print('CATATAN');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotesPage(bahasa: bahasa)),
                  );
                },
              ),
              HomeButton(
                buttonName:
                    widget.bahasa == 'id' ? 'BAHASA' : 'LANGUAGES SETTING',
                onPress: () {
                  print('BAHASA');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PengaturanBahasa()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpPage()),
          );
        },
        // onPressed: _helpCenter,
        tooltip: 'Helpcenter',
        child: Icon(Icons.help_center),
        backgroundColor: colors.default_green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: themeChange.darkTheme ? Colors.grey[800] : Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AppName(),
          Calligraphy(),
          QuranRail(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[SurahBtn(), JuzzIndexBtn(), SajdaBtn()],
            ),
          ),
          AyahBottom(),
        ],
      ),
    );
  }
}

//
class SurahBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.06,
        child: RaisedButton(
          shape: const StadiumBorder(),
          onPressed: () => Navigator.pushNamed(context, '/surahIndex'),
          child: WidgetAnimator(
            Text(
              "Surah Index",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w400),
            ),
          ),
          color: Color(0xffee8f8b),
        ),
      ),
    );
  }
}

class SajdaBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.06,
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/sajda');
          },
          child: WidgetAnimator(
            Text(
              "Sajda Index",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w400),
            ),
          ),
          color: Color(0xffee8f8b),
        ),
      ),
    );
  }
}

class JuzzIndexBtn extends StatelessWidget {
  const JuzzIndexBtn({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.06,
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/juzzIndex');
          },
          child: WidgetAnimator(
            Text(
              "Juzz Index",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w400),
            ),
          ),
          color: Color(0xffee8f8b),
        ),
      ),
    );
  }
}

class AyahBottom extends StatelessWidget {
  const AyahBottom({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "\"Indeed, It is We who sent down the Qur'an\nand indeed, We will be its Guardian\"\n",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            "Surah Al-Hijr\n",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
