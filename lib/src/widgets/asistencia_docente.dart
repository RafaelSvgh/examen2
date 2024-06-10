import 'dart:ffi';

import 'package:flutter/material.dart';

Widget horarioDocente(
    String fecha, String horaInicio, String horaFin, dynamic estado) {
  bool check = false;
  if (estado == '1') {
    check = true;
  }
  return CheckboxListTile(
    value: check,
    onChanged: (value) {},
    title: Text(fecha),
    subtitle: Text('$horaInicio - $horaFin'),
    dense: true,
  );
}
