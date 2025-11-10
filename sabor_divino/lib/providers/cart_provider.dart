import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:sabor_divino/services/api_service.dart'; 

// 1. Classe de ajuda para guardar o produto E a quantidade
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  // 2. Usar um Map<String, CartItem> para gerenciar as quantidades
  // A chave (String) será o ID do produto.
  final Map<String, CartItem> _items = {};

  final ApiService _apiService = ApiService();

  Map<String, CartItem> get items {
    return {..._items};
  }

  // Retorna o número de *itens únicos* no carrinho (ex: X-Burger, Refri)
  int get itemCount {
    return _items.length;
  }

  // 3. Lógica do Preço Total atualizada (preço * quantidade)
  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // 4. Lógica de Adicionar item atualizada
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Se o item já existe, apenas aumenta a quantidade
      _items.update(product.id, (existingItem) {
        existingItem.quantity++;
        return existingItem;
      });
    } else {
      // Se é um novo item, adiciona ao Map com quantidade 1
      _items.putIfAbsent(
          product.id, () => CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  // 5. Lógica de Remover item atualizada (remove a linha inteira)
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
  
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(productId, (existingItem) {
         existingItem.quantity--;
         return existingItem;
      });
    } else {
      // Se a quantidade é 1, remove o item
      _items.remove(productId);
    }
    notifyListeners();
  }

  // 6. Limpar o carrinho (continua igual)
  void clear() {
    _items.clear();
    notifyListeners();
  }

  Future<void> finalizarPedido(String token) async {
    if (_items.isEmpty) {
      throw Exception("O carrinho está vazio.");
    }

    try {
      // 1. Envia os itens (agora com quantidade) e o token para a API
      await _apiService.criarPedido(items.values.toList(), token);
      
      // 2. Se a chamada à API foi bem-sucedida, limpa o carrinho local
      _items.clear();
      notifyListeners();
      
    } catch (error) {
      // Repassa o erro para a tela (CartScreen) tratar
      rethrow;
    }
  }
}