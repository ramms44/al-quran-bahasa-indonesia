// ignore_for_file: file_names

import 'dart:convert';

class SurahsList {
  final List<Surah> surahs;

  SurahsList({this.surahs});

  factory SurahsList.fromJSON(Map<String, dynamic> json) {
    Iterable surahlist = json['data']['surahs'];
    List<Surah> surahsList = surahlist.map((i) => Surah.fromJSON(i)).toList();

    return SurahsList(surahs: surahsList);
  }
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayat> ayahs;
  final String audio;

  Surah(
      {this.number,
      this.revelationType,
      this.name,
      this.ayahs,
      this.englishName,
      this.englishNameTranslation,
      this.audio});

  factory Surah.fromJSON(Map<String, dynamic> json) {
    Iterable ayahs = json['ayahs'];
    List<Ayat> ayahsList = ayahs.map((e) => Ayat.fromJSON((e))).toList();

    return Surah(
        name: json['name'],
        number: json['number'],
        englishName: json['englishName'],
        revelationType: json['revelationType'],
        englishNameTranslation: json['englishNameTranslation'],
        ayahs: ayahsList,
        audio: json['audio']);
  }
}

class AyatWithTranslate {
  final int number;
  final String text;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final int sajda;
  AyatWithTranslate({
    this.number,
    this.text,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory AyatWithTranslate.fromJSON(Map<String, dynamic> json) {
    return AyatWithTranslate(
      number: json['number'],
      text: json['text'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      sajda: json['sajda'],
    );
  }
}

class Ayat {
  final String text;
  final int number;
  final int number_ayahs;
  Ayat({
    this.text,
    this.number,
    this.number_ayahs,
  });

  factory Ayat.fromJSON(Map<String, dynamic> json) {
    return Ayat(
        text: json['text'],
        number: json['numberInSurah'],
        number_ayahs: json['number']);
  }
}

// ======================================================================= //

class SurahsListEnAsad {
  final List<Surah> surahs;

  SurahsListEnAsad({this.surahs});

  factory SurahsListEnAsad.fromJSON(Map<String, dynamic> json) {
    Iterable surahlist = json['data']['surahs'];
    List<Surah> surahsList = surahlist.map((i) => Surah.fromJSON(i)).toList();

    return SurahsListEnAsad(surahs: surahsList);
  }
}

class SurahAsad {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayat> ayahs;
  final String text;

  SurahAsad(
      {this.number,
      this.revelationType,
      this.name,
      this.ayahs,
      this.englishName,
      this.englishNameTranslation,
      this.text});

  factory SurahAsad.fromJSON(Map<String, dynamic> json) {
    Iterable ayahs = json['ayahs'];
    List<Ayat> ayahsList = ayahs.map((e) => Ayat.fromJSON((e))).toList();

    return SurahAsad(
        name: json['name'],
        number: json['number'],
        englishName: json['englishName'],
        revelationType: json['revelationType'],
        englishNameTranslation: json['englishNameTranslation'],
        ayahs: ayahsList,
        text: json['text']);
  }
}

class AyatAsad {
  final String text;
  final int number;
  AyatAsad({this.text, this.number});

  factory AyatAsad.fromJSON(Map<String, dynamic> json) {
    return AyatAsad(text: json['text'], number: json['numberInSurah']);
  }
}

// To parse this JSON data, do
//
//     final ayatListAlafasy = ayatListAlafasyFromJson(jsonString);

List<AyatListAlafasy> ayatListAlafasyFromJson(String str) =>
    List<AyatListAlafasy>.from(
        json.decode(str).map((x) => AyatListAlafasy.fromJson(x)));

String ayatListAlafasyToJson(List<AyatListAlafasy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AyatListAlafasy {
  AyatListAlafasy({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
  });

  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  TempatTurun tempatTurun;
  String arti;
  String deskripsi;
  String audio;

  factory AyatListAlafasy.fromJson(Map<String, dynamic> json) =>
      AyatListAlafasy(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: tempatTurunValues.map[json["tempat_turun"]],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
      };
}

enum TempatTurun { MEKAH, MADINAH }

final tempatTurunValues =
    EnumValues({"madinah": TempatTurun.MADINAH, "mekah": TempatTurun.MEKAH});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
