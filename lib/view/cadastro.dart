import 'package:flutter/material.dart';
import 'package:projeto_final/view/sobre.dart';
import '../controller/controller.dart';
import '../model/user_model.dart';
//import 'cadastro_view.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Cabeçalho vermelho
          Container(
            color: Colors.red,
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                /*
                Icon(Icons.hexagon, size: 80, color: Colors.black),
                SizedBox(height: 10),
                
                */
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
                  "LOGiiiIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Campos de login
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nome", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const Text("E-mail", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),
                const Text("Senha", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Confirmar a Senha",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Login social

                // Botão entrar
              ],
            ),
          ),
          // Rodapé cadastrar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white24)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cadastrado com sucesso!"),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SobrePage()),
                      );
                    },
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
