import 'package:flutter/material.dart';
//import 'package:flut/view/sobre_view.dart';
import '../controller/controller.dart';
import '../model/user_model.dart';
import '../view/eventos.dart';
//import 'cadastro_view.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    // Definindo a cor do cabeçalho e botão
    const Color primaryRed = Color(
      0xFFE9443D,
    ); // Cor mais próxima do vermelho da imagem

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cabeçalho vermelho
          Container(
            color: primaryRed,
            // Usando Media Query para altura adaptável, se necessário, mas 300 é ok.
            height: 315,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Adicionei um SafeArea aqui para evitar que o conteúdo se sobreponha à barra de status
                SafeArea(
                  child: Column(
                    children: const [
                      // LOGO (Mantenha o asset original 'lib/image/logo.png')
                      Image(
                        image: AssetImage("lib/image/logo.png"),
                        width:
                            150, // Ajustado para ficar mais fiel ao tamanho da imagem
                        height: 150,
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
              ],
            ),
          ),

          // <--- LINHA REMOVIDA PARA SUBIR O BOTÃO --->
          // const SizedBox(height: 20),

          // Corpo do texto sobre o aplicativo
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
              ), // Padding geral
              child: const Text(
                "O aplicativo Eventoon nasceu com o propósito de centralizar todos os eventos de Ribeirão Preto em um único lugar. Nosso objetivo é facilitar a forma como as pessoas descobrem e acessam os eventos de sua preferência, de maneira rápida, prática e organizada — sem a necessidade de buscar informações dispersas em diferentes canais, como WhatsApp, Instagram, entre outros.\n\n"
                "Mais do que reunir eventos, buscamos conectar pessoas, promover encontros e contribuir para reduzir a sensação de solidão que tem se tornado cada vez mais presente em nossa sociedade.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),

          // Botão de voltar (Padding ajustado para garantir que não fique grudado)
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 0,
              bottom: 40,
            ), // Ajustado o bottom para empurrar o botão para cima
            child: ElevatedButton(
              onPressed: () {
                // Presumi que 'HomeScreen' é a tela de eventos anterior
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed, // Usando a cor do cabeçalho
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0, // Removendo a sombra do botão
              ),
              child: const Text(
                "Começar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
