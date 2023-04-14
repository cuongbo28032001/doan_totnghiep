import 'package:flutter/material.dart';

Widget menu(BuildContext context, icon1, titleAction, icon2, value, onclick) {
  return InkWell(
    onTap: onclick,
    child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * value,
        child: Row(
          children: [
            Icon(icon1),
            const SizedBox(
              width: 15,
            ),
            Expanded(child: Text(titleAction)),
            Icon(icon2),
          ],
        )),
  );
}
