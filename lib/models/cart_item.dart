class CartItem {
  final String id;
  final String produtoId;
  final String nome;
  final int quantidade;
  final double valor;

  CartItem({
    required this.id,
    required this.produtoId,
    required this.nome,
    required this.quantidade,
    required this.valor,
  });
}
