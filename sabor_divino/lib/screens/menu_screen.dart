import 'package:sabor_divino/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/models/product_model.dart';
import 'package:sabor_divino/providers/menu_provider.dart';
import 'package:sabor_divino/screens/product_detail_screen.dart';
import 'package:sabor_divino/widgets/app_drawer.dart';

// 1. Convertido para StatefulWidget 
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState(); 
}

// 2. Criada a classe State 
class _MenuScreenState extends State<MenuScreen> {
  // 3. Variáveis de estado para o Future da API e a instância do serviço
  late Future<List<Product>> _productsFuture; 
  final ApiService apiService = ApiService(); 

  // 4. Lógica de busca de dados
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ouve o provider para recarregar o Future quando a categoria muda 
    final selectedCategory = context.watch<MenuProvider>().selectedCategory;
    // Define o Future inicial 
    _productsFuture = apiService.fetchProductsByCategory(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    // Ouve o MenuProvider para saber qual categoria está selecionada
    final menuProvider = context.watch<MenuProvider>(); 
    final selectedCategory = menuProvider.selectedCategory; 

    // A lógica de filtragem de 'fakeProducts' foi removida 

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
                      // Atualiza o provider 
                      context.read<MenuProvider>().setCategory(category);
                      // 5. ATUALIZA O STATE: Força uma nova busca na API 
                      setState(() { 
                        _productsFuture =
                            apiService.fetchProductsByCategory(category); 
                      });
                    }
                  },
                );
              }).toList(),
            ),
          ),
          // 6. Grade de Produtos AGORA COM FUTUREBUILDER 
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture, // Usa o Future do state 
              builder: (context, snapshot) {
                // 7. Tratamento dos estados da conexão
                if (snapshot.connectionState == ConnectionState.waiting) { 
                  // Estado de Carregamento
                  return const Center(child: CircularProgressIndicator()); 
                }
                if (snapshot.hasError) { 
                  // Estado de Erro
                  return Center(
                      child: Text(
                          'Erro ao carregar produtos: ${snapshot.error}')); 
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) { 
                  // Estado de Vazio
                  return const Center(
                      child: Text('Nenhum produto encontrado.')); 
                }

                // 8. Estado de Sucesso: Pega os dados
                final displayedProducts = snapshot.data!; 

                // 9. Retorna o seu GridView.builder original,
                // mas usando os 'displayedProducts' vindos da API
                return GridView.builder(
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

                    // O SEU CÓDIGO ORIGINAL DO ITEM DA GRADE (preservado)
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
                              child: Image.asset(product.imageUrl,
                                  fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}