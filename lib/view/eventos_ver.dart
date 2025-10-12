import 'package:flutter/material.dart';
import 'package:projeto_final/view/eventos.dart';
import 'package:projeto_final/view/favoritos.dart';
import 'package:projeto_final/view/ingressos.dart';
import 'package:projeto_final/view/localizar.dart' hide HomeScreen;
// =======================================================
// VVVVVV IMPORTS E PLACEHOLDERS DE PÁGINAS EXTERNAS VVVVVV
// =======================================================

// Placeholder para a tela Home (Índice 0)
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

// O modelo de Evento foi mantido (embora não seja usado diretamente nesta tela de cadastro, mantido para evitar quebras)
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

// =======================================================
// VVVVVV CLASSE PRINCIPAL: EventosVer (Tela de Cadastro de Eventos) VVVVVV
// =======================================================

class EventosVer extends StatefulWidget {
  EventosVer({super.key});

  // A lista de destaques não é usada nesta tela, mas mantida para não remover o que já existia.
  final List<Evento> destaques = [
    Evento(
      titulo: 'JOÃOROCK 20ANOS',
      subtitulo: '14 de Junho',
      local: 'Shopping Iguatemi, RP',
      imagemAsset: 'lib/image/joaorock.png',
      isDestaque: true,
    ),
    Evento(
      titulo: 'Feira Internacional do Livro',
      subtitulo: '20 a 29 de Junho',
      local: 'Praça XV de Novembro, RP',
      imagemAsset: 'lib/image/feiralivro.png',
      isDestaque: false,
    ),
  ];

  @override
  State<EventosVer> createState() => _EventosVerState();
}

class _EventosVerState extends State<EventosVer> {
  // Cores e Constantes
  static const Color primaryRed = Color(
    0xFFC8372D,
  ); // Vermelho da identidade visual
  static const Color darkBackground = Colors.black;
  static const Color darkGrayBackground = Color(
    0xFF1C1C1C,
  ); // Fundo cinza escuro para a área do formulário
  static const Color textFieldFillColor = Color(
    0xFF333333,
  ); // Cor de preenchimento dos campos de texto

  // Estado: Índice 4 é "Eventos" na BottomNavigationBar, que é a tela que estamos estilizando.
  int _selectedIndex = 4;

  // Lógica de Navegação (MANTIDA)
  // Usamos EventosVer() no índice 4.
  final List<WidgetBuilder> _navigationDestinations = [
    (context) => HomeScreen(),
    (context) => Ingressos(),
    (context) => Favoritos(),
    (context) => LocalizarEvento(),
    (context) => EventosVer(),
    (context) => PlaceholderPage5(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pop(context);
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
            // Título "Eventos" com seta de voltar
            _buildEventsHeader(),

            // Conteúdo principal do formulário
            _buildEventFormSection(),

            const SizedBox(height: 50.0),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // =======================================================
  // VVVVVV WIDGETS AUXILIARES ESTILIZADOS PARA CADASTRO DE EVENTOS VVVVVV
  // =======================================================

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
            // Ícone de Perfil e Título "Eventos" (Texto da imagem)
            Row(
              children: <Widget>[
                const Icon(Icons.person, color: Colors.white, size: 28),
                const SizedBox(width: 8.0),
                const Text(
                  'Eventos', // Texto conforme a imagem
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
                  'lib/image/logo.png', // Assumindo o path
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

  // Título "Eventos" com Seta de Voltar (na área do body)
  Widget _buildEventsHeader() {
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
          // Título "Eventos" em vermelho
          const Text(
            'Eventos',
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

  // Seção principal do formulário de cadastro de eventos
  Widget _buildEventFormSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:
              darkGrayBackground, // Fundo cinza escuro para a área do formulário
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Cabeçalho "Cadastrar Seu Evento"
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: primaryRed,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: const [
                  Icon(Icons.assignment, color: Colors.white, size: 24),
                  SizedBox(width: 10.0),
                  Text(
                    'Cadastrar Seu Evento',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Texto "Preencher Os Seguintes Dados"
            const Text(
              'Preencher Os Seguintes Dados',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15.0),

            // Campos de Texto (Nome Completo, CPF, Documento de Identidade, Localização de Evento)
            _buildTextField('Nome Completo'),
            const SizedBox(height: 15.0),
            _buildTextField('CPF'),
            const SizedBox(height: 15.0),
            _buildTextField('Documento de Identidade'),
            const SizedBox(height: 15.0),
            _buildTextField('Localização de Evento'),
            const SizedBox(height: 20.0),

            // Anexar Comprovante
            const Text(
              'Anexar Comprovante de Residência ou Aluguel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15.0),
            _buildFileUploadField(),
          ],
        ),
      ),
    );
  }

  // Widget para campos de texto (TextFormField)
  Widget _buildTextField(String labelText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: textFieldFillColor, // Cor de preenchimento do campo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none, // Sem borda visível
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: primaryRed,
            width: 2.0,
          ), // Borda vermelha ao focar
        ),
      ),
      style: const TextStyle(color: Colors.white),
      cursorColor: primaryRed,
    );
  }

  // Widget para o campo de Upload de Arquivos
  Widget _buildFileUploadField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: primaryRed, // Fundo vermelho
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.insert_drive_file, color: Colors.white, size: 28),
          SizedBox(width: 10.0),
          Text(
            'Upload de Arquivos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Rodapé de Navegação (BottomNavigationBar) - Índice 4 (Eventos) destacado
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
        currentIndex: _selectedIndex, // Índice 4 (Eventos) estará destacado
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
