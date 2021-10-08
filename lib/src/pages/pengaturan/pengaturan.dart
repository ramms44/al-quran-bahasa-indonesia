// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:quran/src/components/colors.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({Key key}) : super(key: key);

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
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
                'Pengaturan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
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
      body: Container(
        child: Center(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Jenis Penulisan Arabic',
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Ukuran Font Arabic', textAlign: TextAlign.left),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Jenis Font Latin', textAlign: TextAlign.left),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Ukuran Font Latin', textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
