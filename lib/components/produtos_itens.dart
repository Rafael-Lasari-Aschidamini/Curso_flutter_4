import 'package:flutter/material.dart';
import 'package:projeto_loja/models/produtos.dart';
import 'package:projeto_loja/utils/rotas_aplicacao.dart';
import 'package:provider/provider.dart';

import '../models/produtos_lista.dart';

class ProdutosItens extends StatelessWidget {
  const ProdutosItens(this.produtos, {super.key});

  final Produtos produtos;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produtos.imageUrl),
      ),
      title: Text(produtos.titulo),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  RotasAplicacao.FORMULARIO_PRODUTO,
                  arguments: produtos,
                );
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProdutosLista>(context, listen: false)
                    .removerProduto(produtos);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            )
          ],
        ),
      ),
    );
  }
}
