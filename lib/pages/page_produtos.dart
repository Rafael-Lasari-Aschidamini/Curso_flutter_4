import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_loja/components/app_drawer.dart';
import 'package:projeto_loja/components/produtos_itens.dart';
import 'package:projeto_loja/models/produtos_lista.dart';
import 'package:projeto_loja/utils/rotas_aplicacao.dart';
import 'package:provider/provider.dart';

class PageProduto extends StatelessWidget {
  const PageProduto({super.key});

  @override
  Widget build(BuildContext context) {
    final ProdutosLista produtos = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RotasAplicacao.FORMULARIO_PRODUTO,
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: produtos.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProdutosItens(produtos.items[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
