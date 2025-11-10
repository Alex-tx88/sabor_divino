// Arquivo: lib/models/product_model.dart

class Product {
  // 1. OS CAMPOS ORIGINAIS
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  // 2. O CONSTRUTOR ORIGINAL
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  // 3. O NOVO CÓDIGO DO SPRINT 3 (AGORA LIMPO)
  // Adicione este construtor de fábrica para "ler" o JSON do Spring
  factory Product.fromJson(Map<String, dynamic> json) {
    // O Spring envia o ID da categoria dentro de um objeto 'categoria'
    String categoryName = json['categoria'] != null
        ? json['categoria']['nome']
        : 'Sem Categoria';

    return Product(
      id: json['id'].toString(), // O Spring envia ID como Long, convertemos
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: categoryName,
    );
  }
}