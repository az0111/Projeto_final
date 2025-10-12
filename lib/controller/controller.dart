import '../model/user_model.dart';

class LoginController {
  // Simulação de login (poderia ser Firebase, API, etc.)
  bool login(UserModel user) {
    if (user.email == "admin@teste.com" && user.password == "123456") {
      return true;
    }
    return false;
  }



  // Esqueceu a senha
  void forgotPassword(String email) {
    // Aqui você pode implementar envio de e-mail ou redirecionamento
    // ignore: avoid_print
    print( "Recuperação de senha para $email");
 
  }

}