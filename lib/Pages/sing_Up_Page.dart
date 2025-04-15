import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final List<String> _businessTypes = ['Restaurante', 'Parque temático', 'Bar'];
  String? _typeBusiness = 'Restaurante';

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password=TextEditingController();

  String buttonMsg = "Fecha de nacimiento";
  DateTime _bornDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/logo.jpg'),
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nombre",
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Correo electrónico",
                  prefixIcon: Icon(Icons.mail),
                ),
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Debe ingresar un correo electrónico.";
                  } else {
                    if (!value!.isvalidEmail()) {
                      return "El correo electrónico no es válido.";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (valuec) {
                  if (valuec!.isEmpty) {
                    return "Debe ingresar una contraseña.";

                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  _showSelectedDate();
                },
                child: Text(buttonMsg),
              ),

              const SizedBox(height: 16),
              const Text('¿Cuál es su tipo de negocio?'),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _typeBusiness,
                isExpanded: true,
                items:
                    _businessTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _typeBusiness = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _onRegisterButtonClicked();
                },
                child: const Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Con el fin de validar si es mayor de edad la persona que hace el reguistro
  // Se procede con las siguientes funcionalidades.
  void _onRegisterButtonClicked() async {
    if (!_isOfLegalAge(_bornDate)) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Menor de edad"),
              content: const Text(
                "Debes tener al menos 18 años para el registro.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
      return;
    }

    // Guardar la información si es mayor de edad
    await _saveUserData();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Su registro fue exitoso"),
            content: const Text("Gracias por su registro!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cerrar"),
              ),

            ],
          ),
    );

  }

  void _showSelectedDate() async {
    final DateTime? newdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1925, 1),
      lastDate: DateTime.now(),
      helpText: "Fecha de nacimiento",
    );
    if (newdate != null) {
      setState(() {
        _bornDate = newdate;
        buttonMsg = "Fecha de nacimiento: ${_dateConverter(newdate)}";
      });
    }
  }

  String _dateConverter(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(date);
    return dateFormatted;
  }

  bool _isOfLegalAge(DateTime birthDate) {
    final today = DateTime.now();
    final age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      return age - 1 >= 18;
    }

    return age >= 18;
  }

  // Con esta función guardaré los datos del usuario.
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _name.text);
    await prefs.setString('correo', _email.text);
    await prefs.setString('contraseña', _password.text);
    await prefs.setString('fechaNacimiento', _bornDate.toIso8601String());
    await prefs.setString('tipoNegocio', _typeBusiness ?? '');
  }
}

extension on String {
  bool isvalidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}
