import 'package:flutter/material.dart';
import 'package:projeto_final/view/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';
import 'controller/controller.dart';

final getIt = GetIt.instance;

void main() {
  //
  // iniciar o gerenciamento de estado
  //
  getIt.registerSingleton(LoginController());

  runApp(
    DevicePreview(enabled: true, builder: (context) => const EventoonApp()),
  );
}

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
