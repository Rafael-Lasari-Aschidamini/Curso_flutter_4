import 'package:flutter/material.dart';
import 'package:projeto_loja/models/cart.dart';
import 'package:projeto_loja/models/produtos.dart';
import 'package:provider/provider.dart';
import '../utils/rotas_aplicacao.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final produto = Provider.of<Produtos>(context, listen: false);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Produtos>(
            builder: (ctx, produto, _) => IconButton(
              icon: Icon(
                  produto.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                produto.toggleFavorite();
              },
            ),
          ),
          title: Text(
            produto.titulo,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Colors.grey,
            onPressed: () {
              cart.adicionarItem(produto);
            },
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            produto.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              RotasAplicacao.DETALHE_PRODUTO,
              arguments: produto,
            );
          },
        ),
      ),
    );
  }
}
