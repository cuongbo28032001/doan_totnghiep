import 'package:flutter/material.dart';

Widget loadingCallAPi({String? contentLoading}) {
  return Container(
    margin: EdgeInsets.only(top: 150),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            contentLoading ?? "Loading...",
            style: const TextStyle(color: Color.fromARGB(255, 78, 78, 78), fontSize: 16),
          ),
        )
      ],
    ),
  );
}
