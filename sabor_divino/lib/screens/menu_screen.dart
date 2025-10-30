// lib/screens/menu_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/data/fake_data.dart';
import 'package:sabor_divino/models/product_model.dart';
import 'package:sabor_divino/providers/menu_provider.dart';
import 'package:sabor_divino/screens/product_detail_screen.dart';
import 'package:sabor_divino/widgets/app_drawer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ouve o MenuProvider para saber qual categoria está selecionada
    final menuProvider = context.watch<MenuProvider>();
    final selectedCategory = menuProvider.selectedCategory;

    // Filtra a lista de produtos com base na categoria
    final List<Product> displayedProducts = selectedCategory == 'Todos'
        ? fakeProducts
        : fakeProducts.where((p) => p.category == selectedCategory).toList();

    // Lista de categorias para os filtros
    const categories = ['Todos', 'Lanches', 'Bebidas', 'Sobremesas'];

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Nosso Cardápio'),
      ),
      body: Column(
        children: [
          // Filtros
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (isSelected) {
                    if (isSelected) {

                      context.read<MenuProvider>().setCategory(category);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          // Grade de Produtos
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: displayedProducts.length,
              itemBuilder: (ctx, i) {
                final product = displayedProducts[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product)),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style:
                            const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}