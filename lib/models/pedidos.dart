import 'package:projeto_loja/models/cart.dart';
import 'package:projeto_loja/models/cart_item.dart';

class Pedidos {
  final String id;
  final double total;
  final List<CartItem> produtos;
  final DateTime data;

  Pedidos({
    required this.id,
    required this.total,
    required this.produtos,
    required this.data,
  });
}
