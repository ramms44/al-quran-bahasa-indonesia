// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:quran/src/model/juzModel.dart';
import 'package:quran/src/model/sajdaModel.dart';
import 'package:quran/src/model/surahModel.dart';

class QuranAPI {
  Future<SurahsList> getSurahList() async {
    String url = "https://ramms44.github.io/al_quran_data/quran_uthmani.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SurahsList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<String> getJsonAlafasi() {
    return rootBundle.loadString('assets/jsons/quran_alafasy.json');
  }

  getJsonQuran() async {
    // ignore: unused_local_variable
    return json.decode(
      await getJsonAlafasi(),
    );
    // print('alafasi data : ${alafasiData['surahs'][0]['ayahs'][0]['audio']}');
  }

  Future<SurahsListEnAsad> getTranslateList() async {
    String url = "http://api.alquran.cloud/v1/quran/en.asad";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SurahsListEnAsad.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SajdaList> getSajda() async {
    String url = "http://api.alquran.cloud/v1/sajda/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SajdaList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
}
