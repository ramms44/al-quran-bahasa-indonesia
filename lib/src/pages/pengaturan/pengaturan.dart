// ignore_for_file: file_names

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:quran/src/homeScreen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran/src/components/colors.dart';
import 'package:flutter/material.dart';

class PengaturanBahasa extends StatefulWidget {
  const PengaturanBahasa({Key key}) : super(key: key);

  @override
  _PengaturanBahasaState createState() => _PengaturanBahasaState();
}

class _PengaturanBahasaState extends State<PengaturanBahasa> {
  // ignore: prefer_typing_uninitialized_variables
  String bahasa;
  // ignore: non_constant_identifier_names
  String simpan_bahasa;
  final formKey = GlobalKey<FormState>();

  int jumlah_ayat = 0;

  var dataSourceBahasa = [
    // {
    //   "code_bahasa": "jw",
    //   "bahasa": "Bahasa Jawa",
    // },
    // {
    //   "code_bahasa": "su",
    //   "bahasa": "Bahawa Sunda",
    // },
    {
      "code_bahasa": "id",
      "bahasa": "Bahasa Indonesia",
    },
    {
      "code_bahasa": "en",
      "bahasa": "Bahasa Inggris",
    },
  ];

  @override
  void initState() {
    super.initState();
    bahasa = '';
  }

  Future<void> setBahasa(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bahasa', value);
    print('bahasa code : $value');
  }

  _saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setBahasa(bahasa);
      setState(() {
        simpan_bahasa = bahasa;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(bahasa: simpan_bahasa)),
      );
    }
    print('bahasa : $simpan_bahasa');
  }

  String bahasaValidator(var bahasa) {
    bahasa = bahasa;
    if (bahasa == '') {
      return 'bahasa kosong';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          bahasa == 'id' ? 'Pengaturan Bahasa' : 'Languages Setting',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: DropDownFormField(
                    titleText: 'Bahasa',
                    hintText: 'Pilih bahasa',
                    value: bahasa,
                    onSaved: (value) {
                      setState(() {
                        bahasa = value.toString();
                      });
                      print('bahasa : $value');
                    },
                    onChanged: (value) {
                      setState(() {
                        bahasa = value.toString();
                      });
                      print('bahasa : $value');
                    },
                    validator: bahasaValidator,
                    dataSource: dataSourceBahasa,
                    textField: 'bahasa',
                    valueField: 'code_bahasa',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: colors.white),
                    ),
                    onPressed: () {
                      _saveForm();
                    },
                    color: colors.default_green,
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
