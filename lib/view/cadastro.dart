import 'package:flutter/material.dart';
import 'package:projeto_final/view/sobre.dart';
import '../controller/controller.dart';
import 'package:projeto_final/model/user_model.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // === CONTROLLERS ADICIONADOS PARA TODOS OS CAMPOS ===
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // ==========================================================

  final LoginController _controller = LoginController();

  // === FUNÇÕES DE VALIDAÇÃO ===

  // Validação de E-mail simples
  bool _isEmailValid(String email) {
    // Regex simples para verificar o formato básico de e-mail (ex: a@b.com)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Validação de Telefone simples (exige 10 ou 11 dígitos, ignorando caracteres não numéricos)
  bool _isPhoneValid(String phone) {
    final numericPhone = phone.replaceAll(RegExp(r'\D'), '');
    // Considera telefones fixos (8 dígitos + DDD 2) ou celulares (9 dígitos + DDD 2)
    return numericPhone.length >= 10 && numericPhone.length <= 11;
  }

  // Lógica principal de cadastro e validação
  void _registerUser() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final phone = _phoneController.text;

    // 1. Verificar se as senhas são iguais
    if (password != confirmPassword) {
      _showSnackBar("Erro: As senhas não coincidem.", Colors.red);
      return;
    }

    // 2. Verificar se a senha está vazia (adicionado como boa prática)
    if (password.isEmpty) {
      _showSnackBar("Erro: A senha não pode ser vazia.", Colors.red);
      return;
    }

    // 3. Verificar o formato do E-mail
    if (!_isEmailValid(email)) {
      _showSnackBar("Erro: Por favor, insira um e-mail válido.", Colors.red);
      return;
    }

    // 4. Verificar o formato do Telefone
    if (!_isPhoneValid(phone)) {
      _showSnackBar(
        "Erro: Telefone inválido. Deve ter 10 ou 11 dígitos com DDD.",
        Colors.red,
      );
      return;
    }

    // Se todas as validações passarem:
    // 5. É Prosseguido para o cadastro

    _showSnackBar("Cadastrado com sucesso! ✅", Colors.green);

    // Navegação para a rota definida
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SobrePage()),
    );
  }

  // Função auxiliar para exibir SnackBar
  void _showSnackBar(String message, Color color) {
    // Remove qualquer snackbar anterior antes de mostrar um novo
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Adicionado SingleChildScrollView para evitar overflow
      body: SingleChildScrollView(
        child: Column(
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
                    "Cadastro",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Campos de login
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _nameController,
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
                  const SizedBox(height: 15),
                  const Text("E-mail", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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

                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
                  const Text(
                    "Confirmar a Senha",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _confirmPasswordController,
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
                  const SizedBox(height: 15),
                  const Text("Telefone", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
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
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
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
                      // AQUI É ONDE CHAMAMOS A FUNÇÃO DE VALIDAÇÃO
                      onPressed: _registerUser,

                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
