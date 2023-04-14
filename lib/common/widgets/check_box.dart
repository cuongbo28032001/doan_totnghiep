import 'package:fltn_app/common/widgets/divider.dart';
import 'package:fltn_app/consts/colorsTheme.dart';
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  final Widget? content;
  final bool? value;
  final Function? handleSelected;
  const CheckBoxWidget(
      {super.key, this.content, this.value, this.handleSelected});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Transform.scale(
            scale: 1.12,
            child: Checkbox(
                fillColor: MaterialStatePropertyAll(logoGreen.withOpacity(0.3)),
                checkColor: logoGreen,
                side: BorderSide(color: logoGreen, width: 1),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                value: widget.value ?? false,
                onChanged: (val) {
                  widget.handleSelected!(val);
                }),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (widget.content != null) Expanded(child: widget.content!),
      ],
    );
  }
}
