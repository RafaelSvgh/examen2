import 'package:examen2/src/models/docente.dart';
import 'package:examen2/src/models/usuario.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget datosDeUsuario(WidgetRef ref) {
  Usuario usuario = ref.watch(usuarioProvider);
  Docente docente = ref.watch(docenteProvider);
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(color: Colors.grey),
    accountName:
        Text('${docente.apellidoP} ${docente.apellidoM} ${docente.nombre}'),
    accountEmail: Text(usuario.username),
    currentAccountPicture: ClipOval(
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: Icon(
          Icons.person,
          size: 60.0,
          color: Colors.grey.shade800,
        ),
      ),
    ),
  );
}
