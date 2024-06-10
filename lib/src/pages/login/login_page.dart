import 'package:examen2/src/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
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
                          Color.fromARGB(255, 144, 167, 185),
                          Color.fromARGB(255, 61, 95, 113)
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
                    Icons.how_to_reg,
                    size: 80.0,
                    color: Color.fromARGB(217, 255, 255, 255),
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Center(
                      child: Text(
                    'DOCENTES',
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
                                  label: 'Correo Electrónico',
                                  hint: 'correo',
                                  icon: Icons.alternate_email,
                                  onChanged: (value) => email = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese un correo';
                                    }
                                    final emailRegExp = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (!emailRegExp.hasMatch(value)) {
                                      return 'Formato de correo no válido';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                LoginForm(
                                  label: 'Contraseña',
                                  hint: 'contraseña',
                                  icon: Icons.lock_person,
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
                            },
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Color.fromARGB(255, 70, 112, 148))),
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
