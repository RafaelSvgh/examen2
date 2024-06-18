import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:examen2/src/models/asistencia.dart';
import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> reporteExcel(List<Asistencia> asistencias) async {
  Dio dio = Dio();

  String? token = await getToken();

  String jsonBody =
      jsonEncode(asistencias.map((asistencia) => asistencia.toJson()).toList());

  try {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response =
        await dio.post('http://3.88.182.80/api/examenexcel', data: jsonBody);

    if (response.statusCode == 200) {
      String data = response.data;
      return data;
    }
    return "";
  } catch (e) {
    print('Error en la petición: $e');
    return "Error en la peticion";
  }
}
