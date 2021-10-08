// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:quran/src/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final Stream<QuerySnapshot> _noteStream =
      FirebaseFirestore.instance.collection('notes').snapshots();
  String name;
  String comment;
  final _formKey = GlobalKey<FormState>();
  List<String> mynotes;

  // initstate
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() async {
    var notes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notes = prefs.getStringList('notes');
    setState(() {
      mynotes = notes;
    });
    print('mynotes getnotes : $mynotes');
  }

  Future<void> addNotes() {
    // Create a CollectionReference called notes that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('notes');
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'nama': name, // John Doe
          'catatan': comment, // Stokes and Sons
        })
        .then((value) => print("comment added"))
        .catchError((error) => print("Failed to add user: $error"));
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
        toolbarHeight: height * 0.15,
        automaticallyImplyLeading: false,
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: colors.default_green, // colors green default
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Catatan (Surat : Ayat)',
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
      body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: mynotes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                color: colors.light_brown,
                height: 50,
                child: Center(
                  child: Text(
                    '${mynotes[index]}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           content: Stack(
      //             overflow: Overflow.visible,
      //             children: <Widget>[
      //               Positioned(
      //                 right: -40.0,
      //                 top: -40.0,
      //                 child: InkResponse(
      //                   onTap: () {
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: CircleAvatar(
      //                     child: Icon(Icons.close),
      //                     backgroundColor: Colors.red,
      //                   ),
      //                 ),
      //               ),
      //               Form(
      //                 key: _formKey,
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: <Widget>[
      //                     Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: TextFormField(
      //                         decoration: const InputDecoration(
      //                           icon: Icon(Icons.person),
      //                           hintText: 'Apa nama panggilan mu?',
      //                           labelText: 'Nama *',
      //                         ),
      //                         onSaved: (String nama) {
      //                           // This optional block of code can be used to run
      //                           // code when the user saves the form.
      //                           setState(() {
      //                             name = nama;
      //                           });
      //                           print('string nama : $nama');
      //                         },
      //                         validator: (String value) {
      //                           return (value != null && value.contains('@'))
      //                               ? 'Do not use the @ char.'
      //                               : null;
      //                         },
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: TextFormField(
      //                         decoration: const InputDecoration(
      //                           icon: Icon(Icons.comment),
      //                           hintText:
      //                               'Apa catatan yang ingin kamu sampaikan?',
      //                           labelText: 'Catatan *',
      //                         ),
      //                         onSaved: (String catatan) {
      //                           setState(() {
      //                             comment = catatan;
      //                           });
      //                           // This optional block of code can be used to run
      //                           // code when the user saves the form.
      //                           print('string catatam : $catatan');
      //                         },
      //                         validator: (String value) {
      //                           return (value != null && value.contains('@'))
      //                               ? 'Do not use the @ char.'
      //                               : null;
      //                         },
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: RaisedButton(
      //                         child: Text("Submit"),
      //                         onPressed: () {
      //                           if (_formKey.currentState.validate()) {
      //                             _formKey.currentState.save();
      //                             addNotes();
      //                             // save to firestore
      //                           }
      //                         },
      //                         color: Colors.blueAccent,
      //                         textColor: colors.white,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: new BorderRadius.circular(18.0),
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   },
      //   // onPressed: _helpCenter,
      //   tooltip: 'add notes',
      //   child: Icon(Icons.add_rounded),
      //   backgroundColor: colors.default_green,
      // ),
    );
  }
}
