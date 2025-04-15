import 'package:flutter/material.dart';

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
              SizedBox(height: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}

extension on String {
  bool isvalidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}
