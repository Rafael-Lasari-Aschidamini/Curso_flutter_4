import 'package:flutter/material.dart';
import 'package:projeto_loja/components/grid_produto.dart';
import 'package:projeto_loja/models/produtos_lista.dart';
import 'package:provider/provider.dart';

enum FiltrarOpcao {
  Favorite,
  All,
}

class PageProductsOverview extends StatefulWidget {
  const PageProductsOverview({super.key});

  @override
  State<PageProductsOverview> createState() => _PageProductsOverviewState();
}

class _PageProductsOverviewState extends State<PageProductsOverview> {
  bool _mostrarFavoritos = false;
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProdutosLista>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FiltrarOpcao.Favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FiltrarOpcao.All,
              ),
            ],
            onSelected: (FiltrarOpcao valorSelecionado) {
              setState(() {
                if (valorSelecionado == FiltrarOpcao.Favorite) {
                  _mostrarFavoritos = true;
                  //   provider.mostrarFavoritos();
                } else {
                  _mostrarFavoritos = false;
                  //   provider.mostrarTodos();
                }
              });
            },
          )
        ],
      ),
      body: GridProduto(
        mostrarFavoritos: _mostrarFavoritos,
      ),
    );
  }
}
