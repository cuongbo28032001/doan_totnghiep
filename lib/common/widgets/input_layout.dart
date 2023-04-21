import 'package:fltn_app/consts/colorsTheme.dart';
import 'package:flutter/material.dart';

class InputFormWidget extends StatefulWidget {
  TextEditingController? controller;
  bool? obscureText;
  bool? note;
  bool? redonly;
  String? label;
  Function? callback;
  dynamic valid;

  InputFormWidget(
      {super.key,
      this.controller,
      this.label,
      this.callback,
      this.obscureText,
      this.valid,
      this.note,
      this.redonly});

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.redonly ?? false,
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      style: TextStyle(
          color: (widget.redonly == true)
              ? logoGreen.withOpacity(0.7)
              : logoGreen),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        label: Row(
          children: [
            Text(widget.label ?? ''),
            if (widget.note != null)
              const Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 20),
              )
          ],
        ),
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: (widget.redonly == true)
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: logoGreen),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: logoOrange, width: 1.5),
              ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: logoGreen),
        ),
      ),
      validator: widget.valid,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        if (widget.callback != null) {
          widget.callback!(value);
        }
      },
    );
  }
}
