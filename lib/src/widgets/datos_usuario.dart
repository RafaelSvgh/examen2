import 'package:flutter/material.dart';

Widget datosDeUsuario(String correo, String nombre) {
  return UserAccountsDrawerHeader(
    accountName: Text(nombre),
    accountEmail: Text(correo),
    currentAccountPicture: ClipOval(
      child: CircleAvatar(
        child: Icon(
          Icons.person,
          size: 60.0,
          color: Colors.grey.shade800,
        ),
      ),
    ),
  );
}
