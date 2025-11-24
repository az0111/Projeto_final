import 'package:flutter/material.dart';
import 'package:projeto_final/view/sobre.dart';
import '../controller/controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final LoginController _controller = LoginController();

  bool _isLoading = false;

  // ================= VALIDAÇÕES =====================
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isPhoneValid(String phone) {
    final numericPhone = phone.replaceAll(RegExp(r'\D'), '');
    return numericPhone.length >= 10 && numericPhone.length <= 11;
  }

  // ===================== REGISTRO REAL ==========================
  void _registerUser() async {
    final nome = _nameController.text.trim();
    final email = _emailController.text.trim();
    final senha = _passwordController.text.trim();
    final confirmar = _confirmPasswordController.text.trim();
    final telefone = _phoneController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || telefone.isEmpty) {
      _showSnackBar("Preencha todos os campos.", Colors.red);
      return;
    }

    if (senha != confirmar) {
      _showSnackBar("As senhas não coincidem.", Colors.red);
      return;
    }

    if (!_isEmailValid(email)) {
      _showSnackBar("E-mail inválido.", Colors.red);
      return;
    }

    if (!_isPhoneValid(telefone)) {
      _showSnackBar("Telefone inválido.", Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Chama o controller (que contém a lógica Firebase). NÃO alterei a lógica do controller.
      final bool ok = await _controller.cadastrarUsuario(
        context: context,
        nome: nome,
        email: email,
        telefone: telefone,
        senha: senha,
      );

      // Debug em consola para você ver o retorno real
      debugPrint('cadastrarUsuario retornou: $ok');

      // Se o controller retornar true, navegamos AQUI com context válido
      if (ok && mounted) {
        // Só navega se o controller não tiver navegado já internamente.
        // Para prevenir dupla-navegação, usamos try/catch e verificamos o mounted.
        try {
          Navigator.pop(SobrePage() as BuildContext);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SobrePage()),
          );
          return;
        } catch (e) {
          debugPrint('Erro ao navegar para SobrePage: $e');
          // mesmo se houve erro na navegação, mostramos mensagem
          _showSnackBar(
            'Cadastro realizado, mas falha ao navegar: $e',
            Colors.orange,
          );
        }
      } else {
        // ok == false (controller reportou falha) — mensagem já mostrada pelo controller;
        // aqui apenas reforçamos para debugging
        _showSnackBar('Falha no cadastro. Verifique logs.', Colors.red);
      }
    } catch (e) {
      debugPrint('Exceção inesperada em _registerUser: $e');
      _showSnackBar('Erro inesperado: $e', Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ================= SNACKBAR ======================
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  // ================= UI =============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CABEÇALHO
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

            // CAMPOS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildField("Nome", _nameController),
                  buildField(
                    "E-mail",
                    _emailController,
                    keyboard: TextInputType.emailAddress,
                  ),
                  buildField("Senha", _passwordController, obscure: true),
                  buildField(
                    "Confirmar Senha",
                    _confirmPasswordController,
                    obscure: true,
                  ),
                  buildField(
                    "Telefone",
                    _phoneController,
                    keyboard: TextInputType.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BOTÃO CADASTRAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _registerUser,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          "Cadastrar",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.red.shade900,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:projeto_final/view/sobre.dart';
import '../controller/controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final LoginController _controller = LoginController();

  // ================= VALIDAÇÕES =====================
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isPhoneValid(String phone) {
    final numericPhone = phone.replaceAll(RegExp(r'\D'), '');
    return numericPhone.length >= 10 && numericPhone.length <= 11;
  }

  // ===================== REGISTRO REAL ==========================
  void _registerUser() async {
    final nome = _nameController.text.trim();
    final email = _emailController.text.trim();
    final senha = _passwordController.text.trim();
    final confirmar = _confirmPasswordController.text.trim();
    final telefone = _phoneController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || telefone.isEmpty) {
      _showSnackBar("Preencha todos os campos.", Colors.red);
      return;
    }

    if (senha != confirmar) {
      _showSnackBar("As senhas não coincidem.", Colors.red);
      return;
    }

    if (!_isEmailValid(email)) {
      _showSnackBar("E-mail inválido.", Colors.red);
      return;
    }

    if (!_isPhoneValid(telefone)) {
      _showSnackBar("Telefone inválido.", Colors.red);
      return;
    }

    // ==== CADASTRO REAL NO FIREBASE ====
    bool ok = await _controller.cadastrarUsuario(
      context: context,
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
    );

    // 🚀 SE O CADASTRO FOI SUCESSFUL, NAVEGA AQUI (E NÃO NO CONTROLLER)
    if (ok && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SobrePage()),
      );
    }
  }

  // ================= SNACKBAR ======================
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  // ================= UI =============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CABEÇALHO
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

            // CAMPOS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildField("Nome", _nameController),
                  buildField(
                    "E-mail",
                    _emailController,
                    keyboard: TextInputType.emailAddress,
                  ),
                  buildField("Senha", _passwordController, obscure: true),
                  buildField(
                    "Confirmar Senha",
                    _confirmPasswordController,
                    obscure: true,
                  ),
                  buildField(
                    "Telefone",
                    _phoneController,
                    keyboard: TextInputType.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BOTÃO CADASTRAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _registerUser,
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.red.shade900,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
*/


/*import 'package:flutter/material.dart';
import 'package:projeto_final/view/sobre.dart';
import '../controller/controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final LoginController _controller = LoginController();

  // ================= VALIDAÇÕES =====================
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isPhoneValid(String phone) {
    final numericPhone = phone.replaceAll(RegExp(r'\D'), '');
    return numericPhone.length >= 10 && numericPhone.length <= 11;
  }

  // ===================== REGISTRO REAL ==========================
  void _registerUser() async {
    final nome = _nameController.text.trim();
    final email = _emailController.text.trim();
    final senha = _passwordController.text.trim();
    final confirmar = _confirmPasswordController.text.trim();
    final telefone = _phoneController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || telefone.isEmpty) {
      _showSnackBar("Preencha todos os campos.", Colors.red);
      return;
    }

    if (senha != confirmar) {
      _showSnackBar("As senhas não coincidem.", Colors.red);
      return;
    }

    if (!_isEmailValid(email)) {
      _showSnackBar("E-mail inválido.", Colors.red);
      return;
    }

    if (!_isPhoneValid(telefone)) {
      _showSnackBar("Telefone inválido.", Colors.red);
      return;
    }

    // ==== CADASTRO REAL NO FIREBASE ====
    await _controller.cadastrarUsuario(
      context: context,
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
    );
  }

  // ================= SNACKBAR ======================
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  // ================= UI =============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
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

            // CAMPOS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildField("Nome", _nameController),
                  buildField(
                    "E-mail",
                    _emailController,
                    keyboard: TextInputType.emailAddress,
                  ),
                  buildField("Senha", _passwordController, obscure: true),
                  buildField(
                    "Confirmar Senha",
                    _confirmPasswordController,
                    obscure: true,
                  ),
                  buildField(
                    "Telefone",
                    _phoneController,
                    keyboard: TextInputType.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _registerUser,
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.red.shade900,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

*/

/*

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
*/