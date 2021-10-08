import 'package:flutter/material.dart';
import 'package:quran/src/customWidgets/appVersion.dart';
import 'package:quran/src/customWidgets/backBtn.dart';
import 'package:quran/src/customWidgets/customImagePos.dart';
import 'package:quran/src/customWidgets/title.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // CustomImage(
            //   networkImgURL:
            //       "https://user-images.githubusercontent.com/43790152/115107801-8625f280-9f86-11eb-9d8b-2b1cc74a5796.png",
            //   opacity: 0.5,
            //   height: MediaQuery.of(context).size.height * 0.18,
            // ),
            BackBtn(),
            CustomTitle(title: "Help Guide"),
            HelpGuide(),
            AppVersion(),
          ],
        ),
      ),
    );
  }
}

class HelpGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, height * 0.1),
      child: ListView(
        children: <Widget>[
          GuideContainer(
            guideNo: 1,
            title: "Internet Connectivity",
            guideDescription:
                "For now, the app is NOT available in Offline reading mode. So, internet connection is a must for getting all the data.",
          ),
          GuideContainer(
            title: "Juzz - Surah Index",
            guideNo: 2,
            guideDescription:
                "Open any Juzz, Surah or Sajda directly from index. It has all 30 chapters and 114 surahs." +
                    " Press and hold any Surah for viewing a brief information about it.",
          ),
          GuideContainer(
            guideNo: 5,
            title: "Rate & Feedback",
            guideDescription:
                "You can give your precious feedback and rate our app on Google play store.",
          ),
          GuideContainer(
            guideNo: 6,
            title: "Reporting a Mistake",
            guideDescription:
                "If you see any mistake in context of this Holy Book please report at the following link:" +
                    "\n\nhttps://api.alquran.cloud",
          ),
        ],
      ),
    );
  }
}

class GuideContainer extends StatelessWidget {
  final String title;
  final String guideDescription;
  final int guideNo;

  GuideContainer(
      {@required this.guideNo,
      @required this.title,
      @required this.guideDescription});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "\n$guideNo. $title",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            guideDescription,
            textAlign: TextAlign.justify,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.020),
          ),
        ],
      ),
    );
  }
}
