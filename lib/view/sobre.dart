import 'package:flutter/material.dart';
//import 'package:flut/view/sobre_view.dart';
import '../controller/controller.dart';
import '../model/user_model.dart';
//import 'cadastro_view.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cabeçalho vermelho
          Container(
            color: Colors.red,
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage("lib/image/logo.png"),
                  width: 200,
                  height: 200,
                ),
                Text(
                  "EVENTOON",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Sobre o Aplicativo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Corpo do texto sobre o aplicativo
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "O aplicativo Eventoon nasceu com o propósito de centralizar todos os "
                "eventos de Ribeirão Preto em um único lugar. Nosso objetivo é "
                "facilitar a forma como as pessoas descobrem e acessam os eventos "
                "de sua preferência, de maneira rápida, prática e organizada — "
                "sem a necessidade de buscar informações dispersas em diferentes "
                "canais, como WhatsApp, Instagram, entre outros.\n\n"
                "Mais do que reunir eventos, buscamos conectar pessoas, "
                "promover encontros e contribuir para reduzir a sensação de "
                "solidão que tem se tornado cada vez mais presente em nossa sociedade.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
