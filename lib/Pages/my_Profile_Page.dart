import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  final String correo;

  const MyProfilePage({super.key, required this.correo});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String nombre = '';
  String fechaNacimiento = '';
  String tipoNegocio = '';
  String correo = '';

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final c = widget.correo;

    setState(() {
      nombre = prefs.getString('nombre_$c') ?? 'Desconocido';
      fechaNacimiento = prefs.getString('fechaNacimiento_$c') ?? 'Desconocida';
      tipoNegocio = prefs.getString('tipoNegocio_$c') ?? 'No especificado';
      correo = prefs.getString('correo_$c') ?? c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre: $nombre", style: TextStyle(fontSize: 18)),
            Text("Correo: $correo", style: TextStyle(fontSize: 18)),
            Text("Fecha de nacimiento: $fechaNacimiento", style: TextStyle(fontSize: 18)),
            Text("Tipo de negocio: $tipoNegocio", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
