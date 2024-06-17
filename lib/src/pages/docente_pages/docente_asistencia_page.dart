import 'package:examen2/src/models/asistencia.dart';
import 'package:examen2/src/pages/docente_pages/docente_page.dart';
import 'package:examen2/src/pages/docente_pages/docente_reportes_page.dart';
import 'package:examen2/src/pages/login/login_page.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/services/guardar_asistencia_service.dart';
import 'package:examen2/src/widgets/asistencia_docente.dart';
import 'package:examen2/src/widgets/datos_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DocenteAsistenciaPage extends ConsumerStatefulWidget {
  const DocenteAsistenciaPage({super.key});

  @override
  DocenteAsistenciaPageState createState() => DocenteAsistenciaPageState();
}

class DocenteAsistenciaPageState extends ConsumerState<DocenteAsistenciaPage> {
  int index = 0;
  final TextEditingController _justificacion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pages = [
      const DocentePage(),
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
          datosDeUsuario(ref),
          const NavigationDrawerDestination(
              icon: Icon(Icons.home), label: Text('Inicio')),
          const SizedBox(
            height: 400.0,
          ),
          const NavigationDrawerDestination(
              icon: Icon(Icons.logout), label: Text('Cerrar Sesión')),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          for (var asistencia in ref.watch(asistenciaProvider)) {
            if (asistencia.estado == 'F') {
              Asistencia enviarAsistencia = asistencia;
              tz.TZDateTime now =
                  tz.TZDateTime.now(tz.getLocation('America/La_Paz'));
              DateFormat dateFormat = DateFormat('yyyy-MM-dd');
              String fechaActual = dateFormat.format(now);
              String fechaClase = asistencia.fecha.toString().substring(0, 10);
              DateTime hora1 = now;
              print('${now.hour}:${now.minute}');
              DateFormat timeF = DateFormat('HH:mm');
              DateTime time = timeF.parse(asistencia.horaInicio);
              DateTime hora2 = DateTime(
                  now.year, now.month, now.day, time.hour, time.minute);
              time = timeF.parse(asistencia.horaFin);
              DateTime hora3 = DateTime(
                  now.year, now.month, now.day, time.hour, time.minute);

              if (fechaClase == fechaActual) {
                DateTime horaActual =
                    DateTime(0, 1, 1, hora1.hour, hora1.minute);
                DateTime horaInicio =
                    DateTime(0, 1, 1, hora2.hour, hora2.minute);
                DateTime horaInicioMasQuince =
                    horaInicio.add(const Duration(minutes: 15));
                DateTime horaFin = DateTime(0, 1, 1, hora3.hour, hora3.minute);

                if (horaActual.isAfter(horaInicio) &&
                    horaActual.isBefore(horaInicioMasQuince)) {
                  enviarAsistencia.estado = 'P';
                  asistencia.estado = 'P';
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 650.0,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        enviarAsistencia.estado = 'L';
                                        asistencia.estado = 'L';
                                        if (_justificacion.text.isNotEmpty) {
                                          String hora = "";
                                          if (now.minute < 10) {
                                            hora = '${now.hour}:0${now.minute}';
                                          } else {
                                            hora = '${now.hour}:${now.minute}';
                                          }
                                          if (hora.length == 4) {
                                            hora = '0$hora';
                                          }
                                          await updateAsistencia(
                                              enviarAsistencia.id,
                                              fechaActual,
                                              enviarAsistencia.estado,
                                              hora,
                                              enviarAsistencia.observacion,
                                              enviarAsistencia.horarioId);
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Licencia',
                                          style: TextStyle(fontSize: 18.0))),
                                  TextButton(
                                      onPressed: () async {
                                        String hora = "";
                                        if (now.minute < 10) {
                                          hora = '${now.hour}:0${now.minute}';
                                        } else {
                                          hora = '${now.hour}:${now.minute}';
                                        }
                                        if (hora.length == 4) {
                                            hora = '0$hora';
                                          }
                                        await updateAsistencia(
                                            enviarAsistencia.id,
                                            fechaActual,
                                            enviarAsistencia.estado,
                                            hora,
                                            enviarAsistencia.observacion,
                                            enviarAsistencia.horarioId);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Marcar Asistencia',
                                        style: TextStyle(fontSize: 18.0),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextField(
                                controller: _justificacion,
                                decoration: const InputDecoration(
                                  hintText: 'Motivo de la licencia...',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
                if (horaActual.isAfter(horaInicioMasQuince) &&
                    horaActual.isBefore(horaFin)) {
                  enviarAsistencia.estado = 'R';
                  asistencia.estado = 'R';
                  enviarAsistencia.observacion = 'atraso';
                  asistencia.observacion = 'atraso';
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 650.0,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        enviarAsistencia.estado = 'L';
                                        asistencia.estado = 'L';
                                        if (_justificacion.text.isNotEmpty) {
                                          String hora = "";
                                          if (now.minute < 10) {
                                            hora = '${now.hour}:0${now.minute}';
                                          } else {
                                            hora = '${now.hour}:${now.minute}';
                                          }
                                          if (hora.length == 4) {
                                            hora = '0$hora';
                                          }
                                          await updateAsistencia(
                                              enviarAsistencia.id,
                                              fechaActual,
                                              enviarAsistencia.estado,
                                              hora,
                                              enviarAsistencia.observacion,
                                              enviarAsistencia.horarioId);
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Licencia',
                                          style: TextStyle(fontSize: 18.0))),
                                  TextButton(
                                      onPressed: () async {
                                        String hora = "";
                                        if (now.minute < 10) {
                                          hora = '${now.hour}:0${now.minute}';
                                        } else {
                                          hora = '${now.hour}:${now.minute}';
                                        }
                                        if (hora.length == 4) {
                                            hora = '0$hora';
                                          }
                                        await updateAsistencia(
                                            enviarAsistencia.id,
                                            fechaActual,
                                            enviarAsistencia.estado,
                                            hora,
                                            enviarAsistencia.observacion,
                                            enviarAsistencia.horarioId);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Marcar Asistencia',
                                        style: TextStyle(fontSize: 18.0),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextField(
                                controller: _justificacion,
                                decoration: const InputDecoration(
                                  hintText: 'Motivo de la licencia...',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
              }
            }
          }
        },
        label: const Text('Marcar asistencia'),
        icon: const Icon(Icons.check_circle),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 60.0, left: 15.0),
        child: ListView(
            children: (ref.watch(asistenciaProvider).map((asistencia) {
          bool check = false;
          String estado = "falta";

          String fecha =
              '${asistencia.fecha.day}-${asistencia.fecha.month}-${asistencia.fecha.year}';
          if (asistencia.estado == 'P' || asistencia.estado == 'R') {
            check = true;
          }
          if (asistencia.estado == 'P') {
            estado = 'presente';
          }
          if (asistencia.estado == 'R') {
            estado = 'atraso';
          }
          if (asistencia.estado == 'L') {
            estado = 'licencia';
          }

          return SwitchListTile(
            value: check,
            onChanged: (value) {},
            title: Text('${asistencia.dia} | $fecha  | $estado'),
            subtitle: Text(
                '${asistencia.horaInicio.substring(0, 5)} - ${asistencia.horaFin.substring(0, 5)}  aula: ${asistencia.aula}|${asistencia.modulo}'),
            dense: true,
          );
        }).toList())),
      ),
    );
  }
}
