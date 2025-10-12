import 'package:flutter/material.dart';
import 'package:projeto_final/view/eventos.dart';
import 'package:projeto_final/view/favoritos.dart';
import 'package:projeto_final/view/eventos_ver.dart';
import 'package:projeto_final/view/ingressos.dart';

// A tela transporte ainda não foi implementada no seu lugar se tem um placeholder, meramente ilustrativo
class PlaceholderPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: Text(
        'Tela de Transporte',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
  );
}

class LocalizarEvento extends StatefulWidget {
  @override
  State<LocalizarEvento> createState() => _LocalizarEventoState();
}

class _LocalizarEventoState extends State<LocalizarEvento> {
  // Cores e Constantes
  static const Color primaryRed = Color(0xFFC8372D);
  static const Color darkBackground = Colors.black;
  static const Color cardColor = Color(
    0xFF1C1C1C,
  ); // Cor de fundo para as caixas de informação

  // Estado: Índice 3 é "Localizar"
  int _selectedIndex = 3;

  // Lógica de Navegação (Definida aqui para o BottomNavBar desta tela)
  final List<WidgetBuilder> _navigationDestinations = [
    (context) => HomeScreen(),
    (context) => Ingressos(), // Índice 1: Ingressos
    (context) => Favoritos(), // Índice 2: Favoritos
    (context) => LocalizarEvento(), // Índice 3: Localizar (esta tela)
    (context) => EventosVer(), // Índice 4: Eventos (mantida a classe EventosVer)
    (context) => PlaceholderPage5(), // Índice 5: Transporte
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: _navigationDestinations[index]),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: _navigationDestinations[index]),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildEventTitleHeader(),

            _buildMapSection(),

            const SizedBox(height: 20.0),

            _buildDistanceCard(),

            const SizedBox(height: 20.0),

            _buildTransportOptionsCard(),

            const SizedBox(height: 50.0),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // AppBar (Barra Superior Vermelha)
  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
        color: primaryRed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Ícone de Perfil e Título "Localização do Evento"
            Row(
              children: <Widget>[
                const Icon(Icons.person, color: Colors.white, size: 28),
                const SizedBox(width: 8.0),
                const Text(
                  'Localização do Evento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // Logo EVENTOON e Ícone de Notificação
            Row(
              children: <Widget>[
                // Placeholder para a logo 'EVENTOON'
                Image.asset(
                  'lib/image/logo.png',
                  height: 30,
                  width: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Text(
                    'EVENTOON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Título "JOÃOROCK 20ANOS" com Seta de Voltar (na área do body)
  Widget _buildEventTitleHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
      child: Row(
        children: [
          // Seta de Voltar (Seta curvada vermelha)
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.turn_left, color: primaryRed, size: 30),
          ),
          const SizedBox(width: 8.0),
          // Título do Evento em vermelho
          const Text(
            'JOÃOROCK 20ANOS', // Texto conforme a imagem
            style: TextStyle(
              color: primaryRed,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Seção do Mapa (Simulação da área de mapa)
  Widget _buildMapSection() {
    return Container(
      height: 250, // Altura ajustada para o mapa/direções
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: darkBackground,
        border: Border.all(
          color: primaryRed,
          width: 1.0,
        ), // Borda vermelha ao redor da seção
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Image.asset(
          'lib/image/mapa.png', // <--- Tenta carregar a imagem real
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[900],
            child: Row(
              children: [
                // Simulação da tela de direções de texto (esquerda)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Shopping Iguatemi Ribeirão Preto, Av. L...',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Saída',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                        Text(
                          '06:05 SPARTA-ESTRA',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          'Chegada',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                        Text(
                          '06:45 Avenida de Novembro',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '40 min',
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Simulação da tela de mapa (direita)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey[800]!, width: 1.0),
                      ),
                      color:
                          Colors.grey[850], // Cor de fundo para simular o mapa
                    ),
                    child: const Center(
                      child: Text(
                        'MAPA (Placeholder)',
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Card de Distância do Evento
  Widget _buildDistanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.directions_walk, color: primaryRed, size: 28),
          SizedBox(width: 10.0),
          Text(
            'Distância do Evento: 5 Km', // Texto conforme a imagem
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Card de Opções de Transporte
  Widget _buildTransportOptionsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: darkBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título Vermelho "Ver Opções de Transporte"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            decoration: const BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: const Text(
              'Ver Opções de Transporte', // Texto conforme a imagem
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Lista de Opções
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                _buildTransportItem(
                  Icons.car_rental,
                  'Carro',
                  '11 minutos',
                ), // Ícone simulado para carro
                const SizedBox(height: 10),
                _buildTransportItem(
                  Icons.two_wheeler,
                  'Moto',
                  '9 minutos',
                ), // Ícone simulado para moto
                const SizedBox(height: 10),
                _buildTransportItem(
                  Icons.directions_bus,
                  'Ônibus',
                  '40 minutos',
                ), // Ícone simulado para ônibus
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Item individual de transporte
  Widget _buildTransportItem(IconData icon, String type, String time) {
    return Row(
      children: [
        Icon(icon, color: primaryRed, size: 28),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            type,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Text(
          '- $time',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  // Rodapé de Navegação (BottomNavigationBar) - Índice 3 (Localizar) destacado
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: primaryRed,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: primaryRed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Índice 3 (Localizar) estará destacado
        onTap: _onItemTapped,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Ingressos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Localizar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Transporte',
          ),
        ],
      ),
    );
  }
}

// O modelo de Evento foi mantido
class Evento {
  final String titulo;
  final String subtitulo;
  final String local;
  final String imagemAsset;
  final bool isDestaque;

  Evento({
    required this.titulo,
    required this.subtitulo,
    required this.local,
    required this.imagemAsset,
    this.isDestaque = false,
  });
}
