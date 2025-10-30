import '../models/product_model.dart';

final List<Product> fakeProducts = [
  Product(
      id: 'p1',
      name: 'X-Burger Clássico',
      description:
      'Hambúrguer suculento com queijo derretido, alface, tomate e molho especial da casa.',
      price: 25.90,
      imageUrl: 'assets/images/x_burguer_classico.jpg',
      category: 'Lanches'),
  Product(
      id: 'p2',
      name: 'X-Bacon Supremo',
      description:
      'Hambúrguer artesanal com bacon crocante, queijo cheddar e cebola caramelizada.',
      price: 32.90,
      imageUrl: 'assets/images/x_bacon_supremo.jpg',
      category: 'Lanches'),
  Product(
      id: 'p3',
      name: 'X-Salada Premium',
      description:
      'Hambúrguer grelhado com alface, cenoura, milho e maionese especial.',
      price: 28.90,
      imageUrl: 'assets/images/x_salada_premium.jpg',
      category: 'Lanches'),
  Product(
      id: 'p4',
      name: 'assets/images/X-Frango Especial',
      description:
      'Filé de frango empanado com queijo, alface e molho barbecue.',
      price: 27.90,
      imageUrl: 'assets/images/x_frango_especial.jpg',
      category: 'Lanches'),
  Product(
      id: 'd1',
      name: 'Refrigerante Lata',
      description: 'Coca-Cola, Guaraná ou Fanta - 350ml gelada.',
      price: 5.90,
      imageUrl: 'assets/images/refrigerante_lata.jpg',
      category: 'Bebidas'),
  Product(
      id: 'd2',
      name: 'Suco Natural',
      description: 'Suco de laranja, limão ou morango - 500ml.',
      price: 8.90,
      imageUrl: 'assets/images/suco_natural.jpg',
      category: 'Bebidas'),
  Product(
      id: 'd3',
      name: 'Milkshake',
      description: 'Milkshake cremoso de chocolate, morango ou baunilha - 400ml.',
      price: 12.90,
      imageUrl: 'assets/images/milkshake.jpg',
      category: 'Bebidas'),
  Product(
      id: 'd4',
      name: 'Água Mineral',
      description: 'Água mineral sem gás - 500ml.',
      price: 3.90,
      imageUrl: 'assets/images/agua_mineral.jpg',
      category: 'Bebidas'),
  Product(
      id: 's1',
      name: 'Brownie de Chocolate',
      description: 'Brownie artesanal com pedaços de chocolate e nozes.',
      price: 14.90,
      imageUrl: 'assets/images/brownie_chocolate.jpg',
      category: 'Sobremesas'),
  Product(
      id: 's2',
      name: 'Sorvete Artesanal',
      description: 'Duas bolas de sorvete artesanal com cobertura a escolher.',
      price: 16.90,
      imageUrl: 'assets/images/sorvete_artesanal.jpg',
      category: 'Sobremesas'),
  Product(
      id: 's3',
      name: 'Torta de Limão',
      description: 'Fatia generosa de torta de limão com merengue.',
      price: 13.90,
      imageUrl: 'assets/images/torta_limao.jpg',
      category: 'Sobremesas'),
  Product(
      id: 's4',
      name: 'Pudim Caseiro',
      description: 'Pudim de leite condensado com calda de caramelo.',
      price: 11.90,
      imageUrl: 'assets/images/torta_caseira.jpg',
      category: 'Sobremesas'),
];