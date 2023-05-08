import 'package:fltn_app/consts/colorsTheme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingCallAPi({String? contentLoading}) {
  return Center(
      child: LoadingAnimationWidget.discreteCircle(
          secondRingColor: logoOrange,
          thirdRingColor: logoGreen,
          color: logoGreen,
          size: 40));
}
