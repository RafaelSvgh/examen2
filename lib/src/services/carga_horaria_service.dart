import 'package:dio/dio.dart';
import 'package:examen2/src/models/carga_horaria.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<CargaHorarias?> getCargaHoraria(WidgetRef ref) async {
  Dio dio = Dio();

  String? token = await getToken();

  int id = ref.watch(docenteProvider).id;

  try {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response =
        await dio.get('http://10.0.2.2:8080/api/cargahoraria/all/$id');

    if (response.statusCode == 200) {
      CargaHorarias cargaHoraria = CargaHorarias.fromJsonList(response.data);
      ref.read(cargaHorariaProvider.notifier).update((state) => cargaHoraria);
      return cargaHoraria;
    } else {
      print('El usuario no es docente: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error en la petición: $e');
  }
}
