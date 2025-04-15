import 'package:flutter/material.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _close_splash_app();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            width: 150,
            height: 150,
          )
      ),
    );
  }


  Future<void>_close_splash_app() async {
    Future.delayed(const Duration(seconds:3 ),()async{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> const CalculadoraNotaPage())
      );

    });
  }
}
