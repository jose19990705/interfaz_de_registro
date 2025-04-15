import 'package:flutter/material.dart';
import 'package:interfaz_de_registro/Pages/my_Profile_Page.dart';
import 'package:interfaz_de_registro/Pages/sing_Up_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  final _user = TextEditingController();
  final _password = TextEditingController();

  bool _oscuro = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.jpg', width: 150, height: 150),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _user,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    labelText: "Usuario",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  obscureText: _oscuro,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _oscuro ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _oscuro = !_oscuro;
                        });
                      },
                    ),
                    labelText: "Contraseña",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final correoIngresado = _user.text;
                    final contrasenaIngresada = _password.text;

                    final contrasenaGuardada = prefs.getString(
                      'contraseña_$correoIngresado',
                    );

                    if (contrasenaGuardada != null &&
                        contrasenaGuardada == contrasenaIngresada) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  MyProfilePage(correo: correoIngresado),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text(
                                "Usuario o contraseña incorrectos o no registrados.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                      );
                    }
                  },

                  child: const Text("Inicia sesión"),
                ),

                //En este apartado se tiene el registro de usuario
                const SizedBox(height: 16),

                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingUpPage(),
                      ),
                    );
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
