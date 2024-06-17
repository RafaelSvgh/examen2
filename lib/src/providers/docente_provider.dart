import 'package:examen2/src/models/asistencia.dart';
import 'package:examen2/src/models/carga_horaria.dart';
import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/models/usuario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usuarioProvider = StateProvider<Usuario>(
  (ref) {
    return Usuario(message: "", token: "", username: "");
  },
);

final docenteProvider = StateProvider<Docente>(
  (ref) {
    return Docente(id: 0, nombre: "", apellidoP: "", apellidoM: "");
  },
);
final cargaHorariaProvider = StateProvider<CargaHorarias>(
  (ref) {
    return CargaHorarias();
  },
);

final asistenciaProvider = StateProvider<List<Asistencia>>(
  (ref) {
    return [];
  },
);
