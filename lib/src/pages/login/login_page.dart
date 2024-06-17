import 'package:examen2/src/models/usuario.dart';
import 'package:examen2/src/pages/docente_pages/docente_page.dart';
import 'package:examen2/src/providers/docente_provider.dart';
import 'package:examen2/src/services/usuario_service.dart';
import 'package:examen2/src/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -100,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 93, 102, 106),
                          Color.fromARGB(255, 93, 102, 106)
                        ])),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                      child: Icon(
                    Icons.person_pin_circle,
                    size: 90.0,
                    color: Color.fromARGB(217, 255, 255, 255),
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Center(
                      child: Text(
                    'UNIV-SYS',
                    style: TextStyle(
                        fontSize: 35.0,
                        letterSpacing: 3.0,
                        color: Color.fromARGB(217, 255, 255, 255)),
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 380.0,
                    height: 400.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 7),
                        ]),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                LoginForm(
                                  label: 'Usuario',
                                  hint: 'nombre de usuario',
                                  icon: Icons.person,
                                  onChanged: (value) => username = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su nombre de usuario';
                                    }
                                    return null;
                                  },
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Ingrese un correo';
                                  //   }
                                  //   final emailRegExp = RegExp(
                                  //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  //   );
                                  //   if (!emailRegExp.hasMatch(value)) {
                                  //     return 'Formato de correo no válido';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                LoginForm(
                                  label: 'Contraseña',
                                  hint: 'contraseña',
                                  icon: Icons.lock,
                                  password: true,
                                  onChanged: (value) => password = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese una contraseña';
                                    }
                                    if (value.length < 6) {
                                      return 'Mínimo 6 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 65.0,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final isValid = _formKey.currentState!.validate();
                              if (!isValid) return;
                              await login(username, password, ref);
                              if (ref
                                  .watch(usuarioProvider)
                                  .username
                                  .isNotEmpty) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const DocentePage()));
                              } else {
                                const SnackBar(
                                  content: Text('Credenciales incorrectas'),
                                );
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Color.fromARGB(255, 102, 106, 109))),
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  height: 2.0,
                                  color: Color.fromARGB(231, 255, 255, 255),
                                  letterSpacing: 1.8),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
