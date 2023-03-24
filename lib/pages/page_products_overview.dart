import 'package:flutter/material.dart';
import 'package:projeto_loja/components/app_drawer.dart';
import 'package:projeto_loja/components/grid_produto.dart';
import 'package:projeto_loja/models/cart.dart';
import 'package:projeto_loja/models/produtos_lista.dart';
import 'package:projeto_loja/utils/rotas_aplicacao.dart';
import 'package:provider/provider.dart';
import '../components/badge.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProdutosLista>(
      context,
      listen: false,
    ).carregarProdutos().then(
      (value) {
        setState(
          () {
            _isLoading = false;
          },
        );
      },
    );
  }

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
              setState(
                () {
                  if (valorSelecionado == FiltrarOpcao.Favorite) {
                    _mostrarFavoritos = true;
                    //   provider.mostrarFavoritos();
                  } else {
                    _mostrarFavoritos = false;
                    //   provider.mostrarTodos();
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RotasAplicacao.DETALHE_CARRINHO);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => BadgeVeplex(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridProduto(_mostrarFavoritos),
      drawer: AppDrawer(),
    );
  }
}
