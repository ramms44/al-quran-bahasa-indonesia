import 'package:flutter/material.dart';
import 'package:quran/src/animations/bottomAnimation.dart';
import 'package:quran/src/components/colors.dart';
import 'package:quran/src/controller/quranAPI.dart';
import 'package:quran/src/customWidgets/backBtn.dart';
import 'package:quran/src/customWidgets/customImagePos.dart';
import 'package:quran/src/customWidgets/loadingShimmer.dart';
import 'package:quran/src/customWidgets/title.dart';
import 'package:quran/src/pages/surahas/ayahs_view.dart';
import 'package:quran/src/pages/surahas/surahIndex_view.dart';

class Surah extends StatefulWidget {
  final String title;
  const Surah({Key key, this.title}) : super(key: key);

  @override
  _SurahState createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          FutureBuilder(
            future: QuranAPI().getSurahList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return LoadingShimmer(
                  text: "Surahs",
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasData) {
                return const Center(
                    child:
                        Text("Connectivity Error! Please Try Again Later :)"));
              } else if (snapshot.hasData == null) {
                return const Center(
                    child: Text(
                        "Connectivity Error! Please Check your Internet Connection"));
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "Something went wrong on our side!\nWe are trying to reconnect :)",
                  textAlign: TextAlign.center,
                ));
              } else if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, 0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color(0xffee8f8b),
                        height: 2.0,
                      );
                    },
                    itemCount: snapshot.data.surahs.length,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                        ListTile(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => SurahInformation(
                                surahNumber: snapshot.data.surahs[index].number,
                                arabicName:
                                    "${snapshot.data.surahs[index].name}",
                                englishName:
                                    "${snapshot.data.surahs[index].englishName}",
                                ayahs: snapshot.data.surahs[index].ayahs.length,
                                revelationType:
                                    "${snapshot.data.surahs[index].revelationType}",
                                englishNameTranslation:
                                    "${snapshot.data.surahs[index].englishNameTranslation}",
                              ),
                            );
                          },
                          leading: Text(
                            "${snapshot.data.surahs[index].number}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          title: Text(
                            "${snapshot.data.surahs[index].englishName}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          subtitle: Text(
                              "${snapshot.data.surahs[index].englishNameTranslation}"),
                          trailing: Text(
                            "${snapshot.data.surahs[index].name}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SurahAyats(
                                  ayatsList: snapshot.data.surahs[index].ayahs,
                                  surahName: snapshot.data.surahs[index].name,
                                  surahEnglishName:
                                      snapshot.data.surahs[index].englishName,
                                  englishMeaning: snapshot.data.surahs[index]
                                      .englishNameTranslation,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("Connectivity Error! Please Try Again Later"),
                );
              }
            },
          ),
          CustomImage(
            opacity: 0.3,
            height: height * 0.17,
            networkImgURL:
                'https://user-images.githubusercontent.com/43790152/115107331-a3a58d00-9f83-11eb-86f9-8bbbcd3ec96f.png',
          ),
          BackBtn(),
          CustomTitle(
            title: "Surah Index",
          ),
          Container(),
        ],
      ),
    ));
  }
}
