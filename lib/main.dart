import 'package:examen2/src/pages/docente_pages/docente_asistencia_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_page.dart';
import 'package:examen2/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/La_Paz'));
  runApp(const ProviderScope(child: MyApp()));
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
      initialRoute: 'login',
      routes: {
        'docente': (BuildContext context) => const DocentePage(),
        'login': (BuildContext context) => const LoginPage(),
        'asistencia': (BuildContext context) => const DocenteAsistenciaPage(),
      },
    );
  }
}
