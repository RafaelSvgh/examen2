import 'package:examen2/src/pages/docente_pages/docente_asistencia_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_page.dart';
import 'package:examen2/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      initialRoute: 'asistencia',
      routes: {
        'docente': (BuildContext context) => const DocentePage(),
        'login': (BuildContext context) => const LoginPage(),
        'asistencia': (BuildContext context) => const DocenteAsistenciaPage(),
      },
    );
  }
}
