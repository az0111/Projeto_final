import 'package:flutter/material.dart';
import 'package:projeto_final/view/eventos.dart';
import 'package:projeto_final/view/favoritos.dart';
import 'package:projeto_final/view/localizar.dart' hide EventosVer, HomeScreen;
import 'package:projeto_final/view/eventos_ver.dart';

//A tela transporte ainda não foi implementada, com um placeholder simples meramente ilustrativo
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

class Ingressos extends StatefulWidget {
  Ingressos({super.key});

  // Dados do evento aqui para esta tela de detalhes
  final Evento joaoRock = Evento(
    titulo: 'JOÃOROCK 20 ANOS',
    subtitulo: '03 de Junho de 2024, 21 horas',
    local: 'Shopping Iguatemi, Ribeirão Preto, SP',
    imagemAsset: 'lib/image/joaorock.png',
    isDestaque: true,
  );

  @override
  State<Ingressos> createState() => _IngressosState();
}

class _IngressosState extends State<Ingressos> {
  // Estado para o contador de ingressos
  int _ticketQuantity = 0;
  // Preço unitário (R$ 320,00 da imagem)
  final double _unitPrice = 320.00;
  // Cor principal
  static const Color primaryRed = Color(0xFFC8372D);

  int _selectedIndex = 1;

  // 2. Mapeamento de Destinos para a navegação
  final List<WidgetBuilder> _navigationDestinations = [
    (context) => HomeScreen(),
    (context) => Ingressos(),
    (context) => Favoritos(),
    (context) => LocalizarEvento(),
    (context) => EventosVer(),
    (context) => PlaceholderPage5(),
  ];

  // 3. Lógica de Navegação
  void _onItemTapped(int index) {
    // Se o item clicado for o 'Ingressos', não faz nada.
    if (index == 1) {
      return;
    }

    // Se o item clicado for 'Home' (index 0), voltamos para a Home.
    // Usamos `Navigator.pop` para voltar para a tela anterior (a Home, no caso).
    if (index == 0) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: _navigationDestinations[index]),
      );
    }

    // Opcional: Atualiza o estado para destacar o novo botão (embora sairemos desta tela)
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para aumentar a quantidade (Mantida)
  void _incrementQuantity() {
    setState(() {
      _ticketQuantity++;
    });
  }

  // Função para diminuir a quantidade (Mantida)
  void _decrementQuantity() {
    setState(() {
      if (_ticketQuantity > 0) {
        _ticketQuantity--;
      }
    });
  }

  // Função para calcular o total (Mantida)
  String _calculateTotal() {
    double total = _ticketQuantity * _unitPrice;
    return total.toStringAsFixed(2).replaceAll('.', ','); // Formato R$ X,XX
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(primaryRed),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Título do Evento e Banner
            _buildEventHeader(),

            // 2. Informação de Localização
            _buildInfoContainer(
              icon: Icons.location_on,
              text: widget.joaoRock.local,
              color: primaryRed,
            ),
            const SizedBox(height: 10.0),

            // 3. Informação de Data/Hora
            _buildInfoContainer(
              icon: Icons.calendar_today,
              text: widget.joaoRock.subtitulo,
              color: primaryRed,
            ),
            const SizedBox(height: 20.0),

            // 4. Seção de Compra de Ingressos (Dinâmica)
            _buildTicketPurchaseSection(primaryRed),

            // Espaçamento para o rodapé (opcional)
            const SizedBox(height: 50.0),
          ],
        ),
      ),
      // 5. Rodapé de Navegação (AGORA USA A NOVA LÓGICA DE NAVEGAÇÃO)
      bottomNavigationBar: _buildBottomNavBar(primaryRed),
    );
  }

  // A AppBar (Barra superior)
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
                // Ícone de Perfil
                const Icon(Icons.person, color: Colors.white, size: 28),
                const SizedBox(width: 8.0),
                const Text(
                  'Compra de Ingressos', // Texto da imagem de detalhes
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
                // Ícone EVENTOON (Logo da imagem)
                Image.asset(
                  'lib/image/logo.png',
                  height: 30,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8.0),
                // Ícone de Notificação
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

  // Título e Banner do Evento (Simulação da Imagem)
  Widget _buildEventHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Botão de voltar (Seta curvada da imagem) - AGORA USA Navigator.pop
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.turn_left, // Ícone aproximado
              color: primaryRed,
              size: 30,
            ),
          ),
        ),

        // Título JOÃOROCK 20 ANOS
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.joaoRock.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Imagem/Banner
        Image.asset(
          widget.joaoRock.imagemAsset,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
        const SizedBox(height: 10.0),

        // Repetição do Título (como na imagem de detalhes)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            widget.joaoRock.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Contêiner de Informação (Local ou Data)
  Widget _buildInfoContainer({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF212121),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Seção de Compra de Ingressos (Com a lógica dinâmica)
  Widget _buildTicketPurchaseSection(Color primaryRed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: primaryRed,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            // Linha do Cabeçalho: Ingressos e Total
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ingressos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'R\$ ${_calculateTotal()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Corpo da Tabela de Ingresso
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: Color(0xFF212121),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Detalhes do Ingresso
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Último Lote',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'R\$ 320,00',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pague em até 6X',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),

                  // Contador de Ingressos (Tabela de Quantidade)
                  Row(
                    children: [
                      // Botão Menos
                      InkWell(
                        onTap: _decrementQuantity,
                        child: Icon(
                          Icons.remove_circle,
                          color: primaryRed,
                          size: 30,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          '$_ticketQuantity',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Botão Mais
                      InkWell(
                        onTap: _incrementQuantity,
                        child: Icon(
                          Icons.add_circle,
                          color: primaryRed,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Rodapé de Navegação (BottomNavigationBar)
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
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: primaryRed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,

        // Usa o estado para destacar o botão "Ingressos"
        currentIndex: _selectedIndex,

        // Chama a nova lógica de navegação
        onTap: _onItemTapped,

        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Índice 0
          ),
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
