import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/providers/cart_provider.dart';
import 'package:sabor_divino/providers/menu_provider.dart';
import 'package:sabor_divino/screens/cart_screen.dart';
import 'package:sabor_divino/screens/login_screen.dart';
import 'package:sabor_divino/screens/menu_screen.dart';
import 'package:sabor_divino/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToMenuWithCategory(String category) {
      context.read<MenuProvider>().setCategory(category);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Sabor Divino',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Text(
              'Entrar',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints:
                      const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        cart.itemCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Principal
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Text('Bem-vindo à Sabor Divino',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36)),
                  const SizedBox(height: 8),
                  Text(
                    'Os melhores lanches, bebidas e sobremesas da cidade. Faça seu pedido agora!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      navigateToMenuWithCategory('Todos');
                    },
                    child: const Text('Ver Cardápio Completo'),
                  ),
                ],
              ),
            ),
            // Seções de Categoria
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCategoryCard(
                    context,
                    icon: Icons.fastfood,
                    title: 'Lanches',
                    subtitle: 'Hambúrgueres artesanais feitos com ingredientes frescos e de qualidade.',
                    onTap: () => navigateToMenuWithCategory('Lanches'),
                  ),
                  _buildCategoryCard(
                    context,
                    icon: Icons.local_drink,
                    title: 'Bebidas',
                    subtitle: 'Sucos naturais, refrigerantes e milkshakes para acompanhar seu lanche.',
                    onTap: () => navigateToMenuWithCategory('Bebidas'),
                  ),
                  _buildCategoryCard(
                    context,
                    icon: Icons.icecream,
                    title: 'Sobremesas',
                    subtitle: 'Doces irresistíveis para finalizar sua refeição com chave de ouro.',
                    onTap: () => navigateToMenuWithCategory('Sobremesas'),
                  ),
                  // Horário de Funcionamento
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text('Horário de Funcionamento', style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 16),
                          const Text('Segunda a Sexta: 18:00 - 23:00'),
                          const SizedBox(height: 8),
                          const Text('Sábado e Domingo: 18:00 - 00:00'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onTap,
              child: Text('Ver $title'),
            ),
          ],
        ),
      ),
    );
  }
}