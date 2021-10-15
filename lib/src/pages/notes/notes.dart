// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:quran/src/components/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPage extends StatefulWidget {
  final String bahasa;
  NotesPage({
    Key key,
    this.bahasa,
  }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String name;
  String comment;
  List<String> mynotes;

  // initstate
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() async {
    List<String> notes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notes = prefs.getStringList('notes');
    setState(() {
      mynotes = notes;
    });
    // ignore: avoid_print
    print('mynotes getnotes : $mynotes');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        title: Text(
          widget.bahasa == 'id' ? 'Catatan' : 'Notes',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: mynotes == null
          ? Container(
              padding: const EdgeInsets.all(15),
              child: Card(
                child: Container(
                  color: colors.light_brown,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Catatan anda masih kosong',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: mynotes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      // code...
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: colors.light_brown,
                            content: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: colors.default_green,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          color: colors.light_brown,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              mynotes[index],
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      color: colors.light_brown,
                      height: 50,
                      child: Center(
                        child: Text(
                          mynotes[index],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
