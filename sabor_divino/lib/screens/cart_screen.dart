import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/providers/auth_provider.dart';
import 'package:sabor_divino/providers/cart_provider.dart';
import 'package:sabor_divino/screens/confirmation_screen.dart';
import 'package:sabor_divino/screens/menu_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  Future<void> _submitOrder(BuildContext context) async {
    final cart = context.read<CartProvider>();
    final token = context.read<AuthProvider>().token; 

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você precisa estar logado para finalizar o pedido.')),
      );
      return;
    }

    setState(() {
      _isLoading = true; 
    });

    try {
      await cart.finalizarPedido(token);
      
      if (mounted) { 
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ConfirmationScreen()),
        );
      }
      
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao finalizar pedido: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; 
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    
    // Converte o Map para uma Lista para o ListView
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Seu carrinho está vazio',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Adicione alguns produtos deliciosos ao seu carrinho!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Ver Cardápio'),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) {
                      final cartItem = cartItems[i]; 
                      final product = cartItem.product;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(product.imageUrl), 
                        ),
                        title: Text(product.name),
                        subtitle: Text('Qtd: ${cartItem.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'R\$ ${(cartItem.quantity * product.price).toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                              onPressed: () {
                                context
                                    .read<CartProvider>()
                                    .removeItem(product.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total',
                              style: Theme.of(context).textTheme.titleLarge),
                          Text(
                            'R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        onPressed: _isLoading ? null : () => _submitOrder(context),
                        child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('FINALIZAR PEDIDO', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}