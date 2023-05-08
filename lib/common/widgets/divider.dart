import 'package:fltn_app/consts/colorsTheme.dart';
import 'package:flutter/material.dart';

divider({required BuildContext context, double? height, double? opacity}) {
  return Divider(
    thickness: 0.5,
    color: logoGreen.withOpacity(opacity ?? 0.3),
  );
}
