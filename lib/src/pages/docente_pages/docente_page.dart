import 'package:dio/dio.dart';
import 'package:examen2/src/models/carga_horaria.dart';
import 'package:examen2/src/pages/docente_pages/docente_asistencia_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_materias_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_perfil_page.dart';
import 'package:examen2/src/pages/login/login_page.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/security/token_security.dart';
import 'package:examen2/src/services/asistencia_service.dart';
import 'package:examen2/src/services/carga_horaria_service.dart';
import 'package:examen2/src/services/docente_service.dart';
import 'package:examen2/src/widgets/datos_usuario.dart';
import 'package:examen2/src/widgets/materia_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocentePage extends ConsumerStatefulWidget {
  const DocentePage({super.key});

  @override
  DocentePageState createState() => DocentePageState();
}

class DocentePageState extends ConsumerState<DocentePage> {
  int index = 0;
  CargaHorarias? cargaHorarias;

  @override
  void initState() {
    super.initState();
    getDocente(ref);
    getCargaHoraria(ref);
  }

  @override
  Widget build(BuildContext context) {
    final docente = ref.watch(docenteProvider);
    final CargaHoraria = ref.watch(cargaHorariaProvider);

    final pages = [
      const DocentePage(),
      const DocentePerfilPage(),
      const DocenteMateriasPage(),
      const LoginPage()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel docente'),
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
          datosDeUsuario(ref),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis materias',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15.0),
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: (ref.watch(cargaHorariaProvider).items.map((carga) {
                    return Container(
                      width: 170.0,
                      height: 210.0,
                      margin: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(224, 158, 158, 158)
                                .withOpacity(0.4)),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                            child: Image.network(
                              "https://img.freepik.com/vector-gratis/fondo-degradado-lineas-azules-dinamicas_23-2148995756.jpg?t=st=1717188717~exp=1717192317~hmac=dfb1587598579db60d4921f74a7a9812fa7244cfb4089b13ed149d5237122346&w=996",
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                  '[${carga.gestion}] ${carga.materia} - ${carga.grupo}')),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                                onPressed: () async {
                                  List<Horario> horarios = carga.horarios;
                                  getAsistencias(ref, horarios);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const DocenteAsistenciaPage()));
                                },
                                child: const Text('Ver asistencia')),
                          )
                        ],
                      ),
                    );
                  }).toList())),
            ),
          ],
        ),
      ),
    );
  }
}
