import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/sobre.dart';

class LoginController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // ================= LOGIN =====================
  Future<bool> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login realizado com sucesso!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SobrePage()),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String msg = "Erro ao fazer login";

      switch (e.code) {
        case "user-not-found":
          msg = "Usuário não encontrado.";
          break;
        case "wrong-password":
          msg = "Senha incorreta.";
          break;
        case "invalid-email":
          msg = "E-mail inválido.";
          break;
        default:
          msg = "Erro: ${e.message}";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
      return false;
    }
  }

  // ================= ESQUECEU SENHA =====================
  Future<void> esqueceuSenha({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("E-mail de recuperação enviado com sucesso!"),
        ),
      );

      // Aguarda um pouco antes de navegar para evitar conflito com o ciclo de navegação do Flutter.
      Future.delayed(const Duration(milliseconds: 600), () {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        }
      });
    } on FirebaseAuthException catch (e) {
      String mensagem;
      switch (e.code) {
        case 'invalid-email':
          mensagem = 'O e-mail informado é inválido.';
          break;
        case 'user-not-found':
          mensagem = 'Nenhum usuário encontrado com este e-mail.';
          break;
        default:
          mensagem = 'Erro: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro inesperado: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ================= CADASTRO =====================
  Future<bool> cadastrarUsuario({
    required BuildContext context,
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) async {
    try {
      // 1. Criar no Authentication
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // 2. Salvar dados extras no Firestore
      await db.collection("usuarios").doc(cred.user!.uid).set({
        "nome": nome,
        "email": email,
        "telefone": telefone,
        "uid": cred.user!.uid,
        "criadoEm": DateTime.now(),
      });

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
      return false;
    }
  }
}



//Codígo funcionando
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/sobre.dart';

class LoginController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // ================= LOGIN =====================
  Future<bool> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login realizado com sucesso!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SobrePage()),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String msg = "Erro ao fazer login";

      switch (e.code) {
        case "user-not-found":
          msg = "Usuário não encontrado.";
          break;
        case "wrong-password":
          msg = "Senha incorreta.";
          break;
        case "invalid-email":
          msg = "E-mail inválido.";
          break;
        default:
          msg = "Erro: ${e.message}";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));

      return false;
    }
  }
  

  // ================= CADASTRO =====================
  Future<bool> cadastrarUsuario({
    required BuildContext context,
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) async {
    try {
      // 1. Criar no Authentication
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // 2. Salvar dados extras no Firestore
      await db.collection("usuarios").doc(cred.user!.uid).set({
        "nome": nome,
        "email": email,
        "telefone": telefone,
        "uid": cred.user!.uid,
        "criadoEm": DateTime.now(),
      });
      return true;
    } catch (e) {
      // Mostrar erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
      return false; // ⚠️ IMPORTANTE
    }
  }
}

*/

      // 3. Redirecionar após cadastrar
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => SobrePage()),
      // );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       String msg = "Erro ao cadastrar";

//       switch (e.code) {
//         case "email-already-in-use":
//           msg = "Este e-mail já está em uso.";
//           break;
//         case "weak-password":
//           msg = "Senha muito fraca. Deve ter no mínimo 6 caracteres.";
//           break;
//         case "invalid-email":
//           msg = "E-mail inválido.";
//           break;
//         default:
//           msg = "Erro: ${e.message}";
//       }

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));

//       return false;
//     }
//   }
// }
