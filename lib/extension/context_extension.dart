import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets paddingAll({required double value}) => EdgeInsets.all(value);
}

extension PaddingExtensionOnly on BuildContext {
  EdgeInsets paddingTop({required double value}) => EdgeInsets.only(top: value);
  EdgeInsets paddingBottom({required double value}) =>
      EdgeInsets.only(bottom: value);
  EdgeInsets paddingLeft({required double value}) =>
      EdgeInsets.only(left: value);
  EdgeInsets paddingRight({required double value}) =>
      EdgeInsets.only(right: value);
}

extension PaddingExtensionSymmetric on BuildContext {
  EdgeInsets paddingSymmetric(
          {required double valueHorizontal, required double valueVertical}) =>
      EdgeInsets.symmetric(
          horizontal: valueHorizontal, vertical: valueVertical);

  EdgeInsets paddingHorizontal({required double value}) =>
      EdgeInsets.symmetric(horizontal: value);

  EdgeInsets paddingVertical({required double value}) =>
      EdgeInsets.symmetric(vertical: value);
}
