import 'package:flutter/material.dart';
import 'package:projeto_final/view/favoritos.dart';
import 'package:projeto_final/view/ingressos.dart';
import 'package:projeto_final/view/localizar.dart' hide EventosVer;
import 'package:projeto_final/view/eventos_ver.dart';

// A classe de transporte ainda não foi implementada estea é apenas uma placeholder, meramente para manter a estrutura.
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

// ============== A TELA DE VISUALIZAÇÃO (VIEW) AGORA É STATEFUL ==============

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<WidgetBuilder> _navigationDestinations = [
    (context) => HomeScreen(),
    (context) => Ingressos(),
    (context) => Favoritos(),
    (context) => LocalizarEvento(),
    (context) => EventosVer(),
    (context) =>
        PlaceholderPage5(), // Substitua PlaceholderPage5() pela sua classe de TRANSPORTE
  ];

  // Dados dos eventos
  final List<Evento> destaques = [
    Evento(
      titulo: 'JoãoRock',
      subtitulo: '14 de Junho',
      local: 'Shopping Iguatemi, RP',
      imagemAsset: 'lib/image/joaorock.png',
      isDestaque: true,
    ),
    Evento(
      titulo: 'Feira Internacional do Livro',
      subtitulo: '20 a 29 de Agosto',
      local: 'Praça XV de Novembro, RP',
      imagemAsset: 'lib/image/feiralivro.png',
      isDestaque: true,
    ),
  ];

  final List<Evento> roteiros = [
    Evento(
      titulo: 'Pint Of Science',
      subtitulo: 'Dias 19 a 21 de Junho',
      local: 'Av. Cafe, 238, RP',
      imagemAsset: 'lib/image/pintscience.png',
    ),
    Evento(
      titulo: 'Festa Junina',
      subtitulo: 'Dia 23 de Junho',
      local: 'Av. 13 de Maio, 238, RP',
      imagemAsset: 'lib/image/festajunina.png',
    ),
    Evento(
      titulo: 'Happy Hour',
      subtitulo: 'Dias 22 de Junho',
      local: 'Barão Amazona, RP',
      imagemAsset: 'lib/image/happyhour.png',
    ),
  ];

  // 2. Lógica de Navegação
  void _onItemTapped(int index) {
    if (index != 0) {
      // Implementa a navegação para uma NOVA TELA usando a classe mapeada em _navigationDestinations
      Navigator.push(
        context,
        MaterialPageRoute(builder: _navigationDestinations[index]),
      ).then((_) {
        // Ao retornar da nova tela, força o destaque de volta para 'Home'.
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFC8372D);
    const Color categoryRed = Color(0xFFDF4D47);
    const Color backgroundColor = Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(primaryRed),

      // O corpo (body) permanece fixo na visualização HomeContent
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Conteúdo da Home
              _buildSearchBar(),
              const SizedBox(height: 16.0),
              _buildCategoriesRow(categoryRed),
              const SizedBox(height: 50.0),
              _buildSectionTitle('Destaques do Dia'),
              const SizedBox(height: 8.0),
              _buildDestaquesList(destaques),
              const SizedBox(height: 24.0),
              _buildSectionTitle('Roteiros Recomendados'),
              const SizedBox(height: 8.0),
              _buildRoteirosList(roteiros),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),

      // 3. Rodapé de Navegação
      bottomNavigationBar: _buildBottomNavBar(primaryRed),
    );
  }

  // WIDGETS AUXILIARES
  PreferredSize _buildAppBar(Color primaryRed) {
    // ...
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
        color: primaryRed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.person, color: primaryRed, size: 24),
                ),
                const SizedBox(width: 8.0),
                const Text(
                  'Bem Vindo Rodrigo!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  'lib/image/logo.png',
                  height: 30,
                  width: 50,
                  fit: BoxFit.contain,
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

  Widget _buildSearchBar() {
    // ...
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Buscar Evento',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: Icon(Icons.mic, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesRow(Color categoryRed) {
    // ...
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.music_note, 'label': 'Shows'},
      {'icon': Icons.hub, 'label': 'Networking'},
      {'icon': Icons.people, 'label': 'Dança'},
      {'icon': Icons.masks, 'label': 'Cultura'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((cat) {
        return _buildCategoryItem(
          cat['icon'] as IconData,
          cat['label'] as String,
          categoryRed,
        );
      }).toList(),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color categoryRed) {
    // ...
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(color: categoryRed, shape: BoxShape.circle),
          child: Icon(
            icon,
            color: const Color.fromARGB(255, 248, 243, 243),
            size: 30,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    // ...
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDestaquesList(List<Evento> destaques) {
    // ...
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: destaques.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16.0 : 8.0,
              right: index == destaques.length - 1 ? 16.0 : 8.0,
            ),
            child: _buildEventCard(destaques[index], isDestaque: true),
          );
        },
      ),
    );
  }

  Widget _buildRoteirosList(List<Evento> roteiros) {
    // ...
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roteiros.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16.0 : 8.0,
              right: index == roteiros.length - 1 ? 16.0 : 8.0,
            ),
            child: _buildEventCard(roteiros[index], isDestaque: false),
          );
        },
      ),
    );
  }

  Widget _buildEventCard(Evento evento, {required bool isDestaque}) {
    // ...
    final double cardWidth = isDestaque ? 300 : 160;
    final double imageRatio = isDestaque ? 16 / 9 : 3 / 4;
    const Color darkGreyBackground = Color(0xFF212121);

    return GestureDetector(
      onTap: () {
        // Implementar a navegação para a tela de detalhes do evento
        print('Evento Clicado: ${evento.titulo}');
      },
      child: Card(
        color: darkGreyBackground,
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: SizedBox(
          width: cardWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: imageRatio,
                child: Image.asset(evento.imagemAsset, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      evento.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      evento.subtitulo,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      evento.local,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. Rodapé de Navegação
  Widget _buildBottomNavBar(Color primaryRed) {
    return Container(
      decoration: BoxDecoration(
        color: primaryRed,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3), // Sombra no topo
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: primaryRed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,

        currentIndex: _selectedIndex,

        // AQUI ESTÁ O GATILHO: QUANDO UM ITEM É TOCADO, CHAMA A LÓGICA DE NAVEGAÇÃO
        onTap: _onItemTapped,

        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Ingressos', // Índice 1
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos', // Índice 2
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Localizar', // Índice 3
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Eventos', // Índice 4
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Transporte', // Índice 5
          ),
        ],
      ),
    );
  }
}
