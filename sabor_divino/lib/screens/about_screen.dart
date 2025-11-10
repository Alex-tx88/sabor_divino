import 'package:flutter/material.dart';
import 'package:sabor_divino/screens/home_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nós'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Nossa História',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'A Lanchonete Sabor Divino nasceu em 2020 com o objetivo de trazer os melhores sabores da culinária de lanchonete para você. Nossos hambúrgueres são feitos artesanalmente com ingredientes frescos e de alta qualidade. Acreditamos que uma boa refeição vai além do sabor, é sobre criar momentos especiais e memórias deliciosas. Por isso, cada produto é preparado com carinho e dedicação pela nossa equipe.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildInfoCard(
              context,
              icon: Icons.location_on,
              title: 'Endereço',
              subtitle:
              'Rua das Delícias, 123\nCentro - Salvador, BA\nCEP: 01234-567',
            ),
            _buildInfoCard(
              context,
              icon: Icons.phone,
              title: 'Telefone',
              subtitle: '(71) 98765-4321\n(71) 3456-7890',
            ),
            _buildInfoCard(
              context,
              icon: Icons.email,
              title: 'Email',
              subtitle:
              'contato@sabordivino.com.br\npedidos@sabordivino.com.br',
            ),
            _buildInfoCard(
              context,
              icon: Icons.access_time,
              title: 'Horário',
              subtitle: 'Seg-Sex: 18:00 - 23:00\nSáb-Dom: 18:00 - 00:00',
            ),


            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              child: const Text('Voltar ao Início'),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 32,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}