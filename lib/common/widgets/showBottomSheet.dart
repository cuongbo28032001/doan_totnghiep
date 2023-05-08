import 'package:flutter/material.dart';

class ShowBottomSheet extends StatefulWidget {
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final pageScreen;
  const ShowBottomSheet({super.key, required this.title, this.pageScreen});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showBottom(context, widget.title, widget.pageScreen),
    );
  }

  showBottom(BuildContext context, title, pageScreen) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          //_optionDate = false;
          return FractionallySizedBox(heightFactor: 0.5, child: pageScreen);
        });
  }
}
