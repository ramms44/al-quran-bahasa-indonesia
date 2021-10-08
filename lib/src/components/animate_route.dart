import 'package:flutter/cupertino.dart';
import 'package:quran/src/pages/surah/surah.dart';
import 'package:quran/src/pages/surahas/surahIndex_view.dart';

class AnimatedRoutes extends PageRouteBuilder {
  final Widget widget;
  final route;
  AnimatedRoutes({this.route, this.widget})
      : super(
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> seAnimation,
              Widget child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.elasticInOut);

            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> seAnimation) {
            return route();
          },
        );
}
