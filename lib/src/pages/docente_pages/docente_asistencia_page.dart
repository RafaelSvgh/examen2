import 'package:examen2/src/pages/docente_pages/docente_materias_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_perfil_page.dart';
import 'package:examen2/src/pages/login/login_page.dart';
import 'package:examen2/src/widgets/asistencia_docente.dart';
import 'package:examen2/src/widgets/datos_usuario.dart';
import 'package:flutter/material.dart';

class DocenteAsistenciaPage extends StatefulWidget {
  const DocenteAsistenciaPage({super.key});

  @override
  State<DocenteAsistenciaPage> createState() => _DocenteAsistenciaPageState();
}

class _DocenteAsistenciaPageState extends State<DocenteAsistenciaPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const DocentePage(),
      const DocentePerfilPage(),
      const DocenteMateriasPage(),
      const LoginPage()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistencia'),
        centerTitle: true,
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
          final item = pages[index];
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => item));
        },
        children: [
          datosDeUsuario(
              'rafael.salvatierra@ficct.uagrm.edu', 'Salvatierra Valle Rafael'),
          const NavigationDrawerDestination(
              icon: Icon(Icons.home), label: Text('Inicio')),
          const NavigationDrawerDestination(
              icon: Icon(Icons.account_circle), label: Text('Perfil')),
          const NavigationDrawerDestination(
              icon: Icon(Icons.auto_stories), label: Text('Materias')),
          const SizedBox(
            height: 200.0,
          ),
          const NavigationDrawerDestination(
              icon: Icon(Icons.logout), label: Text('Cerrar Sesión')),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Marcar asistencia'),
        icon: const Icon(Icons.check_circle),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 60.0, left: 15.0),
        child: ListView(
          children: [
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '0'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '0'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '0'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '0'),
            horarioDocente('Martes 25 de mayo', '16:00', '18:15', '1'),
          ],
        ),
      ),
    );
  }
}
