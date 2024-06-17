import 'package:dio/dio.dart';
import 'package:examen2/src/models/carga_horaria.dart';
import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/models/usuario.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> login(String username, String password, WidgetRef ref) async {
  Dio dio = Dio();

  try {
    final response = await dio.post(
      'http://10.0.2.2:8080/login',
      data: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final token = response.data['token'];
      Usuario usuario = Usuario.fromJson(response.data);
      ref.read(usuarioProvider.notifier).update(
            (state) => usuario
          );
      
      await saveToken(token);
      print('Token guardado: $token');
    } else {
      print('Error en la autenticación: ${response.statusCode}');
    }
  } catch (e) {
    print('Error en la petición: $e');
  }

//------------------------------------------------------------------------------
  String? token = await getToken();

  String user = ref.watch(usuarioProvider).username;

  try {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.get(
      'http://10.0.2.2:8080/api/docente/findUsername/$user'
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

// -----------------------------------------------------------------------------

    int id = ref.watch(docenteProvider).id;

    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response2 = await dio
          .get('http://10.0.2.2:8080/api/cargahoraria/all/$id');

      if (response2.statusCode == 200) {
        CargaHorarias cargaHorarias = CargaHorarias.fromJsonList(response2.data);
        ref
            .read(cargaHorariaProvider.notifier)
            .update((state) => cargaHorarias);

      } else {
        print('El usuario no es docente: ${response2.statusCode}');
      }
    } catch (e) {
      print('Error en la petición: $e');
    }

//------------------------------------------------------------------------------

  
  
}
