import 'package:flutter/material.dart';
import 'package:projeto_final/view/eventos.dart';
import 'package:projeto_final/view/ingressos.dart';
import 'package:projeto_final/view/localizar.dart' hide EventosVer, HomeScreen;
import 'package:projeto_final/view/eventos_ver.dart';

// =======================================================
// VVVVVV IMPORTS E PLACEHOLDERS DE PÁGINAS EXTERNAS VVVVVV
// =======================================================

// Placeholder para Transporte (Índice 5)
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

// =======================================================
// VVVVVV CLASSE PRINCIPAL: TELA DE FAVORITOS (LISTAGEM) VVVVVV
// =======================================================

class Favoritos extends StatefulWidget {
  Favoritos({super.key});

  // Lista de Eventos Destaque (dados conforme as imagens)
  final List<Evento> destaques = [
    Evento(
      titulo: 'JOÃOROCK 20ANOS', // Nome conforme a imagem
      subtitulo: '14 de Junho',
      local: 'Shopping Iguatemi, RP',
      imagemAsset: 'lib/image/joaorock.png', // Caminho do asset
      isDestaque: true,
    ),
    Evento(
      titulo: 'Feira Internacional do Livro',
      subtitulo: '20 a 29 de Junho',
      local: 'Praça XV de Novembro, RP',
      imagemAsset:
          'lib/image/feiralivro.png', // Caminho assumido, se não existir use um placeholder
      isDestaque: false,
    ),
  ];

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  // Cores e Constantes
  static const Color primaryRed = Color(
    0xFFC8372D,
  ); // Vermelho da identidade visual
  static const Color darkBackground = Colors.black;

  // Estado
  // Índice 2 é "Favoritos" na BottomNavigationBar, que agora é esta tela.
  int _selectedIndex = 2;

  // Lógica de Navegação (MANTIDA)
  final List<WidgetBuilder> _navigationDestinations = [
    (context) => HomeScreen(),
    // Para manter a compatibilidade com a indexação anterior (Ingressos), Favoritos é o índice 2.
    (context) => Ingressos(),
    (context) => Favoritos(),
    (context) => LocalizarEvento(),
    (context) => EventosVer(),
    (context) => PlaceholderPage5(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      // Se for Home (0), a ação padrão é voltar ou ir para a Home de verdade.
      Navigator.pop(context);
    } else {
      // Navega para a NOVA TELA, substituindo a tela atual.
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
            // Título "Favoritos" com seta de voltar
            _buildFavoritesHeader(),

            // Título "Eventos Destaque"
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
              child: Text(
                'Eventos Destaque',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Lista dos Cards de Eventos Destaque
            ...widget.destaques
                .map((evento) => _buildEventCard(evento))
                .toList(),

            const SizedBox(height: 50.0),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // =======================================================
  // VVVVVV WIDGETS AUXILIARES REFORMATADOS PARA TELA DE FAVORITOS VVVVVV
  // =======================================================

  // AppBar (Barra Superior) - Com Ícone de Perfil e Notificação
  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
        color: primaryRed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Ícone de Perfil e Título "Favoritos" (Texto da imagem)
            Row(
              children: <Widget>[
                const Icon(Icons.person, color: Colors.white, size: 28),
                const SizedBox(width: 8.0),
                const Text(
                  'Favoritos', // Texto conforme a imagem
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

  // Título "Favoritos" com Seta de Voltar
  Widget _buildFavoritesHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
      child: Row(
        children: [
          // Seta de Voltar (Seta curvada vermelha)
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.turn_left, color: primaryRed, size: 30),
          ),
          const SizedBox(width: 8.0),
          const Text(
            'Favoritos', // Texto conforme a imagem
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

  // Card de Evento (para Eventos Destaque)
  Widget _buildEventCard(Evento evento) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: darkBackground, // Fundo preto
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Imagem do Evento
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                evento.imagemAsset,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Altura do banner
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: const Color(0xFF212121),
                  child: Center(
                    child: Text(
                      'Imagem não carregada: ${evento.imagemAsset}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),

            // Título do Evento
            Text(
              evento.titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),

            // Subtítulo (Data)
            Text(
              evento.subtitulo,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4.0),

            // Local e Ícones de Ação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Local
                Text(
                  evento.local,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                // Ícones de Ação (Coração, Compartilhar, Mais Opções)
                Row(
                  children: [
                    // Coração (Favoritar) - Preenchido, como nas imagens
                    const Icon(Icons.favorite, color: primaryRed, size: 22),
                    const SizedBox(width: 10),
                    // Compartilhar
                    const Icon(Icons.share, color: primaryRed, size: 22),
                    const SizedBox(width: 10),
                    // Mais Opções
                    const Icon(Icons.more_vert, color: primaryRed, size: 22),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            // Adiciona uma linha divisória para separar os cards (opcional, mas visualmente similar)
            const Divider(color: Color(0xFF212121), height: 1),
          ],
        ),
      ),
    );
  }

  // Rodapé de Navegação (BottomNavigationBar) - Índice 2 (Favoritos) destacado
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
        currentIndex: _selectedIndex, // Índice 2 (Favoritos) estará destacado
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
