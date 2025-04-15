import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String _name = '';
  String _email = '';
  String _typeBusiness = '';
  String _bornDate = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Cargar los datos desde SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('nombre') ?? '';
      _email = prefs.getString('correo') ?? '';
      _typeBusiness = prefs.getString('tipoNegocio') ?? '';
      _bornDate = prefs.getString('fechaNacimiento') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Nombre: $_name', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Correo: $_email', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Tipo de Negocio: $_typeBusiness', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Fecha de Nacimiento: $_bornDate', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
