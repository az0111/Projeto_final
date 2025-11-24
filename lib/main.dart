import 'package:flutter/material.dart';
import 'package:projeto_final/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_final/view/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';
import 'controller/controller.dart';

final g = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar o firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  g.registerSingleton<LoginController>(LoginController());
  // g.registerSingleton<TarefaController>(TarefaController());

  runApp(DevicePreview(enabled: true, builder: (context) => EventoonApp()));
}
// g.registerSingleton<LoginController>(LoginController());
// g.registerSingleton<TarefaController>(TarefaController());

// void main() {
//   //
// iniciar o gerenciamento de estado
//
//   getIt.registerSingleton(LoginController());

//   runApp(
//     DevicePreview(enabled: true, builder: (context) => const EventoonApp()),
//   );
// // }

class EventoonApp extends StatelessWidget {
  const EventoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventoon',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
