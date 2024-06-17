import 'package:dio/dio.dart';
import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> updateAsistencia(int id, String fecha, String estado, String hora, String observacion, int horarioId) async {
  Dio dio = Dio();

  String? token = await getToken();

  try {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response =
        await dio.put('http://10.0.2.2:8080/api/asistencia/update/$id', 
        data: {
          "id": id,
          "estado": estado,
          "fecha": fecha,
          "hora": hora,
          "observacion": observacion,
          "horario": {
            "id": horarioId
          }
    });

  } catch (e) {
    print('Error en la petición: $e');
  }
}
