import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../consts/colorsTheme.dart';

renderDate(
    {TextEditingController? controller, Function? onChanged, String? label}) {
  DateFormat format = DateFormat("yyyy-MM-dd");
  return Column(
    children: [
      DateTimeField(
        onChanged: (value) {
          if (onChanged != null) {
            onChanged(value.toString());
          }
        },
        style: TextStyle(color: logoGreen),
        controller: controller ?? TextEditingController(),
        format: format,
        resetIcon: Icon(
          Icons.close,
          size: 18,
          color: logoGreen,
        ),
        decoration: InputDecoration(
            labelText: label!,
            labelStyle: const TextStyle(color: Colors.black),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: logoGreen),
            )),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1950),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 6),
            locale: const Locale("vi", "VN"),
            builder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      background: logoGreen,
                      onBackground: Colors.white,
                      primary: logoGreen,
                    ),
                  ),
                  child: child!);
            },
          );
        },
      ),
    ],
  );
}
