import 'package:fltn_app/consts/colorsTheme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputFormWidget extends StatefulWidget {
  TextEditingController? controller;
  bool? obscureText;
  bool? note;
  bool? redonly;
  String? label;
  Function? callback;
  dynamic valid;
  int? maxLines;
  String? suffix;

  InputFormWidget(
      {super.key,
      this.controller,
      this.label,
      this.callback,
      this.obscureText,
      this.valid,
      this.note,
      this.redonly,
      this.maxLines,
      this.suffix});

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      maxLines: widget.maxLines ?? 1,
      readOnly: widget.redonly ?? false,
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      style: TextStyle(
          color: (widget.redonly == true)
              ? logoGreen.withOpacity(0.7)
              : logoGreen),
      decoration: InputDecoration(
        suffixText: widget.suffix,
        suffixStyle: TextStyle(color: logoGreen),
        border: (widget.maxLines == null)
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: logoGreen,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gapPadding: 1.0,
              )
            : const UnderlineInputBorder(),
        label: Wrap(
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
        focusedBorder: (widget.maxLines == null)
            ? ((widget.redonly == true)
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: logoGreen),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: logoOrange),
                  ))
            : ((widget.redonly == true)
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: logoGreen,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(
                      color: logoOrange,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    gapPadding: 1.0,
                  )),
        enabledBorder: (widget.maxLines == null)
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: logoGreen),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: logoGreen,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gapPadding: 1.0,
              ),
        focusedErrorBorder: (widget.maxLines == null)
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              )
            : const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gapPadding: 1.0,
              ),
        errorBorder: (widget.maxLines == null)
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              )
            : const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gapPadding: 1.0,
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
