import 'package:flutter/material.dart';
import 'package:quran/src/components/colors.dart';

class HomeButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPress;
  const HomeButton({Key key, this.buttonName, this.onPress}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _HomeButtonState createState() => _HomeButtonState(buttonName, onPress);
}

class _HomeButtonState extends State<HomeButton> {
  final String buttonName;
  final onPress;

  _HomeButtonState(this.buttonName, this.onPress);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(7),
      child: ButtonTheme(
        minWidth: width * 0.6,
        height: height * 0.06,
        // ignore: deprecated_member_use
        child: OutlineButton(
          highlightedBorderColor: colors.light_brown,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Text(
            buttonName,
            style: const TextStyle(
              color: colors.light_brown_2,
            ),
          ),
          borderSide: const BorderSide(
            color: colors.defaul_2_brown,
            // style: BorderStyle.solid,
            width: 1.8,
          ),
          onPressed: () {
            onPress();
            // print('press baca quran');
          },
        ),
      ),
    );
  }
}
