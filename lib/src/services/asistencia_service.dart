import 'package:dio/dio.dart';
import 'package:examen2/src/models/asistencia.dart';
import 'package:examen2/src/models/carga_horaria.dart';
import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<List<Asistencia>> getAsistencias(
    WidgetRef ref, List<Horario> listas) async {
  Dio dio = Dio();
  List<Asistencia> listaCombinada = [];
  String? token = await getToken();
  dio.options.headers['Authorization'] = 'Bearer $token';
  for (Horario horario in listas) {
    final response = await dio
        .get('http://10.0.2.2:8080/api/asistencia/findHorario/${horario.id}');

    List<Asistencia> asistencias =
        Asistencias.fromJsonList(response.data).items;
    listaCombinada.addAll(asistencias);
  }
  listaCombinada.sort((a, b) => a.fecha.compareTo(b.fecha));
  ref.watch(asistenciaProvider.notifier).update((state) => listaCombinada);
  return listaCombinada;
}
