import 'package:dio/dio.dart';
import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> getDocente(WidgetRef ref) async {
  Dio dio = Dio();

  String? token = await getToken();

  String username = ref.watch(usuarioProvider).username;

  try {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.get(
      'http://10.0.2.2:8080/api/docente/findUsername/$username'
    );

    if (response.statusCode == 200) {
      Docente docente = Docente.fromJson(response.data);
      ref.read(docenteProvider.notifier).update((state) => docente);
    } else {
      print('El usuario no es docente: ${response.statusCode}');
    }
  } catch (e) {
    print('Error en la petición: $e');
  }
}
