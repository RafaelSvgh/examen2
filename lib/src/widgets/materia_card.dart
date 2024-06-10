import 'package:flutter/material.dart';

Widget tarjetaMateria(String gestion, String materia, String grupo) {
  return Container(
    width: 170.0,
    height: 210.0,
    margin: const EdgeInsets.all(7.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      border: Border.all(
          color: const Color.fromARGB(224, 158, 158, 158).withOpacity(0.4)),
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
          child: Image.network(
            "https://img.freepik.com/vector-gratis/fondo-degradado-lineas-azules-dinamicas_23-2148995756.jpg?t=st=1717188717~exp=1717192317~hmac=dfb1587598579db60d4921f74a7a9812fa7244cfb4089b13ed149d5237122346&w=996",
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text('[$gestion] $materia - $grupo')),
        TextButton(onPressed: () {}, child: const Text('Ver asistencia'))
      ],
    ),
  );
}
