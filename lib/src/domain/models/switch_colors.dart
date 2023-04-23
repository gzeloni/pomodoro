import 'package:flutter/material.dart';
import 'package:pomodoro/src/utils/constants/colors.dart';

Color colorData50(int indexOf) {
  return indexOf == 0
      ? CustomColors.red50
      : indexOf == 1
          ? CustomColors.blue50
          : indexOf == 2
              ? CustomColors.green50
              : Colors.white;
}

Color colorData200(int indexOf) {
  return indexOf == 0
      ? CustomColors.red200
      : indexOf == 1
          ? CustomColors.blue200
          : indexOf == 2
              ? CustomColors.green200
              : Colors.white;
}

Color colorData400(int indexOf) {
  return indexOf == 0
      ? CustomColors.red400
      : indexOf == 1
          ? CustomColors.blue400
          : indexOf == 2
              ? CustomColors.green400
              : Colors.white;
}

Color colorData800(int indexOf) {
  return indexOf == 0
      ? CustomColors.red800
      : indexOf == 1
          ? CustomColors.blue800
          : indexOf == 2
              ? CustomColors.green800
              : Colors.white;
}

Color colorData900(int indexOf) {
  return indexOf == 0
      ? CustomColors.red900
      : indexOf == 1
          ? CustomColors.blue900
          : indexOf == 2
              ? CustomColors.green900
              : Colors.white;
}
