import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../providers/cart_provider.dart'; 

class ApiService {
  // Se for iOS ou Web/Desktop, pode usar 'localhost'
  final String _baseUrl = "http://localhost:8080/api";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/produtos'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) =>
          Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    if (category == 'Todos') {
      return fetchProducts();
    }
    
    final response = await
        http.get(Uri.parse('$_baseUrl/produtos/categoria/$category'));

    // (mesma lógica de parse do fetchProducts)
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) =>
          Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Falha ao carregar produtos da categoria $category');
    }
  }
  
  Future<void> criarPedido(List<CartItem> itens, String token) async {
    final url = Uri.parse('$_baseUrl/pedidos');
    
    // 1. Montar o cabeçalho com o Token JWT
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Envia o token de login
    };

    // 2. Converter os CartItems para o formato DTO esperado pelo backend
    final body = json.encode({
      'itens': itens.map((item) => {
        'produtoId': item.product.id,
        'quantidade': item.quantity,
      }).toList(),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        // Se o servidor não retornar OK (ex: 403 Forbidden se o token for inválido)
        throw Exception('Falha ao criar o pedido. Status: ${response.statusCode}');
      }
      // Se deu 200 OK, o pedido foi criado
    } catch (e) {
      rethrow;
    }
  }
}