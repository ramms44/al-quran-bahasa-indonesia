// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:quran/src/components/colors.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: height * 0.15,
        // automaticallyImplyLeading: false,
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
                'Help',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(45),
        //   ),
        // ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          // ignore: avoid_unnecessary_containers
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: colors.default_green,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'email : abuhashouse@gmail.com',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
