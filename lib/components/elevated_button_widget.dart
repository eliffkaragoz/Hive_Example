import 'package:flutter/material.dart';

class ElevatedButtonWidget extends ElevatedButton {
  late final BuildContext context;
  late final VoidCallback onPres;
  late final String text;
  late final Color buttonColor;
  late final Color textColor;
  late final double buttonHeight;
  late final double buttonWeight;
  ElevatedButtonWidget(
      {Key? key,
        required this.context,
        required this.onPres,
        required this.text,
        this.buttonColor = const Color(0xFFFEB800),
        this.textColor = const Color(0xFFFFFFFF),
        this.buttonHeight = 50,
        this.buttonWeight = 130})
      : super(
    key: key,
    onPressed: onPres,
    child: Text(
      text,
      style: TextStyle(
        // TextStyle temadan gelecek şimdilik böyle kalsın
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: textColor,
      ),
    ),
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        primary: buttonColor,
        fixedSize: Size(buttonWeight, buttonHeight)),
  );
}
